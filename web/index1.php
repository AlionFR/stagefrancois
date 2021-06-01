<html lang="fr">
	<head>
		<title>Gestionnnaire des imprimantes</title>
	</head>

	<body>
		<h1>Liste des imprimantes :  </h1>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>NOM</th>
					<th>NIVEAU ENCRE</th>
					<th>EMPLACEMENT</th>
					<th>DERNIER CONTACT</th>
				</tr>
			</thead>
			<tbody>
				<?php
					$link = mysqli_connect('localhost', 'printersink', '', 'printersink');

					if (!$link) {
					  die('Erreur de connexion');
					} else {
					  // echo 'Connecté avec succès... ';
					  $result = mysqli_query($link, "SELECT * FROM printers");
					  while ($ligne = mysqli_fetch_assoc($result)) {
					  	echo "<tr><td>".$ligne["id"]."</td><td>".$ligne["name"]."</td><td>".$ligne["ink"]."</td><td>".$ligne["location"]."</td><td>".$ligne["last_updated"]."</tr>";
					  }
					}
				?>
			</tbody>
		</table>
	</body>
	<style>
		table, td {
    		border: 1px solid #333;
		}

		thead, tfoot {
    		background-color: #333;
    		color: #fff;
		}
	</style>
</html>