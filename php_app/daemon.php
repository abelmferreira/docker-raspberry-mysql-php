<?php
	require_once('funcoes/database.php');

	// Check mysql
		$conn=false;
		while (!$conn) {
			$conn = mysqli_connect($hostname, $username, $password, $database);
			if ($conn) {
				echo "Teste do mysql concluido com sucesso..."."\n";
			} else {
				echo "mysql error... ". mysqli_connect_error()."\n";
				sleep(5);
			}
		}
		if ($conn) {
			mysqli_close($conn);
			echo "Finalizando testes do mysql..."."\n";
		}


	
	echo "My PHP Script here!";
?>
