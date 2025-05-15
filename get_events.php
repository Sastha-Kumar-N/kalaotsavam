<?php
// get_events.php

// Database connection
$host = "localhost";
$user = "root";
$password = "co*/YEYMh.URZ93@";
$dbname = "ASBT_Kalotsavam";

$conn = new mysqli($host, $user, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["error" => "Database connection failed: " . $conn->connect_error]));
}

// Function to fetch events
function fetchEventsFromDatabase($conn) {
    $individual_on = [];
    $individual_off = [];
    $group_events = [];

    $sql = "SELECT event_name, event_type, stage FROM events";
    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            if ($row['event_type'] === 'individual') {
                if ($row['stage'] === 'on') {
                    $individual_on[] = $row['event_name'];
                } elseif ($row['stage'] === 'off') {
                    $individual_off[] = $row['event_name'];
                }
            } elseif ($row['event_type'] === 'group') {
                $group_events[] = $row['event_name'];
            }
        }
    }

    return [
        'individual_on' => $individual_on,
        'individual_off' => $individual_off,
        'group' => $group_events
    ];
}

// Output as JSON
header('Content-Type: application/json');
echo json_encode(fetchEventsFromDatabase($conn));
$conn->close();
?>
