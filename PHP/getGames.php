<?php
require("constants.php");
connect();
$query = "select * from games order by g_id";
$result = mysql_query($query);
$rows = mysql_num_rows($result);
if($result){
	echo "<games>";
		for($i = 0; $i<$rows;$i++){
			echo "\n   <game>";
			echo "\n      <g_id>";
			echo "\n         ".mysql_result($result,$i%$rows,"g_id");
			echo "\n      </g_id>";	
			echo "\n      <gname>";
			echo "\n         ".mysql_result($result,$i%$rows,"gname");
			echo "\n      </gname>";	
			echo "\n      <gtype>";
			echo "\n         ".mysql_result($result,$i%$rows,"gtype");
			echo "\n      </gtype>";	
			echo "\n      <glevel>";
			echo "\n         ".mysql_result($result,$i%$rows,"glevel");
			echo "\n      </glevel>";	
			echo "\n      <gdesc>";
			echo "\n         ".mysql_result($result,$i%$rows,"gdesc");
			echo "\n      </gdesc>";	
			echo "\n      <gthumb>";
			echo "\n         ".mysql_result($result,$i%$rows,"gthumb");
			echo "\n      </gthumb>";	
			
			echo "\n   </game>";	
		}
	echo "\n</games>";
}else{
	echo "failed";
}
disconnect();
?>