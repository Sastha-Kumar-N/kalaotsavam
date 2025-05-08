
function logout() {
    window.location.href = "logout.php";
}

function downloadExcel() {
    let table = document.getElementById("eventTable");
    let ws = XLSX.utils.table_to_sheet(table);
    let wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Event Data");
    XLSX.writeFile(wb, "Event_Registration.xlsx");
}

document.getElementById("submitScores").addEventListener("click", function () {
    let rankUpdates = [];

    document.querySelectorAll("tbody tr").forEach(row => {
        let name = row.querySelector("td:nth-child(1)")?.textContent.trim() || "";
        let rollNumber = row.querySelector("td:nth-child(2)")?.textContent.trim() || "";
        let degree = row.querySelector("td:nth-child(4)")?.textContent.trim() || "";
        let year = row.querySelector("td:nth-child(5)")?.textContent.trim() || "";
        let chestNumber = row.querySelector("td:nth-child(7)")?.textContent.trim() || "";

        row.querySelectorAll("td select").forEach((select, index) => {
            let rank = select.value;
            if (rank) {
                let eventName = document.querySelector(`#eventTable thead tr th:nth-child(${index + 8})`)?.textContent.trim() || "";
                rankUpdates.push({ name, rollNumber, degree, year, chestNumber, eventName, rank });
            }
        });
    });

    if (rankUpdates.length > 0) {
        fetch("update_rank.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(rankUpdates)
        })
        .then(response => response.text())
        .then(data => {
            console.log("Ranks updated successfully!", data);
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
            console.log("Event Registration Data:", data);
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
            if (row.Event1) eventList.add(row.Event1);
            if (row.Event2) eventList.add(row.Event2);
            if (row.Event3) eventList.add(row.Event3);
            if (row.Event4) eventList.add(row.Event4);
            if (row.Event5) eventList.add(row.Event5);

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
    
        // Filter data based on selected options
        const filteredData = data.filter(row =>
            (!genderFilter || row.Gender === genderFilter) &&
            (!degreeFilter || row.Degree === degreeFilter) &&
            (!yearFilter || row.Year === yearFilter) &&
            (!eventFilter || row.Event1 === eventFilter || row.Event2 === eventFilter || row.Event3 === eventFilter || row.Event4 === eventFilter || row.Event5 === eventFilter)
        );
    
        // Update table headers dynamically
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
            headerRow.appendChild(th);
        });
    
        // Populate table with filtered data
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
                if (row.Event1 === event || row.Event2 === event || row.Event3 === event || row.Event4 === event || row.Event5 === event) {
                    td.classList.add("yes");
                    let select = document.createElement("select");
                    select.innerHTML = `
                        <option value="Yes">Yes</option>
                        <option value="First">First</option>
                        <option value="Second">Second</option>
                        <option value="Third">Third</option>
                    `;
                    td.appendChild(select);
                } else {
                    td.classList.add("no");
                    td.textContent = "No";
                }
                
                tr.appendChild(td);
            });
    
            tbody.appendChild(tr);
        });
    
        // Style header for better visibility
        document.querySelectorAll("th").forEach(th => {
            th.style.backgroundColor = "#007BFF";
            th.style.color = "white";
        });
    
        fetchEventResults(); // Reload event results after filtering
    }
    

    document.getElementById("genderFilter").addEventListener("change", () => updateTable(eventData));
    document.getElementById("degreeFilter").addEventListener("change", () => updateTable(eventData));
    document.getElementById("yearFilter").addEventListener("change", () => updateTable(eventData));
    document.getElementById("eventFilter").addEventListener("change", () => updateTable(eventData));

});

function fetchEventResults() {
    console.log("Fetching event results...");
    fetch("event_result.php?t=" + new Date().getTime())
        .then(response => response.json())
        .then(resultData => {
            console.log("Event Result Data:", resultData);
            document.querySelectorAll("#eventTable tbody tr").forEach(row => {
                let rollNumber = row.querySelector("td:nth-child(2)").textContent.trim();

                row.querySelectorAll("td select").forEach((select, index) => {
                    let eventName = document.querySelector(`#eventTable thead tr th:nth-child(${index + 8})`)?.textContent.trim() || "";
                    let participantResult = resultData.find(result =>
                        result.Roll_Number === rollNumber && result.Event === eventName
                    );

                    if (participantResult) {
                        select.value = participantResult.Rank;
                        console.log(`Updating: ${rollNumber} - ${eventName} → ${participantResult.Rank}`);
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

    // Reset participant details
    document.getElementById("p_name").textContent = "";
    document.getElementById("p_roll").textContent = "";
    document.getElementById("p_gender").textContent = "";
    document.getElementById("p_degree").textContent = "";
    document.getElementById("p_year").textContent = "";
    document.getElementById("p_phone").textContent = "";

    // Clear registered events table
    document.getElementById("eventTableBody").innerHTML = "";

    // Clear input field for searching
    document.getElementById("searchChestNumber").value = "";
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

            // Convert participant details into editable fields
            document.getElementById("p_name").innerHTML = `<input type="text" id="edit_name" value="${participant.Name}">`;
            document.getElementById("p_roll").innerHTML = `<input type="text" id="edit_roll" value="${participant.Roll_Number}" readonly>`;
            document.getElementById("p_gender").innerHTML = `<input type="text" id="edit_gender" value="${participant.Gender}">`;
            document.getElementById("p_degree").innerHTML = `<input type="text" id="edit_degree" value="${participant.Degree}">`;
            document.getElementById("p_year").innerHTML = `<input type="text" id="edit_year" value="${participant.Year}">`;
            document.getElementById("p_phone").innerHTML = `<input type="text" id="edit_phone" value="${participant.Phone_Number}">`;

            // Labels for the events
            let eventLabels = ["Event 1", "Event 2", "Event 3", "Event 4", "Group Event"];

            // Populate registered events with labels
            let eventTableBody = document.getElementById("eventTableBody");
            eventTableBody.innerHTML = "";

            [participant.Event1, participant.Event2, participant.Event3, participant.Event4, participant.Event5].forEach((event, index) => {
                let row = document.createElement("tr");

                // Label Column
                let labelCell = document.createElement("td");
                labelCell.textContent = eventLabels[index]; 
                row.appendChild(labelCell);

                // Event Name Input Column
                let eventCell = document.createElement("td");
                eventCell.innerHTML = `<input type="text" class="edit_event" id="edit_event${index + 1}" value="${event || ''}">`;
                row.appendChild(eventCell);

                eventTableBody.appendChild(row);
            });

            // Open edit modal
            openEditDialog();
        })
        .catch(error => console.error("Error fetching event data:", error));
}



document.getElementById("updateParticipant").addEventListener("click", function () {
    alert("Update functionality to be implemented");
});

