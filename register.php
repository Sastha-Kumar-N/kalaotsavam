<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ASBT_Kalotsavam";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}

// Get form data
$name = $_POST['name'] ?? '';
$roll_number = $_POST['roll'] ?? '';
$phone_number = $_POST['phone'] ?? '';
$gender = $_POST['gender'] ?? '';
$degree = $_POST['degree'] ?? '';
$course = $_POST['course'] ?? '';
$year = $_POST['year'] ?? '';
$event1 = $_POST['event1'] ?? '';
$event2 = $_POST['event2'] ?? '';
$event3 = $_POST['event3'] ?? '';
$event4 = $_POST['event4'] ?? '';
$event5 = $_POST['event5'] ?? '';
$event6 = $_POST['event6'] ?? '';
$event7 = $_POST['event7'] ?? '';
$event8 = $_POST['event8'] ?? '';
$event9 = $_POST['event9'] ?? '';
$event10 = $_POST['event10'] ?? '';
$group_event = $_POST['event']?? '';


$participants_list = isset($_POST['additional_participants']) ? $_POST['additional_participants'] : [];

// **Ensure main roll number is also in the participant list**
// **Only add main roll number if group event is selected**
if (!empty($group_event)) { // assuming event5 is the group event field
    array_unshift($participants_list, $roll_number);
    $participants_list = implode(",", array_unique($participants_list));
} else {
    $participants_list = ''; // no group event selected, so store an empty list
}


// Validate phone number (must be 10 digits)
if (!preg_match('/^[0-9]{10}$/', $phone_number)) {
    die("Invalid phone number format. Must be 10 digits.");
}

// Validate Roll Number Format
$pattern = "/^AM\.LS\.[A-Z][0-9][A-Z]{3}[0-9]{5}$/";
if (!preg_match($pattern, $roll_number)) {
    die("Invalid Roll Number format. Enter the Roll number as in your ID card.");
}

// **Event Selection Validation: No Duplicate Events Allowed**
$events = array_filter([$event1, $event2, $event3, $event4, $event5, $event6, $event7, $event8, $event9, $event10]); // Remove empty values
if (count($events) !== count(array_unique($events))) {
    die("You cannot select the same event more than once.");
}

// **Check if roll number is already registered**
$check_query = "SELECT * FROM Event_Registration WHERE Roll_Number = ?";
$stmt = $conn->prepare($check_query);
$stmt->bind_param("s", $roll_number);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    die("This Roll Number is already registered!");
}

// **Prevent duplicate group event registration**
if (!empty($group_event)) {
    $participantArray = explode(",", $participants_list); // Convert string to array

    foreach ($participantArray as $participant) {
        $participant = trim($participant);
        $check_query = "SELECT * FROM Event_Registration WHERE FIND_IN_SET(?, group_event_Participants) AND Group_event = ?";
        $stmt = $conn->prepare($check_query);
        $stmt->bind_param("ss", $participant, $group_event);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            die("Participant ($participant) is already registered for this group event!");
        }
    }
}

// **Function to generate a unique chest number**
function generateUniqueChestNumber($conn, $min, $max) {
    do {
        $chest_number = rand($min, $max);
        $check_sql = "SELECT COUNT(*) FROM Event_Registration WHERE Chest_Number = ?";
        $stmt = $conn->prepare($check_sql);
        $stmt->bind_param("s", $chest_number);
        $stmt->execute();
        $stmt->store_result();
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();
    } while ($count > 0);
    return $chest_number;
}

// **Determine the chest number range based on degree and year**
if ($degree == "BSc") {
    if ($year == "1st") {
        $chest_number = generateUniqueChestNumber($conn, 100, 200);
    } elseif ($year == "2nd") {
        $chest_number = generateUniqueChestNumber($conn, 200, 300);
    } elseif ($year == "3rd") {
        $chest_number = generateUniqueChestNumber($conn, 300, 400);
    } else {
        die("Invalid year selection for BSc.");
    }
} elseif ($degree == "MSc") {
    if ($year == "1st" || $year == "2nd") {
        $chest_number = generateUniqueChestNumber($conn, 400, 500);
    } else {
        die("Invalid year selection for MSc.");
    }
} else {
    die("Invalid degree selection.");
}

// **Insert into database**
$insert_query = "INSERT INTO Event_Registration (Name, Roll_Number, Phone_Number, Gender, Degree, Course, Year, Event1, Event2, Event3, Event4, Event5, Event6, Event7, Event8, Event9, Event10, Group_event, EB1, EB2, EB3, EB4, EB5, EB6, EB7, EB8, EB9, EB10, GB, group_event_Participants, Chest_Number) 
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($insert_query);
$stmt->bind_param("sssssssssssssssssssssssssssssss", $name, $roll_number, $phone_number, $gender, $degree, $course, $year, $event1, $event2, $event3, $event4, $event5, $event6, $event7, $event8, $event9, $event10, $group_event, $event1, $event2, $event3, $event4, $event5, $event6, $event7, $event8, $event9, $event10, $group_event, $participants_list, $chest_number);

if ($stmt->execute()) {
    header("Location: card.html?name=" . urlencode($name) . 
           "&roll_number=" . urlencode($roll_number) . 
           "&phone=" . urlencode($phone_number) . 
           "&gender=" . urlencode($gender) . 
           "&degree=" . urlencode($degree) . 
           "&course=" . urlencode($course) . 
           "&year=" . urlencode($year) . 
           "&chest_number=" . urlencode($chest_number));
    exit();
} else {
    echo "Unable to register. Please try again.";
}

// Close connection
$conn->close();
?>
