<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="A layout example that shows off a blog page with a list of posts.">
	<title>BePaper's printers dashboard</title>
	<link rel="stylesheet" href="./css/pure-min.css">
	<link rel="stylesheet" href="./css/grids-responsive-min.css">
	<link rel="stylesheet" href="./css/styles.css">
</head>
<body>

<div id="layout" class="pure-g">
	<div class="sidebar pure-u-1 pure-u-md-1-4">
		<div class="header">
			<h1 class="brand-title">BePaper's printers</h1>
			<h2 class="brand-tagline">A simple panel to view printers</h2>

			<nav class="nav">
				<ul class="nav-list">
					<li class="nav-item">
						<a target="_blank" class="pure-button" href="http://localhost/phpmyadmin/">DB ACCESS</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>

	<div class="content pure-u-1 pure-u-md-3-4">

		<form action="index.php" method="GET" style="display:flex;align-items:center;">
			<a href="index.php"><img src="img/home.png" width="32px" style="display:inline-block;padding-right:20%;"></a>
			<input id="search" name="search" type="text" placeholder="Type here" value="<?php if (isset($_GET['search'])) {echo $_GET['search'];}?>">
			<input id="submit" type="submit" value="Search" style="cursor: pointer;">
		</form>
		<div>
			<?php
				$link = mysqli_connect('localhost', 'printersink', '', 'printersink');

				if (!$link) {
					die('Erreur de connexion');
				} else {
					// echo 'Connecté avec succès... ';

					if (isset($_GET['search'])) {
						$search = $_GET['search'];
						$search = $link -> real_escape_string($search);

						$query = "SELECT * FROM `printers` WHERE name LIKE '%".$search."%' OR ip LIKE '%".$search."%' ORDER BY `printers`.`ink` ASC";
						$result = $link -> query($query);	

						while($row = $result -> fetch_object()){
							echo "<h1 style='color:white;background:#3d4f5d;' class='content-subhead'>&nbsp".$row -> name."</h1>";
							if ($row -> ink < 10) {
								echo "</h1><div class='danger'><p><strong>Attention !</strong> Il reste très peu d'encre dans cette imprimante..</p></div>";
							}
							echo "
								<section class='post'>
									<div class='post-description'>
										<p>Niveau d'encre : ".$row -> ink."%</p>
										<p>Adresse IP : ".$row -> ip."</p>
										<p>Emplacement : ".$row -> location."</p>
										<p>Dernière mise à jour : ".$row -> last_updated."</p>
									</div>
								</section>"; 
						}
					} else {
						$result = mysqli_query($link, "SELECT * FROM `printers` ORDER BY `printers`.`ink` ASC");
						while ($ligne = mysqli_fetch_assoc($result)) {
							echo "<h1 style='color:white;background:#3d4f5d;' class='content-subhead'>&nbsp".$ligne["name"]."</h1>";
							if ($ligne["ink"] < 10) {
								echo "</h1><div class='danger'><p><strong>Attention !</strong> Il reste très peu d'encre dans cette imprimante..</p></div>";
							}
							echo "
								<section class='post'>
									<div class='post-description'>
										<p>Niveau d'encre : ".$ligne["ink"]."%</p>
										<p>Adresse IP : ".$ligne["ip"]."</p>
										<p>Emplacement : ".$ligne["location"]."</p>
										<p>Dernière mise à jour : ".$ligne["last_updated"]."</p>
									</div>
								</section>";
						}
					}
				}
				?>
			<!-- <div class="footer">
				<div class="pure-menu pure-menu-horizontal">
					<ul>
						<li class="pure-menu-item"><a href="http://purecss.io/" class="pure-menu-link">About</a></li>
						<li class="pure-menu-item"><a href="http://twitter.com/yuilibrary/" class="pure-menu-link">Twitter</a></li>
						<li class="pure-menu-item"><a href="http://github.com/pure-css/pure/" class="pure-menu-link">GitHub</a></li>
					</ul>
				</div>
			</div> -->
		</div>
	</div>
</div>

</body>
</html>
