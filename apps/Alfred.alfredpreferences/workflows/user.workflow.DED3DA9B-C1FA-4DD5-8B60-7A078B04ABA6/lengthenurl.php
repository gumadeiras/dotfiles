<?

# Something will probably go wrong, 
# you can either mail me the fix or... the problem at David@Staron.nl :)

require_once('extension_utils.php');
$utils = new ExtensionUtils();

$results = array();
$org = $argv[1];
$orgplushttp=addhttp($org);

$text = utf8_encode( urlencode($org));
error_reporting(0);	// if we get weird input we don't want to report errors, because Alred
					// will read it as input and won't know what to do with it.
					// Instead, catch the error later and return something usefull.

try {
	$json = file_get_contents("http://api.longurl.org/v2/expand?url=$text&content-type=1&format=json");        

	$jsonIterator = new RecursiveIteratorIterator(
		new RecursiveArrayIterator(json_decode($json, TRUE)),
			 RecursiveIteratorIterator::SELF_FIRST);

	foreach ($jsonIterator as $key => $val) {   
	    if(is_array($val)) {            
	        //echo "$key:\n";            
	    } else { 
	  		//echo "$key => $val\n";
	  		if ($key="long-url") {	
			    $item = array(
			        'uid' => 'Lengthen url {query}',
			        'arg' => $orgplushttp,
			        'title' => $val,
			        'subtitle' => "Open $orgplushttp in webbrowser",
			        'icon' => 'icon.png',
			        'valid' => 'yes'
			    );
			    array_push( $results, $item );
			    break;
	    	}
	    }
	}

} catch (Exception $e) {
    	//echo 'Caught exception: ',  $e->getMessage(), "\n";
		$item = array(
		        'uid' => 'Lengthen url {query}',
		        'arg' => '',                                
		        'title' => 'Invalid url...',
		        'subtitle' => $org,
		        'icon' => 'icon.png',
		        'valid' => 'no'
		    );
		    array_push( $results, $item );
}

if ( count( $results ) > 0 ):	
	echo $utils->arrayToXml( $results );
endif;


# add http:// if 'http://' or 'https://' is not found;
function addhttp($url) {
    if (!preg_match("~^(?:f|ht)tps?://~i", $url)) {
        $url = "http://" . $url;
    }
    return $url;
}