<?php

require_once 'core.php';
require_once 'ddbb.php';

$kubeconfig = "/var/www/html/php/.kube/config";

putenv("KUBECONFIG=$kubeconfig");

shell_exec("KUBECONFIG=$kubeconfig ; kubectl apply -f ./deployment/deploy_now.yml; sleep 50");
shell_exec("mkdir /sitios/$_SESSION[username]");
$deploy = shell_exec("KUBECONFIG=$kubeconfig ; kubectl describe pod $_SESSION[username] | head -1 | xargs | cut -d ' ' -f 2");
$deploy=trim($deploy);
$output = shell_exec("KUBECONFIG=$kubeconfig ; kubectl logs $deploy | grep 'mysql -u' | xargs | cut -d ' ' -f 3 | cut -c 3-112");
$output = trim($output);
mysqli_query($connect," UPDATE `users` SET `mysql_pass` = '$output' WHERE `username` = '$_SESSION[username]';");
mysqli_query($connect," UPDATE `users` SET `deployment` = '$deploy' WHERE `username` = '$_SESSION[username]';");

header("Location: ../../index.php");
?>