<?php
 include "api.php";
 print("\nt1.php");
 $bp = new SimpleBackpack();
 print("\n calling 'list_pages'");
$res= $bp->list_pages();
 print($res);
?>