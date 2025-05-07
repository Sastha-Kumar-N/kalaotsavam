<?php
$servername = "localhost";
$username = "root";  
$password = "";      
$database = "ASBT_Kalolstavam";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$event_type = $_POST['event_type'];
$rank = $_POST['rank'];
$score = intval($_POST['score']);

// Check if entry exists
$query = $conn->prepare("SELECT id FROM rank_scores WHERE event_type = ? AND rank = ?");
$query->bind_param("ss", $event_type, $rank);
$query->execute();
$query->store_result();

if ($query->num_rows > 0) {
    // Update existing
    $update = $conn->prepare("UPDATE rank_scores SET score = ? WHERE event_type = ? AND rank = ?");
    $update->bind_param("iss", $score, $event_type, $rank);
    $update->execute();
} else {
    // Insert new
    $insert = $conn->prepare("INSERT INTO rank_scores (event_type, rank, score) VALUES (?, ?, ?)");
    $insert->bind_param("ssi", $event_type, $rank, $score);
    $insert->execute();
}

echo "Score updated successfully!";
?>
