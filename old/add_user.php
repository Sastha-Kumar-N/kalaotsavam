<?php
// Database configuration
$db_host = 'localhost';
$db_name = 'ASBT_Kalolstavam';
$db_user = 'root';
$db_pass = '';

// User data (in a real application, this would come from a form)
$username = 'user';
$password = 'user';

try {
    // Create database connection
    $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Hash the password (never store plain text passwords)
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Prepare SQL statement to prevent SQL injection
    $stmt = $conn->prepare("INSERT INTO admin_users (username, password) VALUES (:username, :password)");
    
    // Bind parameters and execute
    $stmt->bindParam(':username', $username);
    $stmt->bindParam(':password', $hashed_password);
    
    // Execute the query
    $stmt->execute();
    
    echo "User '$username' added successfully!";
    
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

// Close connection
$conn = null;
?>
