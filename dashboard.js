let eventLabels = ["On_Stage Event 1", "On_Stage Event 2", "On_Stage Event 3", "On_Stage Event 4", "On_Stage Event 5", "Off_Stage Event 1", "Off_Stage Event 2", "Off_Stage Event 3", "Off_Stage Event 4", "Off_Stage Event 5", "Group Event"];
// const individual_events = ["Story Writing","Oil Painting","Debate","Poetry Writing","Light Music","Recitation","Bharathanatyam","Mohiniyattam","Monoact","Kathakali","Extempore"];
// const group_events = ["Nadan Pattu", "Vanchi Pattu", "Thiruvathira"];

let individual_events_on = [];
let individual_events_off = [];
let group_events = [];

function loadEventLists() {
    fetch('get_events.php')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                console.error(data.error);
                return;
            }

            individual_events_on = data.individual_on;
            individual_events_off = data.individual_off;

            group_events = data.group;

            // console.log("Individual Events On_Stage:", individual_events_on);
            // console.log("Individual Events Off_Stage:", individual_events_off);

            // console.log("Group Events:", group_events);

            // You can now use these to populate dropdowns, etc.
            // populateEventDropdowns();
        })
        .catch(error => {
            console.error("Error loading events:", error);
        });
}

// Call this on page load
document.addEventListener("DOMContentLoaded", loadEventLists);





// Leaderboard state manager

const leaderboardManager = {
    state: { isOn: true, endTime: null },
    channel: new BroadcastChannel('leaderboard_updates'),

    async init() {
        try {
            const res = await fetch('leaderboard_status.php');
            const data = await res.json();

            if (data.success) {
                this.state = {
                    isOn: data.isOn,
                    endTime: data.endTime
                };

                // Check if expired
                if (!this.state.isOn && this.state.endTime && Date.now() > this.state.endTime) {
                    await this.setState(true);
                }

                this.updateButton();
                this.setupListeners();

                // Optional: Auto-enable when time expires (check every 3 sec)
                setInterval(() => {
                    if (!this.state.isOn && this.state.endTime && Date.now() > this.state.endTime) {
                        this.setState(true);
                    }
                }, 3000);
            } else {
                console.error("Failed to load state:", data.error);
            }
        } catch (err) {
            console.error('Error fetching leaderboard status:', err);
        }
    },

    async setState(isOn, duration = 0) {
        const endTime = isOn ? null : Date.now() + duration;
        this.state = { isOn, endTime };

        try {
            const res = await fetch('leaderboard_status.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(this.state)
            });

            const result = await res.json();
            if (!result.success) {
                console.error("Failed to update state:", result);
                return;
            }

            this.channel.postMessage({ type: 'stateUpdate', state: this.state });

            if (!isOn && duration > 0) {
                setTimeout(() => this.setState(true), duration);
            }

            this.updateButton();
        } catch (err) {
            console.error('Error updating leaderboard state:', err);
        }
    },

    updateButton() {
        const btn = document.getElementById('leader-btn');
        if (!btn) return;

        btn.textContent = this.state.isOn ? 'Leaderboard ON' : 'Leaderboard OFF';
        btn.style.backgroundColor = '#cd0947';
    },

    setupListeners() {
        this.channel.addEventListener('message', (e) => {
            if (e.data.type === 'stateUpdate') {
                this.state = e.data.state;
                this.updateButton();
            }
        });
    }
};

// Toggle button logic
function toggleLeaderboard() {
    if (leaderboardManager.state.isOn) {
        document.getElementById('leaderboardOffModal').style.display = 'block';
    } else {
        leaderboardManager.setState(true);
    }
}

function confirmLeaderboardOff() {
    const hours = parseInt(document.getElementById('offHours').value) || 0;
    const minutes = parseInt(document.getElementById('offMinutes').value) || 0;
    const seconds = parseInt(document.getElementById('offSeconds').value) || 0;

    const duration = (hours * 3600 + minutes * 60 + seconds) * 1000;
    leaderboardManager.setState(false, duration);
    closeModal();
}

function closeModal() {
    document.getElementById('leaderboardOffModal').style.display = 'none';
}

// Init
document.addEventListener('DOMContentLoaded', () => leaderboardManager.init());


// Registration Management System
const registrationManager = {
    status: true,
    init() {
        fetch('registration_status.php')
            .then(res => res.json())
            .then(data => {
                this.status = data.status;
                this.updateButton();
                if (window.location.pathname.includes('kalotsavam.html') && !this.status) {
                    window.location.href = 'closed.html';
                }
            });
    },
    toggleStatus() {
        this.status = !this.status;
        fetch('registration_status.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ status: this.status })
        })
        .then(res => res.json())
        .then(() => {
            this.updateButton();
            alert(`Registration is now ${this.status ? 'open' : 'closed'}.`);
        });
        return this.status;
    },
    updateButton() {
        const btn = document.getElementById('registration-btn');
        if (btn) {
            btn.textContent = this.status ? 'Close Registration' : 'Open Registration';
            btn.classList.toggle('closed', !this.status);
        }
    }
};

document.addEventListener('DOMContentLoaded', () => registrationManager.init());



function logout() {
    window.location.href = "logout.php";
}

function downloadExcel() {
    let table = document.getElementById("eventTable");
    let tableClone = table.cloneNode(true);
    
    // Process all cells in the table
    Array.from(tableClone.querySelectorAll('td')).forEach(cell => {
        if (cell.querySelector('select')) {
            // This is a registered event - just show "Yes" regardless of rank selection
            cell.textContent = 'Yes';
        } else {
            // Check for any "No" indication
            const content = cell.textContent.trim();
            if (content === "No" || content.includes("No (Not Registered)")) {
                cell.textContent = 'No';
            }
        }
    });
    
    // Convert to worksheet
    let ws = XLSX.utils.table_to_sheet(tableClone);
    
    // Create workbook and export
    let wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Event Data");
    XLSX.writeFile(wb, "Event_Registration.xlsx");
}


document.getElementById("submitScores").addEventListener("click", function () {
    let rankUpdates = [];

    document.querySelectorAll("tbody tr").forEach(row => {
        let name = row.querySelector("td:nth-child(1)")?.textContent.trim() || "";
        let rollNumber = row.querySelector("td:nth-child(2)")?.textContent.trim() || "";
        let gender = row.querySelector("td:nth-child(3)")?.textContent.trim() || "";
        let degree = row.querySelector("td:nth-child(4)")?.textContent.trim() || "";
        let year = row.querySelector("td:nth-child(5)")?.textContent.trim() || "";
        let chestNumber = row.querySelector("td:nth-child(7)")?.textContent.trim() || "";

        row.querySelectorAll("td[data-event]").forEach(td => {
            let select = td.querySelector("select");
            let rank = select?.value || "";

            if (rank) {
                let eventName = td.getAttribute("data-event");
                rankUpdates.push({ name, rollNumber,gender, degree, year, chestNumber, eventName, rank });
            }
        });
    });
    // console.log("Rank updates to be sent:", rankUpdates);
    if (rankUpdates.length > 0) {
        fetch("update_rank.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(rankUpdates)
        })
        .then(response => response.text())
        .then(data => {
            // console.log("Ranks updated successfully!", data);
            alert("Ranks updated successfully!");
            fetchEventResults(); // Reload ranks after update
        })
        .catch(error => console.error("Error updating ranks:", error));
    }
});

let eventData = [];
document.addEventListener("DOMContentLoaded", function () {
    
    let eventList = new Set();

    fetch("event.php")
        .then(response => response.json())
        .then(data => {
            // console.log("Event Registration Data:", data);
            if (data.length === 0) return;

            eventData = data;
            extractEvents(eventData);
            populateFilters(eventData);
            updateTable(eventData);
            fetchEventResults(); // Fetch event results
        })
        .catch(error => console.error("Error fetching event.php data:", error));

    function extractEvents(data) {
        eventList.clear();
        data.forEach(row => {
            [row.Event1, row.Event2, row.Event3, row.Event4, row.Event5, row.Event6, row.Event7, row.Event8, row.Event9, row.Event10, row.Group_event].forEach(event => {
                if (event) eventList.add(event);
            });
        });

        const headerRow = document.querySelector("#eventTable thead tr");
        headerRow.innerHTML = `
            <th>Name</th>
            <th>Roll Number</th>
            <th>Gender</th>
            <th>Degree</th>
            <th>Year</th>
            <th>Phone Number</th>
            <th>Chest Number</th>
        `;
        eventList.forEach(event => {
            const th = document.createElement("th");
            th.textContent = event;
            th.setAttribute("data-event", event); // Attach event name to header
            headerRow.appendChild(th);
        });
    }
    
    function populateFilters(data) {
        
        const eventFilter = document.getElementById("eventFilter");
        eventList.forEach(event => {
            let option = document.createElement("option");
            option.value = event;
            option.textContent = event;
            eventFilter.appendChild(option);
        });

        document.getElementById("degreeFilter").addEventListener("change", function () {
            const degree = this.value;
            const yearFilter = document.getElementById("yearFilter");
        
            // Clear existing year options
            yearFilter.innerHTML = "";
        
            // Default option
            const defaultOption = document.createElement("option");
            defaultOption.value = "";
            defaultOption.textContent = "All";
            yearFilter.appendChild(defaultOption);
        
            // Define allowed years based on selected degree
            let allowedYears = [];
            if (degree === "BSc") {
                allowedYears = ["1st", "2nd", "3rd"];
            } else if (degree === "MSc") {
                allowedYears = ["1st", "2nd"];
            } else {
                allowedYears = ["1st", "2nd", "3rd"];
            }
        
            // Add filtered year options
            allowedYears.forEach(year => {
                const option = document.createElement("option");
                option.value = year;
                option.textContent = `${year} Year`;
                yearFilter.appendChild(option);
            });
        });
        
    }
    function updateTable(data) {
        const tbody = document.querySelector("#eventTable tbody");
        tbody.innerHTML = "";
    
        const genderFilter = document.getElementById("genderFilter").value;
        const degreeFilter = document.getElementById("degreeFilter").value;
        const yearFilter = document.getElementById("yearFilter").value;
        const eventFilter = document.getElementById("eventFilter").value;

        

        let visibleEvents = new Set(eventList);
        if (eventFilter && eventFilter !== "All") {
            visibleEvents = new Set([eventFilter]);
        }
    
        const filteredData = data.filter(row =>
            (!genderFilter || row.Gender === genderFilter) &&
            (!degreeFilter || row.Degree === degreeFilter) &&
            (!yearFilter || row.Year === yearFilter) &&
            (!eventFilter || row.Event1 === eventFilter || row.Event2 === eventFilter || row.Event3 === eventFilter || row.Event4 === eventFilter || row.Event5 === eventFilter || row.Event6 === eventFilter || row.Event7 === eventFilter || row.Event8 === eventFilter || row.Event9 === eventFilter || row.Event10 === eventFilter || row.Group_event === eventFilter)
        );
    
        const headerRow = document.querySelector("#eventTable thead tr");
        headerRow.innerHTML = `
            <th>Name</th>
            <th>Roll Number</th>
            <th>Gender</th>
            <th>Degree</th>
            <th>Year</th>
            <th>Phone Number</th>
            <th>Chest Number</th>
        `;
    
        visibleEvents.forEach(event => {
            const th = document.createElement("th");
            th.textContent = event;
            th.setAttribute("data-event", event); // Store event name
            headerRow.appendChild(th);
        });
    
        filteredData.forEach(row => {
            const tr = document.createElement("tr");
            tr.innerHTML = `
                <td>${row.Name}</td>
                <td>${row.Roll_Number}</td>
                <td>${row.Gender}</td>
                <td>${row.Degree}</td>
                <td>${row.Year}</td>
                <td>${row.Phone_Number}</td>
                <td>${row.Chest_Number}</td>
            `;
            visibleEvents.forEach(event => {
                const td = document.createElement("td");
                td.setAttribute("data-event", event);
            
                const events = [row.Event1, row.Event2, row.Event3, row.Event4, row.Event5, row.Event6, row.Event7, row.Event8, row.Event9, row.Event10, row.Group_event];
                const backups = [row.EB1, row.EB2, row.EB3, row.EB4, row.EB5, row.EB6, row.EB7, row.EB8, row.EB9, row.EB10, row.GB];
            
                const isInCurrent = events.includes(event);
                const isInBackup = backups.includes(event);
            
                const isAdded = isInCurrent && !isInBackup;
                const isRemoved = !isInCurrent && isInBackup;
                const isUnchanged = isInCurrent && isInBackup;
            
                if (isInCurrent) {
                    td.classList.add("yes");
                    if (isUnchanged) td.classList.add("green");
                    if (isAdded) td.classList.add("yellow");
            
                    const select = document.createElement("select");
                    select.innerHTML = `
                        <option value="Yes" value="No">Yes</option>
                        <option value="First">First</option>
                        <option value="Second">Second</option>
                        <option value="Third">Third</option>
                    `;
                    select.value = "Yes"; // default selection
                    td.appendChild(select);
                } else {
                    td.textContent = "No";
                    td.classList.add("no");
            
                    if (isRemoved) {
                        td.classList.add("yellow"); // previously registered but removed
                    } else {
                        td.classList.add("red");    // never registered
                    }
                }
            
                tr.appendChild(td);
            });
            
            
    
            tbody.appendChild(tr);
        });
    
        fetchEventResults(); // Reload event results after filtering
    }
    
    document.getElementById("genderFilter").addEventListener("change", () => updateTable(eventData));
    document.getElementById("degreeFilter").addEventListener("change", () => updateTable(eventData));
    document.getElementById("yearFilter").addEventListener("change", () => updateTable(eventData));
    document.getElementById("eventFilter").addEventListener("change", () => updateTable(eventData));
});

function fetchEventResults() {
    // console.log("Fetching event results...");
    fetch("event_result.php?t=" + new Date().getTime())
        .then(response => response.json())
        .then(resultData => {
            // console.log("Event Result Data:", resultData);
            document.querySelectorAll("#eventTable tbody tr").forEach(row => {
                let rollNumber = row.querySelector("td:nth-child(2)").textContent.trim();

                row.querySelectorAll("td[data-event]").forEach(td => {
                    let select = td.querySelector("select");
                    let eventName = td.getAttribute("data-event");

                    let participantResult = resultData.find(result =>
                        result.Roll_Number === rollNumber && result.Event === eventName
                    );

                    if (participantResult) {
                        select.value = participantResult.Rank;
                        // console.log(`Updating: ${rollNumber} - ${eventName} → ${participantResult.Rank}`);
                    }
                });
            });
        })
        .catch(error => console.error("Error fetching event_result.php data:", error));
}

function openEditDialog() {
    document.getElementById("editDialog").style.display = "flex";
}

function closeEditDialog() {
    document.getElementById("editDialog").style.display = "none";

    // Clear the search bar input
    let searchBar = document.getElementById("searchChestNumber");
    if (searchBar) searchBar.value = ""; 

    // Check and reset input fields
    let nameField = document.getElementById("edit_name");
    if (nameField) nameField.value = "";

    let rollField = document.getElementById("edit_roll");
    if (rollField) rollField.value = "";

    let phoneField = document.getElementById("edit_phone");
    if (phoneField) phoneField.value = "";

    let genderField = document.getElementById("edit_gender");
    if (genderField) genderField.value = "";

    let degreeField = document.getElementById("edit_degree");
    if (degreeField) degreeField.value = "";

    let yearField = document.getElementById("edit_year");
    if (yearField) yearField.innerHTML = '<option value="">Year</option>';

    let courseField = document.getElementById("edit_course");
    if (courseField) courseField.innerHTML = '<option value="">Course</option>';

    // Check and clear event dropdowns
    document.querySelectorAll(".edit_event").forEach(select => {
        if (select) select.innerHTML = '<option value="">Select Event</option>';
    });

    // Check and clear event table
    let eventTableBody = document.getElementById("eventTableBody");
    if (eventTableBody) eventTableBody.innerHTML = "";
}



function searchParticipant() {
    let chestNumber = document.getElementById("searchChestNumber").value.trim();
    if (!chestNumber) {
        alert("Please enter a Chest Number");
        return;
    }

    fetch("event.php")
        .then(response => response.json())
        .then(data => {
            let participant = data.find(row => row.Chest_Number == chestNumber);
            if (!participant) {
                alert("Participant not found");
                return;
            }

            // Populate static fields
            document.getElementById("p_name").innerHTML = `<input type="text" id="edit_name" value="${participant.Name}">`;
            document.getElementById("p_roll").innerHTML = `<input type="text" id="edit_roll" value="${participant.Roll_Number}">`;
            document.getElementById("p_phone").innerHTML = `<input type="text" id="edit_phone" value="${participant.Phone_Number}">`;

            // Populate dropdowns with participant data
            document.getElementById("edit_gender").value = participant.Gender;
            document.getElementById("edit_degree").value = participant.Degree;
            // Trigger change event to dynamically load correct year options
            document.getElementById("edit_degree").dispatchEvent(new Event("change"));

            // Set the correct year after dropdown updates
            setTimeout(() => {
                document.getElementById("edit_year").value = participant.Year;
                document.getElementById("edit_course").value = participant.Course; // Set the course
            }, 100);


            
            let eventTableBody = document.getElementById("eventTableBody");
            eventTableBody.innerHTML = "";
            
            [participant.Event1, participant.Event2, participant.Event3, participant.Event4, participant.Event5, participant.Event6, participant.Event7, participant.Event8, participant.Event9, participant.Event10, participant.Group_event].forEach((event, index) => {
                let row = document.createElement("tr");
            
                // Label Column
                let labelCell = document.createElement("td");
                labelCell.textContent = eventLabels[index]; 
                row.appendChild(labelCell);
            
                // Event Name Dropdown Column
                let eventCell = document.createElement("td");
                let select = document.createElement("select");
                select.classList.add("edit_event");
                select.id = `edit_event${index + 1}`;
                // console.log(`Created select with ID: ${select.id}`);
            
                // Populate dropdown with correct event list
                let eventOptions;
                if (index < 5) {
                    eventOptions = individual_events_on;
                } else if (index < 10) {
                    eventOptions = individual_events_off;
                } else {
                    eventOptions = group_events;
                }

                
                select.innerHTML = `<option value="">Select Event</option>` + 
                    eventOptions.map(ev => `<option value="${ev}" ${event === ev ? "selected" : ""}>${ev}</option>`).join("");
            
                eventCell.appendChild(select);
                row.appendChild(eventCell);
            
                eventTableBody.appendChild(row);
            });
                        openEditDialog(); // Show the modal
        })
        .catch(error => console.error("Error fetching event data:", error));
}

document.getElementById("edit_degree").addEventListener("change", function () {
    const degree = this.value;
    const yearSelect = document.getElementById("edit_year");
    const courseSelect = document.getElementById("edit_course");

    yearSelect.innerHTML = '<option value="">Year</option>';
    courseSelect.innerHTML = '<option value="">Course</option>';

    if (degree === "BSc") {
        yearSelect.innerHTML += `
            <option value="1st">1st Year</option>
            <option value="2nd">2nd Year</option>
            <option value="3rd">3rd Year</option>
        `;
        courseSelect.innerHTML += `
            <option value="Biotechnology">Biotechnology</option>
            <option value="Microbiology">Microbiology</option>
        `;
    } else if (degree === "MSc") {
        yearSelect.innerHTML += `
            <option value="1st">1st Year</option>
            <option value="2nd">2nd Year</option>
        `;
        courseSelect.innerHTML += `
            <option value="Biotechnology">Biotechnology</option>
            <option value="Microbiology">Microbiology</option>
            <option value="Bioinformatics">Bioinformatics</option>
        `;
    }
});


document.getElementById("updateParticipant").addEventListener("click", function () {
    let chestNumber = document.getElementById("searchChestNumber").value.trim(); // Get chest number from search bar
    
    let updatedData = {
        rollNumber: document.getElementById("edit_roll").value.trim(),
        name: document.getElementById("edit_name").value.trim(),
        gender: document.getElementById("edit_gender").value,
        degree: document.getElementById("edit_degree").value,
        year: document.getElementById("edit_year").value,
        course: document.getElementById("edit_course").value,
        phone: document.getElementById("edit_phone").value,
        chestNumber: chestNumber,  // **Include chest number**
        event1: document.getElementById("edit_event1").value,
        event2: document.getElementById("edit_event2").value,
        event3: document.getElementById("edit_event3").value,
        event4: document.getElementById("edit_event4").value,
        event5: document.getElementById("edit_event5").value,
        event6: document.getElementById("edit_event6").value,
        event7: document.getElementById("edit_event7").value,
        event8: document.getElementById("edit_event8").value,
        event9: document.getElementById("edit_event9").value,
        event10: document.getElementById("edit_event10").value,
        groupEvent: document.getElementById("edit_event11").value
    };

    fetch("update_details.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updatedData)
    })
    .then(response => response.text())
    .then(data => {
        // console.log("Response from server:", data);
        alert("Participant updated successfully!");
        closeEditDialog();  // Close modal
        fetchEventResults(); // Refresh the table
        location.reload();
    })
    .catch(error => console.error("Error updating participant:", error));
});


document.getElementById("deleteParticipant").addEventListener("click", function () {
    let chestNumber = document.getElementById("searchChestNumber").value.trim(); // Get chest number from search bar
    
    let deleteData = {
        chestNumber: chestNumber,  // **Include chest number**
    };


    fetch("delete_participant.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(deleteData)
    })
    .then(response => response.text())
    .then(data => {
        // console.log("Response from server:", data);
        alert("Participant Deleted successfully!");
        closeEditDialog();  // Close modal
        fetchEventResults(); // Refresh the table
        location.reload();
    })
    .catch(error => console.error("Error Deleting participant:", error));
});



// disable function

document.addEventListener("DOMContentLoaded", function () {
    loadDisabledEvents(); // Load disabled events on page load
});

// Function to open the disable event dialog
function openDisableDialog() {
    fetch("get_disabled_events.php")
        .then(response => response.json())
        .then(disabledEvents => {
            let eventList = [...document.querySelectorAll("#eventTable thead th")].slice(7); // Skip first 7 columns
            let dialog = document.getElementById("disableEventDialog");
            let eventContainer = document.getElementById("eventCheckboxes");
            eventContainer.innerHTML = "";

            eventList.forEach((th, index) => {
                let eventName = th.textContent.trim();
                let checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.value = eventName;
                checkbox.checked = disabledEvents.includes(eventName); // Check if event is disabled
                checkbox.id = `disable_${index}`;

                let label = document.createElement("label");
                label.htmlFor = `disable_${index}`;
                label.textContent = eventName;

                let div = document.createElement("div");
                div.appendChild(checkbox);
                div.appendChild(label);
                eventContainer.appendChild(div);
            });

            dialog.style.display = "block";
        })
        .catch(error => console.error("Error fetching disabled events:", error));
}


// Function to disable selected events
function disableSelectedEvents() {
    let checkboxes = document.querySelectorAll("#eventCheckboxes input[type='checkbox']");
    let disabledEvents = [];

    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            disabledEvents.push(checkbox.value);
        }
    });

    fetch("save_disabled_events.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ disabledEvents })
    })
    .then(response => response.text())
    .then(data => {
        // console.log("Disabled events updated:", data);
        applyDisabledEvents();
        closeDisableDialog();
    })
    .catch(error => console.error("Error disabling events:", error));
}

function enableSelectedEvents() {
    let checkboxes = document.querySelectorAll("#eventCheckboxes input[type='checkbox']");
    let disabledEvents = [];

    checkboxes.forEach(checkbox => {
        // Uncheck the checkbox to enable the event
        if (checkbox.checked) {
            checkbox.checked = false;
        }
        // Now none are checked, so disabledEvents will be empty
    });

    // Send the updated disabled list (empty or only those still checked)
    fetch("save_disabled_events.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ disabledEvents }) // will be empty or updated
    })
    .then(response => response.text())
    .then(data => {
        // console.log("Events enabled:", data);
        applyDisabledEvents();   // Refresh UI to reflect enabled state
        closeDisableDialog();    // Close dialog
    })
    .catch(error => console.error("Error enabling events:", error));
}



// Function to apply disabled events (gray out and prevent interaction)
function applyDisabledEvents() {
    fetch("get_disabled_events.php")
        .then(response => response.json())
        .then(disabledEvents => {
            let table = document.getElementById("eventTable");

            // Get all column headers (th) starting from the 8th column (index 7)
            let headers = [...table.querySelectorAll("thead th")].slice(7);

            headers.forEach((th, index) => {
                let eventName = th.textContent.trim();
                let isDisabled = disabledEvents.includes(eventName);

                // Apply styles to header
                th.style.backgroundColor = isDisabled ? "gray" : "#cd0947";
                th.style.color = isDisabled ? "lightgray" : "white";

                // Find the corresponding column index (adjusting for first 7 columns)
                let colIndex = index + 8;

                // Apply styles & disable input fields in the corresponding column
                table.querySelectorAll(`tbody tr td:nth-child(${colIndex})`).forEach(td => {
                    td.style.backgroundColor = isDisabled ? "lightgray" : "";

                    // Disable dropdown/select fields within the disabled event columns
                    let select = td.querySelector("select");
                    if (select) {
                        select.disabled = isDisabled;
                    }
                });
            });
        })
        .catch(error => console.error("Error fetching disabled events:", error));
}

// Function to check if an event is disabled
function isEventDisabled(eventName) {
    let disabledEvents = JSON.parse(localStorage.getItem("disabledEvents")) || [];
    return disabledEvents.includes(eventName);
}

// Function to load disabled events on page load
function loadDisabledEvents() {
    applyDisabledEvents();
}

// Function to close the disable event dialog
function closeDisableDialog() {
    document.getElementById("disableEventDialog").style.display = "none";
}


function addevent() {
    document.getElementById("addEventDialog").style.display = "block";
}

function closeAddEventDialog() {
    document.getElementById("addEventDialog").style.display = "none";
    document.getElementById("eventInputs").innerHTML = '<input type="text" class="event-input" placeholder="Enter event name"><br>';
}



// Add event 

const openAddEventDialog = () => {
  document.getElementById("addEventDialog").style.display = "block";
};

const closeEventDialog = () => {
  document.getElementById("addEventDialog").style.display = "none";
  document.getElementById("eventInputs").innerHTML = "";
};

const addEventInput = (isGroup) => {
  const wrapper = document.createElement("div");
  wrapper.className = "event-wrapper";
  wrapper.style.marginBottom = "10px";

  const input = document.createElement("input");
  input.type = "text";
  input.placeholder = isGroup ? "Group Event Name" : "Individual Event Name";
  input.dataset.type = isGroup ? "group" : "individual";
  input.className = "event-name";

  const select = document.createElement("select");
  select.className = "event-stage";
  select.innerHTML = `
    <option value="on">On Stage</option>
    <option value="off">Off Stage</option>
  `;

  const removeBtn = document.createElement("button");
  removeBtn.textContent = "Remove";
  removeBtn.type = "button";
  removeBtn.onclick = () => wrapper.remove();

  wrapper.appendChild(input);
  wrapper.appendChild(select);
  wrapper.appendChild(removeBtn);

  document.getElementById("eventInputs").appendChild(wrapper);
};

const submitNewEvents = () => {
  const wrappers = document.querySelectorAll(".event-wrapper");
  const newEvents = [];

  wrappers.forEach(wrapper => {
    const nameInput = wrapper.querySelector(".event-name");
    const stageSelect = wrapper.querySelector(".event-stage");

    const name = nameInput.value.trim();
    const type = nameInput.dataset.type;
    const stage = stageSelect.value;

    if (name) newEvents.push({ name, type, stage });
  });

  if (!newEvents.length) {
    alert("Please enter at least one event.");
    return;
  }

  fetch("insert_events.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ events: newEvents })
  })
    .then(res => res.text())
    .then(response => {
      alert(response);
      document.getElementById("eventInputs").innerHTML = "";
      window.location.reload();
    })
    .catch(err => {
      console.error("Error adding events:", err);
      alert("Error adding events.");
    });
};


const score = () => {
    document.getElementById("updatescoreDialog").style.display = "block";
};
  

function closeupdatescoreDialog() {
    document.getElementById("updatescoreDialog").style.display = "none";

    // Reset the form fields
    const form = document.getElementById("scoreForm");
    form.reset(); // resets all form elements to default values

    // Optional: manually reset dropdowns/input if needed
    // form.event_type.value = "";
    // form.rank.value = "";
    // document.getElementById("scoreinput").value = "";
}



// update score
document.addEventListener("DOMContentLoaded", function () {
    const scoreForm = document.getElementById("scoreForm");
    if (!scoreForm) return; // Avoid error if form doesn't exist

    scoreForm.addEventListener("submit", function (e) {
        e.preventDefault();

        const formData = new FormData(this);

        fetch("update_scores.php", {
            method: "POST",
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            const messageDiv = document.getElementById("message");
            if (messageDiv) {
                messageDiv.textContent = data;
                messageDiv.style.color = "green";
            }
            
            // Close the dialog after successful submission
            closeupdatescoreDialog();
            
            // Optional: Clear the message after a few seconds
            setTimeout(() => {
                if (messageDiv) messageDiv.textContent = "";
            }, 3000);
        })
        .catch(error => {
            console.error("Error:", error);
            const messageDiv = document.getElementById("message");
            if (messageDiv) {
                messageDiv.textContent = "Error updating score.";
                messageDiv.style.color = "red";
            }
        });
    });
});