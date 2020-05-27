<?php

require_once '../core.php';
require_once '../ddbb.php';

$kubeconfig = "/var/www/html/php/.kube/config";

putenv("KUBECONFIG=$kubeconfig");

$output = shell_exec("KUBECONFIG=$kubeconfig ; kubectl logs bcn-deployment-b758b5cf5-7snjd | grep 'mysql -u' | xargs | cut -d ' ' -f 3 | cut -c 3-112");
echo $output;
#header("Location: ../../index.php");
?>