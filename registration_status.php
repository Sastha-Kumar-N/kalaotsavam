<?php
// registration_status.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Handle CORS preflight for POST
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header("Access-Control-Allow-Methods: POST, GET");
    header("Access-Control-Allow-Headers: Content-Type");
    exit(0);
}

// Connect to database
$host = "localhost";
$user = "root";
$password = ""; // Or your MySQL password
$dbname = "ASBT_Kalotsavam";

$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Database connection failed"]);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch current status
    $sql = "SELECT is_open FROM registration_status WHERE id = 1";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    echo json_encode(["status" => boolval($row["is_open"])]);
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Update status
    $data = json_decode(file_get_contents("php://input"), true);
    $status = isset($data['status']) ? (bool)$data['status'] : true;

    $stmt = $conn->prepare("UPDATE registration_status SET is_open = ? WHERE id = 1");
    $stmt->bind_param("i", $status);
    $stmt->execute();

    echo json_encode(["status" => $status]);
} else {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["error" => "Method not allowed"]);
}

$conn->close();
?>
