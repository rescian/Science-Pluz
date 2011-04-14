<?php
require("constants.php");
connect();
$gname = $_GET["gname"];
$gtype = $_GET["gtype"];
$glevel = $_GET["glevel"];
$gdesc = $_GET["gdesc"];
$gthumb = $_GET["gthumb"];
$query = "insert into games(gname, gtype, glevel,gdesc,gthumb) values(".
					"'$gname',".
					"'$gtype',".
					"'$glevel',".
					"'$gdesc',".
					"'$gthumb')";
$result = mysql_query($query);
if($result){
	echo "success";
}else{
	echo "failed";
}
disconnect();
?>