<?php
include './head.php';
include './BDD_conection.php';

session_start();
if (isset($_SESSION['user'])&& !empty($_SESSION['user'])) {
    header('location: ./index.php');
}

if (isset($_POST) && !empty($_POST)) {
    if (!empty($_POST['useremail']) && !empty($_POST['userpassword'])) {
        $_SESSION['old'] = ['oldconectioninfo' => $_POST];
        $dbr = $dbh->prepare("SELECT * FROM `festivalier` WHERE fest_email = :useremail");
        $dbr->execute(['useremail' => $_POST['useremail']]);
        $dbr = $dbr->fetch(PDO::FETCH_ASSOC);
        if ($dbr && password_verify($_POST['userpassword'], $dbr['fest_password'])) {
            $_SESSION['user'] = $dbr;
            header('location: ./index.php');
        }
    }
}
?>

<body>
    <main>
        <form action="./login.php" method="post">

            <label for="useremail">useremail:</label>
            <input type="email" name="useremail" id="useremail" value="<?php if (isset($_SESSION['old']['oldconectioninfo']['useremail'])) {
            echo $_SESSION['old']['oldconectioninfo']['useremail'];} ?>">

            <label for="userpassword">password:</label>
            <input type="password" name="userpassword" id="userpassword" value="<?php if (isset($_SESSION['old']['oldconectioninfo']['userpassword'])) {
            echo $_SESSION['old']['oldconectioninfo']['userpassword'];} ?>">

            <input type="submit" name="conectform" value="se connecter">
        </form>
    </main>
</body>

<?php include './footer.php' ?>