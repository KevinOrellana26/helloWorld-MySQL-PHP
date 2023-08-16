<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test-Connection</title>
</head>
<body>
    <?php
    echo "<h1>Test-connection to MySQL</h1>";
    $host  = "mysql";
    $user = "user";
    $pass = "user";
    $db = "mydb";

    $conn = new mysqli($host, $user, $pass, $db);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    echo "<h3>Connected successfully to MySQL!!!</h3>";

    $conn->close();
    ?>
</body>
</html>