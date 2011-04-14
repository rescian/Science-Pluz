<?php
require("constants.php");
connect();
$g_id = $_GET["g_id"];
$query = "select * from games where g_id='$g_id'";
$result = mysql_query($query);
$rows = mysql_num_rows($result);
if($result){
	echo "<game>";
		echo "\n   <g_id>";
		echo "\n   ".mysql_result($result,$i,"g_id");
		echo "\n   </g_id>";	
		echo "\n   <gname>";
		echo "\n      ".mysql_result($result,$i,"gname");
		echo "\n   </gname>";	
		echo "\n   <gtype>";
		echo "\n      ".mysql_result($result,$i,"gtype");
		echo "\n   </gtype>";	
		echo "\n   <glevel>";
		echo "\n      ".mysql_result($result,$i,"glevel");
		echo "\n   </glevel>";	
		echo "\n   <gdesc>";
		echo "\n      ".mysql_result($result,$i,"gdesc");
		echo "\n   </gdesc>";	
		echo "\n   <gthumb>";
		echo "\n      ".mysql_result($result,$i,"gthumb");
		echo "\n   </gthumb>";
		echo "\n   <qas>";
		$query = "select * from qa where g_id='$g_id'";
		$result = mysql_query($query);
		$rows = mysql_num_rows($result);
		for($i = 0; $i<$rows;$i++){		
			echo "\n      <qa>";	
			echo "\n         <qtext>";
			echo "\n            ".mysql_result($result,$i,"qtext");
			echo "\n         </qtext>";
			echo "\n         <qimage>";
			echo "\n            ".mysql_result($result,$i,"qimage");
			echo "\n         </qimage>";
			echo "\n         <atext>";
			echo "\n            ".mysql_result($result,$i,"atext");
			echo "\n         </atext>";
			echo "\n         <aimage>";
			echo "\n            ".mysql_result($result,$i,"aimage");
			echo "\n         </aimage>";
			echo "\n      </qa>";
		}
		echo "\n   </qas>";
	echo "\n</game>";
}else{
	echo "failed";
}
disconnect();
?>