<?php
$kubeconfig = "/var/www/html/php/.kube/config"; // The config file

putenv("KUBECONFIG=$kubeconfig"); // set the environment variable KUBECONFIG

$output = shell_exec("KUBECONFIG=$kubeconfig ; kubectl apply -f ./deployment/deploy_now.yml"); // Runs the command 

// echo "<pre>$output</pre>"; // and return the expected output.
header("Location: ../../index.php");
?>