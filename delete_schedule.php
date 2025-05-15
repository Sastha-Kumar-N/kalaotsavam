<?php
$host = "localhost";
$user = "root";
$password = "co*/YEYMh.URZ93@";
$database = "ASBT_Kalotsavam";

$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Get input
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['id'])) {
    // Delete from schedules table using ID
    $id = intval($data['id']);
    $stmt = $conn->prepare("DELETE FROM schedules WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    echo "Schedule deleted";
    $stmt->close();
} elseif (isset($data['index'])) {
    // Delete announcement by index (get all, remove one, reinsert)
    $index = intval($data['index']);
    $result = $conn->query("SELECT id FROM announcements ORDER BY created_at DESC");
    
    $ids = [];
    while ($row = $result->fetch_assoc()) {
        $ids[] = $row['id'];
    }

    if (isset($ids[$index])) {
        $aid = $ids[$index];
        $stmt = $conn->prepare("DELETE FROM announcements WHERE id = ?");
        $stmt->bind_param("i", $aid);
        $stmt->execute();
        echo "Announcement deleted";
        $stmt->close();
    } else {
        echo "Invalid announcement index";
    }
}

$conn->close();
?>
