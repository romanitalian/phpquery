#!/usr/bin/env php
<?php
$version = $argv[1];
$dir = getcwd();

/* ALL-IN-ONE */
chdir("$dir/sources/$version/phpQuery/phpQuery");
$file = file_get_contents("phpQuery.php");
$m = array();
$dirName = '(?:'.preg_quote('dirname(__FILE__).').')?';
$allIneOne = preg_replace_callback(
	'@(?:require|include)(?:_once)?\s*\(\s*'.$dirName.'\s*[\'"]([^\'"]+)[\'"]\s*\)\s*;@',
	'replace_include', $file
);

/* CLI */
// chdir("$dir/sources/$version/phpQuery/cli");
// $allIneOneCli = file_get_contents('phpquery');
// $allIneOneCli = preg_replace(
// 	'@/\* ALL-IN-ONE-SECTION-START \*/.+/\* ALL-IN-ONE-SECTION-END \*/@s',
// 	removePhpTags($allIneOne), $allIneOneCli
// );

/* SAVE */
chdir("$dir/sources/$version");
file_put_contents('phpQuery-onefile.php', $allIneOne);
// file_put_contents('phpquery', $allIneOneCli);
// exec('chmod +x phpquery');

/* FUNCTIONS */
function replace_include($matches) {
	$path = ltrim($matches[1], '/');
	if (substr($path, 0, 4) == 'Zend')
		return $matches[0];
	return removePhpTags(file_get_contents($path));
}
function removePhpTags($content) {
	return preg_replace(
		'@^<\?php@', '', $content
	);
}
?>