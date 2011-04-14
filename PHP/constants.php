<?php
    // Database Constants
    define("DB_SERVER", "localhost");
    define("DB_USER", "root");
    define("DB_PASS", ""); //insert password
    define("DB_NAME", "sciencepluz"); //insert dbname
	function connect(){		
		$connection = mysql_connect(DB_SERVER,DB_USER,DB_PASS);
		if (!$connection){
			die("Database connection failed: " . mysql_error());
		}
		if (!mysql_select_db(DB_NAME,$connection)){
			die("Database selection failed: " . mysql_error());
		}
	}
	function disconnect(){
		mysql_close();
	}
	
?>