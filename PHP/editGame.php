<?php
require("constants.php");
connect();
$g_id = $_GET["g_id"];
$gname = $_GET["gname"];
$gtype = $_GET["gtype"];
$glevel = $_GET["glevel"];
$gdesc = $_GET["gdesc"];
$gthumb = $_GET["gthumb"];
$query = "UPDATE games ".
		"SET gname = '$gname',".
		"    gtype = '$gtype',".
		"    glevel = '$glevel',".
		"    gdesc = '$gdesc',".
		"    gthumb = '$gthumb'".
		"WHERE g_id = '$g_id'";		
if(mysql_query($query)){
	$query = "DELETE FROM qa WHERE g_id = '$g_id'";
	if(mysql_query($query)){	
		$i = 0;
		$query = "insert into qa(g_id,qtext,qimage,atext,aimage) values";
		while(!empty($_GET["qtext".$i])){
			if($i > 0){
				$query.=",";
			}
			$qtext = $_GET["qtext".$i];
			$qimage = $_GET["qimage".$i];
			$atext = $_GET["atext".$i];
			$aimage = $_GET["aimage".$i];
			$query.="('$g_id','$qtext','$qimage','$atext','$aimage')";
			$i++;
		}
		echo $query;
		if(mysql_query($query)){
			echo "success";
		}else{
			echo "failed3";
		}
	}else{
		echo "failed2";
	}
}else{
	echo "failed1";
}
disconnect();
?>