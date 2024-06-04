<?php
// Database connection details
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "memory_game";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch photos from the database
$sql = "SELECT * FROM photos1";
$result = $conn->query($sql);

// Convert result to JSON
$photos = array();
if ($result->num_rows > 0) {
    $photos = array();
    // Fetch each row and encode the photo as base64
    while ($row = $result->fetch_assoc()) {
        $base64Image = base64_encode($row['photo']);
        // Add the base64-encoded photo to the array
        array_push($photos, $base64Image);
    }
    // Encode the array as JSON and echo it
    echo json_encode($photos);
} else {
    echo "0 results";
}

$conn->close();
?>
