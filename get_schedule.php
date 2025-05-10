<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "ASBT_Kalotsavam"; // Replace with your DB name

$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Fetch ALL announcements (ordered by most recent first)
$announcements = [];
$announcement_sql = "SELECT text FROM announcements ORDER BY created_at DESC";
$announcement_result = $conn->query($announcement_sql);
while ($row = $announcement_result->fetch_assoc()) {
  $announcements[] = $row['text'];
}

// Fetch schedule entries
$schedules = [];
$schedule_sql = "SELECT * FROM schedules ORDER BY date";
$result = $conn->query($schedule_sql);
while ($row = $result->fetch_assoc()) {
  $schedules[] = $row;
}

$conn->close();

echo json_encode([
  "announcements" => $announcements,
  "schedule" => $schedules
]);
?>
