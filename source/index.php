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
    else {
        $sql = "SELECT * FROM helloWorld";
        $res = $mysqli->query($sql);

        echo "<h1>BD - Hello World</h1>";
        if ($res) {
            $fila = $res->fetch_assoc();
            echo "<h1>{$fila["mensaje"]}</h1>";
            $res->close();
        }
        else {
            echo "Fallo al obtener el mensaje";
        }
        $mysqli->close();
    }
    ?>
</body>
</html>
