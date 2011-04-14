<?php
if ($handle = opendir('../userimages/')) {
	echo "<images>";
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && exif_imagetype("../userimages/$file")) {
			echo "\n   <image>";
			echo "\n      <address>";
            echo "\n         ../userimages/";
			echo "\n      </address>";
			echo "\n      <filename>";
            echo "\n         $file";
			echo "\n      </filename>";
			echo "\n   </image>";
        }
    }	
	echo "\n</images>";
    closedir($handle);
	
}
?>