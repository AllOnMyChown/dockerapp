 <?php echo '<p>Hello World!</p>'; ?>

<?php
$file = '/tmp/data/test.txt';
// Open the file to get existing content
// $current = file_get_contents($file);
// Append a new person to the file
$current = date("l jS \of F Y h:i:s A \n") ;
// Write the contents back to the file
file_put_contents($file, $current, FILE_APPEND);
chmod($file, 0777);




$testfile = '/tmp/data/newdirectory/test.txt';
// Open the file to get existing content
// $current = file_get_contents($file);
// Append a new person to the file
// Write the contents back to the file
file_put_contents($testfile, $current, FILE_APPEND);
?>