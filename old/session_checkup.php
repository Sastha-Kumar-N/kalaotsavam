<?php
session_start();

// If admin is not logged in, redirect to login page
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: admin.html");
    exit();
}
?>
