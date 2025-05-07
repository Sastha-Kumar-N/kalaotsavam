let individual_on = [];
let individual_off = []
let group_events = [];

function loadEventLists(callback) {
    fetch('get_events.php')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                console.error(data.error);
                return;
            }

            individual_on = data.individual_on;
            individual_off = data.individual_off;
            group_events = data.group;

            console.log("Individual Events:", individual_on);
            console.log("Individual Events:", individual_off);
            console.log("Group Events:", group_events);

            if (callback) callback(); // Populate dropdowns after events are loaded
        })
        .catch(error => {
            console.error("Error loading events:", error);
        });
}

document.addEventListener("DOMContentLoaded", function () {
    const degreeSelect = document.getElementById("degree");
    const yearSelect = document.getElementById("year");
    const courseSelect = document.getElementById("course");
    const eventDropdowns = document.querySelectorAll("#event1, #event2, #event3, #event4, #event5, #event6, #event7, #event8, #event9, #event10, #event");
    const groupeventDropdown = document.getElementById("event");
    const addParticipantButton = document.getElementById("addParticipant");
    const additionalParticipantsDiv = document.getElementById("additionalParticipants");
    const registrationForm = document.getElementById("registrationForm");

    additionalParticipantsDiv.style.display = "none";

    // 🟡 Populate dropdowns once events are loaded
    loadEventLists(() => {
        populateDropdown("event1", individual_on);
        populateDropdown("event2", individual_on);
        populateDropdown("event3", individual_on);
        populateDropdown("event4", individual_on);
        populateDropdown("event5", individual_on);
        populateDropdown("event6", individual_off);
        populateDropdown("event7", individual_off);
        populateDropdown("event8", individual_off);
        populateDropdown("event9", individual_off);
        populateDropdown("event10", individual_off);


        populateDropdown("event", group_events);
    });

    function populateDropdown(id, events) {
        let dropdown = document.getElementById(id);
        dropdown.innerHTML = `<option value="">Select an Event</option>`;
        events.forEach(event => {
            let option = document.createElement("option");
            option.value = event;
            option.textContent = event;
            dropdown.appendChild(option);
        });
    }

    // 🎓 Degree-based filtering
    degreeSelect.addEventListener("change", function () {
        const degree = this.value;
        yearSelect.innerHTML = '<option value="">Select</option>';
        courseSelect.innerHTML = '<option value="">Select</option>';

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

    // ✅ Validation for minimum one event
    registrationForm.addEventListener("submit", function (event) {
        let eventSelected = false;
        eventDropdowns.forEach(dropdown => {
            if (dropdown.value !== "") {
                eventSelected = true;
            }
        });

        if (!eventSelected) {
            alert("You must select at least one event to proceed.");
            event.preventDefault();
        }
    });

    // 🚫 Prevent duplicate event selections
    function validateEvents() {
        let selectedEvents = new Set();
        for (let dropdown of eventDropdowns) {
            let value = dropdown.value;
            if (value !== "" && selectedEvents.has(value)) {
                alert("You cannot select the same event more than once.");
                dropdown.value = "";
                return false;
            }
            selectedEvents.add(value);
        }
        return true;
    }

    eventDropdowns.forEach(dropdown => {
        dropdown.addEventListener("change", validateEvents);
    });

    // ➕ Show/hide participant fields for group event
    function updateParticipantRequirement() {
        if (groupeventDropdown.value !== "") {
            addParticipantButton.style.display = "block";
            additionalParticipantsDiv.style.display = "block";
        } else {
            addParticipantButton.style.display = "none";
            additionalParticipantsDiv.style.display = "none";
            additionalParticipantsDiv.innerHTML = `<label>Additional Participants:</label>`;
            participants = [];
        }
    }

    let participants = [];

    groupeventDropdown.addEventListener("change", updateParticipantRequirement);

    addParticipantButton.addEventListener("click", () => {
        let input = document.createElement("input");
        input.type = "text";
        input.name = "additional_participants[]";
        input.placeholder = "Enter Participant Roll Number";
        input.pattern = "^AM\\.[A-Z]{2}\\.[A-Z][0-9][A-Z]{3}[0-9]{5}$";
        input.title = "Enter the Roll number as in the ID card (e.g., AM.LS.A1ABC12345)";
        input.required = true;

        input.addEventListener("change", function () {
            if (participants.includes(input.value)) {
                alert("This participant is already added!");
                input.value = "";
            } else {
                participants.push(input.value);
            }
        });

        additionalParticipantsDiv.appendChild(input);
    });

    registrationForm.addEventListener("submit", (e) => {
        if (groupeventDropdown.value !== "") {
            let participantInputs = additionalParticipantsDiv.querySelectorAll("input");

            if (participantInputs.length === 0) {
                alert("Please add at least one additional participant for the selected group event.");
                e.preventDefault();
            }

            participantInputs.forEach(input => {
                if (input.value.trim() === "") {
                    input.remove();
                }
            });
        }
    });

    // 🔒 Prevent back navigation
    function preventBackNavigation() {
        window.history.pushState(null, "", window.location.href);
        window.addEventListener("popstate", function () {
            window.history.pushState(null, "", window.location.href);
        });
    }

    preventBackNavigation();
});
