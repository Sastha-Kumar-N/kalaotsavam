<?php
session_start();
session_destroy();
header("Location: admin.html"); // Redirect to login page
exit();
?>
