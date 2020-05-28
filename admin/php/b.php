<?php
$kubeconfig = "/var/www/html/php/.kube/config";

putenv("KUBECONFIG=$kubeconfig");

shell_exec("KUBECONFIG=$kubeconfig ; kubectl delete -f ./deployment/deploy_now.yml");
shell_exec("rm -rf /sitios/$_SESSION[username]");
header("Location: exit.php");
?>