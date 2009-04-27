#!/bin/bash

rm -Rf sources/$1/phpQuery/phpQuery/Zend/
mkdir sources/$1/phpQuery/phpQuery/Zend/

for toCopy in "Loader.php" "Uri.php" "Exception.php" "Http" "Json" "Uri" "Validate" "Registry.php"
do
	cp -Rf /home/bob/Sources/PHP/zend-framework/Zend/$toCopy sources/$1/phpQuery/phpQuery/Zend/
done
find sources/$1/phpQuery/phpQuery/Zend/ -name .svn -exec rm -rf {} \;
rm sources/$1/phpQuery/phpQuery/Zend/Json/Server.php
rm -R sources/$1/phpQuery/phpQuery/Zend/Json/Server
