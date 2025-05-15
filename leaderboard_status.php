<?php
header('Content-Type: application/json');

$conn = new mysqli('localhost', 'root', 'co*/YEYMh.URZ93@', 'ASBT_Kalotsavam');
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'error' => 'DB connection failed']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // 🔹 GET request → return current status
    $res = $conn->query("SELECT is_on, end_time FROM leaderboard_status WHERE id = 1");
    $row = $res->fetch_assoc();
    echo json_encode([
        'success' => true,
        'isOn' => (bool)$row['is_on'],
        'endTime' => $row['end_time']
    ]);

} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 🔹 POST request → update status
    $data = json_decode(file_get_contents("php://input"), true);
    $isOn = $data['isOn'] ? 1 : 0;
    $endTime = isset($data['endTime']) ? (int)$data['endTime'] : null;

    $stmt = $conn->prepare("UPDATE leaderboard_status SET is_on = ?, end_time = ? WHERE id = 1");
    $stmt->bind_param('ii', $isOn, $endTime);
    $success = $stmt->execute();

    echo json_encode(['success' => $success]);
    $stmt->close();
}

$conn->close();

