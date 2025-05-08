<?php
session_start(); // Start session to store login state

$host = "localhost"; // Change if necessary
$user = "root"; // Change to your database username
$password = ""; // Change to your database password
$database = "ASBT_Kalolstavam"; // Database name

// Create a connection
$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = $_POST['password']; // Don't escape password since it's hashed

    // Query to check credentials
    $sql = "SELECT * FROM admin_users WHERE username='$username'";
    $result = $conn->query($sql);

    if ($result->num_rows == 1) {
        $row = $result->fetch_assoc();
        
        // Verify password (assuming it's hashed in the database)
        if (password_verify($password, $row['password'])) {
            $_SESSION['username'] = $username; // Store session
            header("Location: dashboard.php"); // Redirect to admin panel
            exit();
        } else {
            echo "<script>alert('Invalid username or password.'); window.location.href='admin.html';</script>";
        }
    } else {
        echo "<script>alert('Invalid username or password.'); window.location.href='admin.html';</script>";
    }
}

$conn->close();
?>
