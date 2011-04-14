<?php
require("constants.php");
connect();
$g_id = $_GET["g_id"];
$query = "DELETE FROM games WHERE g_id = '$g_id'";
$result = mysql_query($query);
$query = "DELETE FROM qa WHERE g_id = '$g_id'";
$result = mysql_query($query);
$query = "ALTER TABLE games AUTO_INCREMENT =1";
$result = mysql_query($query);
if($result){
	echo "success";
}else{
	echo "failed";
}
disconnect();
?>