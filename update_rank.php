<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";  
$password = "co*/YEYMh.URZ93@";      
$database = "ASBT_Kalotsavam";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    http_response_code(500);
    die("Connection failed: " . $conn->connect_error);
}


$data = json_decode(file_get_contents("php://input"), true);
if (!$data) {
    http_response_code(400);
    die("Invalid or no JSON received.");
}

function getEventType(mysqli $db, string $eventName): ?string {
    $stmt = $db->prepare("SELECT event_type FROM events WHERE event_name = ?");
    $stmt->bind_param("s", $eventName);
    $stmt->execute();
    $stmt->bind_result($eventType);
    return $stmt->fetch() ? $eventType : null;
}

function getScore(mysqli $db, string $rank, string $eventType): ?int {
    $stmt = $db->prepare("SELECT score FROM rank_scores WHERE rank = ? AND event_type = ?");
    $stmt->bind_param("ss", $rank, $eventType);
    $stmt->execute();
    $stmt->bind_result($score);
    return $stmt->fetch() ? $score : null;
}

$insertStmt = $conn->prepare("
    INSERT INTO Event_Results (Name, Roll_Number, Gender, Degree, Year, Chest_Number, Event, Rank, Score)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE 
        Name = VALUES(Name),
        Gender = VALUES(Gender),
        Degree = VALUES(Degree),
        Year = VALUES(Year),
        Chest_Number = VALUES(Chest_Number),
        Rank = VALUES(Rank),
        Score = VALUES(Score)
");

$deleteStmt = $conn->prepare("DELETE FROM Event_Results WHERE Roll_Number = ? AND Event = ?");

foreach ($data as $row) {
    $required = ['name', 'rollNumber', 'gender', 'degree', 'year', 'chestNumber', 'eventName', 'rank'];
    foreach ($required as $field) {
        if (empty($row[$field])) {
            http_response_code(422);
            die("Missing required field: $field");
        }
    }

    ['name' => $name, 'rollNumber' => $roll, 'gender' => $gender, 'degree' => $degree, 'year' => $year,
     'chestNumber' => $chest, 'eventName' => $event, 'rank' => $rank] = $row;

    $eventType = getEventType($conn, $event);
    if (!$eventType) {
        error_log("Invalid event: $event");
        continue;
    }

    if (trim($rank) === "Yes") {
        $deleteStmt->bind_param("ss", $roll, $event);
        $deleteStmt->execute();
        error_log("Deleted: Roll_Number = $roll, Event = $event");
        continue;
    }

    $score = getScore($conn, $rank, $eventType);
    if ($score === null) {
        error_log("No score found for rank '$rank' and event type '$eventType'");
        continue;
    }

    $insertStmt->bind_param("sssssissi", $name, $roll, $gender, $degree, $year, $chest, $event, $rank, $score);
    if (!$insertStmt->execute()) {
        error_log("Insert error: " . $insertStmt->error);
    } else {
        error_log("Upserted: Roll = $roll | Gender = $gender | Event = $event | Rank = $rank | Score = $score");
    }
}

echo "Rank updates completed.";
$insertStmt->close();
$deleteStmt->close();
$conn->close();
