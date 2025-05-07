<?php
$servername = "localhost";
$username = "root";  
$password = "";      
$database = "ASBT_Kalolstavam";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql_join = "
    SELECT 
        er.*,
        e.event_Type,
        e.stage
    FROM Event_Results er
    LEFT JOIN events e ON er.Event = e.event_name
";
$result_join = $conn->query($sql_join);

$joinedResults = [];
while ($row = $result_join->fetch_assoc()) {
    $joinedResults[] = $row;
}

// 3️⃣ Output both results in one JSON response
header('Content-Type: application/json');
echo json_encode($joinedResults);

$conn->close();
?>
