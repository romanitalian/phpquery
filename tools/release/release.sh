#!/bin/sh

# if -eq $1 ""; then
# 	exit 1 "No version numer";
# fi

# variables
#svnDir = 'trunk'
svnDir='branches/dev'
workingDir=$(pwd)
revision=$(svn info http://phpquery.googlecode.com/svn/$svnDir | grep Revision | sed -r 's/^.+ ([0-9]+)$/\1/');
release=$1'.'$revision;

# directories
rm -Rf dist/$release
mkdir dist/$release
rm -Rf sources/$release
#mkdir dist/$release/phpQuery-onefile

# checkout
svn export http://phpquery.googlecode.com/svn/$svnDir sources/$release/phpQuery
#svn merge http://phpquery.googlecode.com/svn/trunk http://phpquery.googlecode.com/svn/branches/dev/ trunk

#./zend.sh $release

./onefile.php $release

# doc files
#svn log http://phpquery.googlecode.com/svn/$svnDir > debian/changelog
sources/$release/phpQuery/cli/phpquery http://code.google.com/p/phpquery/ \
	--find li --append "\n" --prepend ' * ' --end \
	--find 'ul > ul > li, ol > ol > li' --prepend '  ' --end \
	--find '#wikicontent > *' --text > debian/README.Debian	
#sources/$release/phpQuery/cli/phpquery http://www.opensource.org/licenses/mit-license.php --find '#node-66 .content' --text > sources/$release/phpQuery/LICENSE

# TODO: api reference
#./api-reference

cd sources/$release/

# full package
zip -r9 $workingDir/dist/$release/phpQuery-$release.zip phpQuery
#mv phpQuery phpQuery-$release

# pear package
$workingDir/package-pear $release

# onefile package
zip -r9 $workingDir/dist/$release/phpQuery-$release-onefile.zip phpQuery-onefile.php

# linux packages
$workingDir/package-deb $release
$workingDir/package-rpm $release


#tar -czvf $workingDir/sources/$release/phpQuery-$release.tar.gz phpQuery-$release
#mkdir phpQuery-onefile-$release
#mv phpquery phpQuery-onefile-$release
#tar -czvf $workingDir/sources/$release/phpQuery-onefile-$release.tar.gz phpQuery-onefile-$release

# rpm standard
#sed -ir 's/Version: .*$/Version: '$release'/' phpquery.spec
#sed -ir 's/Source: .*$/Source: phpQuery-'$release'.tar.gz/' phpquery.spec
#sudo cp sources/$release/phpQuery-$release.tar.gz /usr/src/packages/SOURCES
#sudo rpmbuild -ba phpquery.spec
#cp /usr/src/packages/RPMS/noarch/phpQuery-$release-1.noarch.rpm dist/$release/


# rpm onefile
#sed -ir 's/Version: .*$/Version: '$release'/' phpquery-onefile.spec
#sed -ir 's/Source: .*$/Source: phpQuery-onefile-'$release'.tar.gz/' phpquery-onefile.spec
#sudo cp sources/$release/phpQuery-onefile-$release.tar.gz /usr/src/packages/SOURCES
#sudo rpmbuild -ba phpquery-onefile.spec
#cp /usr/src/packages/RPMS/noarch/phpQuery-onefile-$release-1.noarch.rpm dist/$release/

# finish
cd $workingDir