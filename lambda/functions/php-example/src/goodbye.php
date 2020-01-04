<?php

$contents = stream_get_contents(STDIN);
$payload = json_decode($contents, true);

print "Goodbye, {$payload['name']}!";
