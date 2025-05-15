<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = "localhost";
$username = "root"; // Change if needed
$password = "co*/YEYMh.URZ93@"; // Change if needed
$database = "ASBT_Kalotsavam"; // Change to your DB name

$conn = new mysqli($host, $username, $password, $database);
if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
} // Your database connection file

$data = json_decode(file_get_contents("php://input"), true);
$disabledEvents = $data['disabledEvents'] ?? [];

// Clear previous disabled events
$conn->query("DELETE FROM Disabled_events ");

// Insert new disabled events
$stmt = $conn->prepare("INSERT INTO Disabled_events (Events) VALUES (?)");

foreach ($disabledEvents as $event) {
    $stmt->bind_param("s", $event);
    $stmt->execute();
}

echo "Success";
$stmt->close();
$conn->close();
?>
