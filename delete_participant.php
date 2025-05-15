<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = "localhost";
$username = "root";
$password = "co*/YEYMh.URZ93@";
$database = "ASBT_Kalotsavam";

$conn = new mysqli($host, $username, $password, $database);
if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]));
}

$input = json_decode(file_get_contents("php://input"), true);

if (!$input || !isset($input['chestNumber'])) {
    http_response_code(400);
    echo json_encode(["status" => "error", "message" => "Invalid input or chest number missing"]);
    exit;
}

$chestNumber = $input['chestNumber'];

try {
    // Begin transaction
    $conn->begin_transaction();

    // Delete from related tables first
    $stmt1 = $conn->prepare("DELETE FROM Event_Results WHERE Chest_Number = ?");
    $stmt1->bind_param("s", $chestNumber);
    $stmt1->execute();
    $stmt1->close();


    // Delete from main table
    $stmt = $conn->prepare("DELETE FROM Event_Registration WHERE Chest_Number = ?");
    $stmt->bind_param("s", $chestNumber);
    $stmt->execute();
    $stmt->close();

    // Commit all changes
    $conn->commit();

    echo json_encode(["status" => "success", "message" => "Participant and related data deleted successfully"]);
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Deletion failed: " . $e->getMessage()]);
} finally {
    $conn->close();
}
