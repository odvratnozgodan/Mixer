<?PHP


// This is the temporary file created by PHP 
date_default_timezone_set("Europe/Zagreb");
$filename='../saved/soundTest_'.time().'.mp3';
$fp = fopen( $filename, 'wb' );
fwrite( $fp,  $GLOBALS[ 'HTTP_RAW_POST_DATA' ]  );
fclose( $fp );


echo $filename;

///////////////////





?>
