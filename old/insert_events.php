<?php
// insert_events.php

$host = "localhost";
$user = "root";
$password = "";
$dbname = "ASBT_Kalolstavam";

$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    http_response_code(500);
    die("Connection failed: " . $conn->connect_error);
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['events']) || !is_array($data['events'])) {
    http_response_code(400);
    echo "Invalid data format.";
    exit;
}

// Updated INSERT with stage
$stmt = $conn->prepare("INSERT INTO events (event_name, event_type, stage) VALUES (?, ?, ?)");

foreach ($data['events'] as $event) {
    $name = trim($event['name']);
    $type = $event['type'] === 'group' ? 'group' : 'individual';
    $stage = $event['stage'] === 'off' ? 'off' : 'on'; // sanitize

    if ($name !== "") {
        $stmt->bind_param("sss", $name, $type, $stage);
        $stmt->execute();
    }
}

$stmt->close();
$conn->close();

echo "Events added successfully!";
?>
