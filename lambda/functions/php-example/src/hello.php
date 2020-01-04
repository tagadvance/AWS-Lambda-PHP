<?php

$contents = stream_get_contents(STDIN);
$payload = json_decode($contents, true);

print json_encode("Hello, {$payload['name']}!");
