<?php
if( class_exists('User') === FALSE )
    include 'User.php';
User::actionArticle($_GET['id'], 3);
header('Location:' . $_GET['url']);
?>
