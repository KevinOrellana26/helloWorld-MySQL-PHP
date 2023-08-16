<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>test-connection</title>
</head>
<body>
    <?php

    $host  = "mysql";
    $port = "3306";
    $user = "user";
    $pass = "user";
    $db = "mydb";

    $conn = new mysqli($host, $user, $pass, $db, $port);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    echo "Connected successfully to MySQL";

    $conn->close();

    // $mysqli = new mysqli("mysql", "user", "password", "mydb");
    // if ($mysqli->connect_error) {
    //     echo "Error al realizar la conexión";
    // }
    // echo "connected successfully";
    
    ?>
</body>
</html>