<?php
session_start();

// Redirect to login if not authenticated
if (!isset($_SESSION['username'])) {
    header("Location: admin.html");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Registration Dashboard</title>
    <link rel="icon" href="title_logo.png" type="image/png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo left-logo">
            <img src="ASBT_logo.png" alt="Left Logo" id="leftLogo">
        </div>
        <div class="nav-links1">
            <a href="index.html">ASBT Kalotsavam</a>
        </div>

        <div class="logo mid-logo">
            <img src="kalotsavam_logo.png" alt="kalotsavam Logo" id="kalotsavamLogo">
        </div>
        <div class="nav-links">
            <a href="leaderboard.html">Leaderboard</a>
        </div>


        <div class="logo right-logo">
            <img src="creatome_white.png" alt="Right Logo" id="rightLogo">
        </div>
    </nav>
    


    <div class="function-container">
        <button id="registration-btn" class="registration-btn" onclick="registrationManager.toggleStatus()">Close Registration</button>
        <button id="leader-btn" class="leaderboard-btn" onclick="toggleLeaderboard()">Leaderboard ON</button>
        <button class="score-btn" onclick="score()">Update Score</button>
        <button class="addevent-btn" onclick="addevent()">Add Event</button>
        <button class="edit-btn" onclick="openEditDialog()">Edit</button>
        <button class="disable-btn" onclick="openDisableDialog()">Disable</button>
        <button class="download-btn" onclick="downloadExcel()">Download</button>  
        <button id="submitScores" class="download-btn">Submit</button>
        <button class="logout-btn" onclick="logout()">Logout</button>
    </div>


    <div class="container">
        <h2></h2>
        <div class="filter">
            <label for="genderFilter">Gender:</label>
            <select id="genderFilter">
                <option value="">All</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <label for="degreeFilter">Degree:</label>
            <select id="degreeFilter">
                <option value="">All</option>
                <option value="BSc">BSc</option>
                <option value="MSc">MSc</option>
            </select>
            <label for="yearFilter">Year:</label>
            <select id="yearFilter">
                <option value="">All</option>
                <option value="1st">1st Year</option>
                <option value="2nd">2nd Year</option>
                <option value="3rd">3rd Year</option>
            </select>
            <label for="eventFilter">Event:</label>
            <select id="eventFilter">
                <option value="">All</option>
            </select>

        </div>
        <!-- Filter Options -->
       

        <div id="editDialog" class="modal" style="display: none; border: 1px solid black;">
            <div class="modal-content">
                <span class="close" onclick="closeEditDialog()">&times;</span>
                <h2>Edit Participant Details </h2>
                <!-- Search Section -->
                <div class="search-container">
                    <input type="text" id="searchChestNumber" placeholder="Enter Chest Number">
                    <button class ='search-btn' onclick="searchParticipant()">Search</button>
                </div>
                
                <!-- Participant Details Table (Vertical) -->
                <table class="vertical-table">
                    <tbody id="participantTableBody">
                        <tr><th>Name</th><td id="p_name">-</td></tr>
                        <tr><th>Roll Number</th><td id="p_roll">-</td></tr>
                        <tr><th>Gender</th>
                            <td>
                                <select id="edit_gender">
                                    <option value="">Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </td>
                        </tr>
                        <tr><th>Degree</th>
                            <td>
                                <select id="edit_degree">
                                    <option value="">Degree</option>
                                    <option value="BSc">BSc</option>
                                    <option value="MSc">MSc</option>
                                </select>
                            </td>
                        </tr>
                        <tr><th>Year</th>
                            <td>
                                <select id="edit_year">
                                    <option value="">Year</option>
                                </select>
                            </td>
                        </tr>
                        <tr><th>Course</th>
                            <td>
                                <select id="edit_course">
                                    <option value="">Course</option>
                                </select>
                            </td>
                        </tr>

                        <tr><th>Phone Number</th><td id="p_phone">-</td></tr>
                    </tbody>
                </table>
                
                <!-- Registered Events Table -->
                <h3>Registered Events</h3>
                <table class="vertical-table">
                    <tbody id="eventTableBody">
                        <tr><th>Event</th><td>-</td></tr>
                    </tbody>
                </table>

                
                <!-- Update & Delete Button -->
                <button id="updateParticipant" class="update-btn">Update</button>
                <button id="deleteParticipant" class="delete-btn">Delete Participant</button>

            </div>
        </div>

        <div id="disableEventDialog" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border: 1px solid black;">
            <h3>Select Events to Disable</h3>
            <div id="eventCheckboxes"></div>
            <button onclick="disableSelectedEvents()">Disable</button>
            <button onclick="enableSelectedEvents()">Enable</button>

            <!-- <button onclick="closeDisableDialog()">Cancel</button> -->
            <span class="close" onclick="closeDisableDialog()">&times;</span>

        </div>

        <div id="addEventDialog" style="display:none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border: 1px solid black;">
            <h3>Add Events</h3>
            <div id="eventInputs"></div>
            <span class="close" onclick="closeEventDialog()">&times;</span>

            <button onclick="addEventInput(false)">Add Individual Event</button>
            <button onclick="addEventInput(true)">Add Group Event</button>
            <button onclick="submitNewEvents()">Add Events</button>
            <!-- <button onclick="closeAddEventDialog()">Cancel</button> -->
        </div>

        <!-- Leaderboard Off Modal -->
        <div id="leaderboardOffModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h3>Set Leaderboard Off Duration</h3>
                <div class="time-inputs">
                <div>
                    <label>Hours:</label>
                    <input type="number" id="offHours" min="0" max="23" value="0">
                </div>
                <div>
                    <label>Minutes:</label>
                    <input type="number" id="offMinutes" min="0" max="59" value="30">
                </div>
                <div>
                    <label>Seconds:</label>
                    <input type="number" id="offSeconds" min="0" max="59" value="0">
                </div>
                </div>
                <button class="confirm-btn" onclick="confirmLeaderboardOff()">Confirm</button>
                <button class="cancel-btn" onclick="closeModal()">Cancel</button>
            </div>
        </div>



        <!-- Scrollable Table -->
        <div class="table-container">
            <table id="eventTable">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Roll Number</th>
                        <th>Gender</th>
                        <th>Degree</th>
                        <th>Year</th>
                        <th>Phone Number</th>
                        <th>Chest Number</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        
        <div id="updatescoreDialog" style="display:none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border: 1px solid black;">
            <h3>Update Rank Scores</h3>
            <span class="close" onclick="closeupdatescoreDialog()">&times;</span>
            <form id="scoreForm">
                <select name="event_type">
                    <option value="">Select</option>
                    <option value="individual">Individual</option>
                    <option value="group">Group</option>
                </select>
                <select name="rank">
                    <option value="">Select</option>
                    <option value="First">First</option>
                    <option value="Second">Second</option>
                    <option value="Third">Third</option>
                </select>
                <input id = scoreinput type="number" name="score" placeholder="Enter score" required />
                <button type="submit">Update</button>
            </form>
        </div>


    </div>
    <script src="dashboard.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
          let lastScroll = 0;
          const navbar = document.querySelector('.navbar');
          
          window.addEventListener('scroll', () => {
            const currentScroll = window.pageYOffset;
            
            if (currentScroll <= 0) {
              // At top of page - always show navbar
              navbar.classList.remove('hidden');
              return;
            }
            
            if (currentScroll > lastScroll && !navbar.classList.contains('hidden')) {
              // Scrolling down - hide navbar
              navbar.classList.add('hidden');
            } else if (currentScroll < lastScroll && navbar.classList.contains('hidden')) {
              // Scrolling up - show navbar
              navbar.classList.remove('hidden');
            }
            
            lastScroll = currentScroll;
          });
      });

    </script>


</body>
</html>
