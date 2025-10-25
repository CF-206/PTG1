<?php
include './head.php';
include './BDD_conection.php';

session_start();
if (isset($_SESSION['user'])&& !empty($_SESSION['user'])) {
    header('location: ./index.php');
}

if (isset($_POST) && !empty($_POST)) {
    $_SESSION['old'] = ['oldregisterinfo' => $_POST];
    $flag = false;
    foreach ($_POST as $key => $value) {
        if ($value == "") {
            $flag = true;
            break;
        }
    }
    
    if (!$flag) {
        $dbr = $dbh->prepare("SELECT * FROM `festivalier` WHERE fest_email = :email");
        $dbr->execute(['email' => $_POST['email'],]);
        $dbr = $dbr->fetch(PDO::FETCH_ASSOC);
        if ($dbr) {
            header('location:./login.php');
        }else{
            $hashed_password = password_hash($_POST['password'], PASSWORD_BCRYPT);
            $dbr = $dbh->prepare("INSERT INTO `festivalier` (`fest_nom`, `fest_prenom`, `fest_date_naissance`, `fest_email`, `fest_password`) VALUES (:nom, :prenom, :date, :email, :password)");
            $dbr->execute([
                'nom' => $_POST['nom'],
                'prenom' =>$_POST['prenom'],
                'date' =>$_POST['date'],
                'email' =>$_POST['email'],
                'password' =>$hashed_password,
            ]);
            $_SESSION['user'] = ['UserID'=> $dbh->lastInsertId()];
            foreach ($_POST as $key => $value) {
                if ($key != 'password') {
                    $_SESSION['user'] += [$key => $value];
                }else{
                    $_SESSION['user'] += [$key => $hashed_password];
                }
            }
            header('location: ./index.php');
        }
    }

}
?>


<body>
    <main>
        <form action="./register.php" method="post">

            <label for="nom">nom:</label>
            <input type="text" name="nom" id="nom" value="<?php if (isset($_SESSION['old']['oldregisterinfo']['nom'])) {
            echo $_SESSION['old']['oldregisterinfo']['nom'];} ?>">

            <label for="prenom">prénom:</label>
            <input type="text" name="prenom" id="prenom" value="<?php if (isset($_SESSION['old']['oldregisterinfo']['prenom'])) {
            echo $_SESSION['old']['oldregisterinfo']['prenom'];} ?>">

            <label for="date">date de naissance:</label>
            <input type="date" name="date" id="date" value="<?php if (isset($_SESSION['old']['oldregisterinfo']['date'])) {
            echo $_SESSION['old']['oldregisterinfo']['date'];} ?>">

            <label for="email">useremail:</label>
            <input type="email" name="email" id="email" value="<?php if (isset($_SESSION['old']['oldregisterinfo']['email'])) {
            echo $_SESSION['old']['oldregisterinfo']['email'];} ?>">

            <label for="password">password:</label>
            <input type="password" name="password" id="password" value="<?php if (isset($_SESSION['old']['oldregisterinfo']['password'])) {
            echo $_SESSION['old']['oldregisterinfo']['password'];} ?>">

            <input type="submit" value="ce connecter">
        </form>
    </main>
</body>