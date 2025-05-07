<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = "localhost";
$username = "root"; // Change if needed
$password = ""; // Change if needed
$database = "ASBT_Kalolstavam"; // Change to your DB name

$conn = new mysqli($host, $username, $password, $database);
if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}

$input = json_decode(file_get_contents("php://input"), true);

if (!$input) {
    echo json_encode(["status" => "error", "message" => "Invalid input"]);
    exit;
}

$rollNumber = $input['rollNumber'];
$name = $input['name'];
$gender = $input['gender'];
$degree = $input['degree'];
$year = substr($input['year'], 0, 10); // Truncate to match DB column size
$course = $input['course'];
$phone = $input['phone'];
$chestNumber = $input['chestNumber'];
$event1 = $input['event1'];
$event2 = $input['event2'];
$event3 = $input['event3'];
$event4 = $input['event4'];
$event5 = $input['event5'];
$event6 = $input['event6'];
$event7 = $input['event7'];
$event8 = $input['event8'];
$event9 = $input['event9'];
$event10 = $input['event10'];
$groupEvent = $input['groupEvent'];

try {
    $stmt = $conn->prepare("UPDATE Event_Registration SET Name=?,Roll_Number=?, Gender=?, Degree=?, Year=?, Course=?, Phone_Number=?, Event1=?, Event2=?, Event3=?, Event4=?, Event5=?, Event6=?, Event7=?, Event8=?, Event9=?, Event10=?, Group_event=? WHERE Chest_Number=?");
    $stmt->bind_param("sssssssssssssssssss", $name, $rollNumber, $gender, $degree, $year, $course, $phone, $event1, $event2, $event3, $event4, $event5, $event6, $event7, $event8, $event9, $event10, $groupEvent,  $chestNumber);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Participant updated successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update participant"]);
    }

    $stmt->close();
    $conn->close();
} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
