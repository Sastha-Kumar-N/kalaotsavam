<?php
session_start();

$host = "localhost";
$user = "root";
$password = "co*/YEYMh.URZ93@";
$database = "ASBT_Kalotsavam";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Prepare statement
    $stmt = $conn->prepare("SELECT password FROM admin_users WHERE username = ?");
    if ($stmt === false) {
        die("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param("s", $username);
    $stmt->execute();

    // Get result
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $row = $result->fetch_assoc();

        // Verify password hash
        if (password_verify($password, $row['password'])) {
            $_SESSION['username'] = $username;
            header("Location: dashboard.php");
            exit();
        } else {
            echo "<script>alert('Invalid username or password.'); window.location.href='admin.html';</script>";
        }
    } else {
        echo "<script>alert('Invalid username or password.'); window.location.href='admin.html';</script>";
    }

    $stmt->close();
}

$conn->close();
?>
