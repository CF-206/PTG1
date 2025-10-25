<?php
try {
    $dbh = new PDO('mysql:host=localhost;dbname=bdd_tpg1;charset=utf8', 'root', '');
} catch (PDOException $e) {
    die($e->getMessage());
}
