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
} // Your database connection file

$result = $conn->query("SELECT Events FROM Disabled_events");
$disabledEvents = [];

while ($row = $result->fetch_assoc()) {
    $disabledEvents[] = $row['Events'];
}

echo json_encode($disabledEvents);
$conn->close();
?>
