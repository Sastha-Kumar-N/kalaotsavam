<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "ASBT_Kalotsavam"; // Replace with your DB name

$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$data = json_decode(file_get_contents("php://input"), true);

// Insert announcement
$announcement = $conn->real_escape_string($data['announcement']);
$conn->query("INSERT INTO announcements (text) VALUES ('$announcement')");

// Insert schedules
foreach ($data['schedule'] as $item) {
  $date = $conn->real_escape_string($item['date']);
  $month = $conn->real_escape_string($item['month']);
  $day = $conn->real_escape_string($item['day']);
  $venue = $conn->real_escape_string($item['venue']);
  $events = $conn->real_escape_string($item['events']);
  $times = $conn->real_escape_string($item['times']);
  $coordinator = $conn->real_escape_string($item['coordinator']);
  $phone = $conn->real_escape_string($item['phone']);

  $sql = "INSERT INTO schedules (date, month, day, venue, events, times, coordinator, phone)
          VALUES ('$date', '$month', '$day', '$venue', '$events', '$times', '$coordinator', '$phone')";
  $conn->query($sql);
}

$conn->close();
echo "Saved successfully!";
?>
