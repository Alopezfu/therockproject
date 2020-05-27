<?php
$kubeconfig = "/var/www/html/php/.kube/config";

putenv("KUBECONFIG=$kubeconfig");

$output = shell_exec("KUBECONFIG=$kubeconfig ; kubectl delete -f ./deployment/deploy_now.yml");

header("Location: exit.php");
?>