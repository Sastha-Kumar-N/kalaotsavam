<?php
$servername = "localhost";
$username = "root";  
$password = "co*/YEYMh.URZ93@";      
$database = "ASBT_Kalotsavam";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM Event_Registration";
$result = $conn->query($sql);

$participants = [];
while ($row = $result->fetch_assoc()) {
    $participants[] = $row;
}



header('Content-Type: application/json');
echo json_encode($participants);


$conn->close();
?>




