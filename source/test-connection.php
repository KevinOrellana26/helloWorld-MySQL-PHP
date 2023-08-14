<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World from MySQL</title>
</head>
<body>
    <?php
    $mysqli = new mysqli("mysql", "user", "password", "mydb");
    if ($mysqli->connect_error) {
        echo "Error al realizar la conexión";
    }
    echo "connected successfully";
    $mysqli->close();
    ?>
</body>
</html>