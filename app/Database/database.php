<?php
// Kode untuk menghubungkan ke database Anda
$servername = "your_servername";
$username = "your_username";
$password = "your_password";
$dbname = "your_dbname";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['step'])) {
    $step = intval($_POST['step']);
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sqlFilename = "step" . $step . ".sql";
    
    if (file_exists($sqlFilename)) {
        $sql = file_get_contents($sqlFilename);
        if ($conn->multi_query($sql)) {
            echo "SQL file for step " . $step . " executed successfully";
        } else {
            echo "Error executing SQL file for step " . $step . ": " . $conn->error;
        }
    } else {
        echo "File for step " . $step . " does not exist";
    }

    $conn->close();
}
