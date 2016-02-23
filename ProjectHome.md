# phpQuery - pq(); #
**phpQuery** is a server-side, chainable, CSS3 selector driven Document Object Model (DOM) API [based on](http://code.google.com/p/phpquery/wiki/jQueryPortingState) [jQuery JavaScript Library](http://jquery.com/).

Library is written in [PHP5](http://code.google.com/p/phpquery/wiki/Dependencies) and provides additional [Command Line Interface](http://code.google.com/p/phpquery/wiki/CommandLineInterface) (CLI).

## PEAR installation ##
```
pear channel-discover phpquery-pear.appspot.com  
pear install phpquery/phpQuery 
```

## `GitHub` ##
Fork & pull request: [github.com/TobiaszCudnik/phpquery](https://github.com/TobiaszCudnik/phpquery).

## [Download](http://code.google.com/p/phpquery/downloads/list) ##
  * [Available packages](http://code.google.com/p/phpquery/downloads/list) ([rss](http://code.google.com/feeds/p/phpquery/downloads/basic))
  * [Release notes](http://phpquery-library.blogspot.com/search/label/release)
  * Bugs: [active](http://code.google.com/p/phpquery/issues/list?can=2&q=label%3AType-Defect) / [fixed](http://code.google.com/p/phpquery/issues/list?can=1&q=label%3AType-Defect%20status%3AFixed)
  * [Dependencies](http://code.google.com/p/phpquery/wiki/Dependencies)
  * [SVN checkout](http://code.google.com/p/phpquery/wiki/SVNCheckout)

## [Manual](http://code.google.com/p/phpquery/wiki/Manual) ##
  1. [Basics](http://code.google.com/p/phpquery/wiki/Basics)
  1. [Ported jQuery sections](http://code.google.com/p/phpquery/wiki/jQueryPortingState)
    1. [Selectors](http://code.google.com/p/phpquery/wiki/Selectors)
    1. [Attributes](http://code.google.com/p/phpquery/wiki/Attributes)
    1. [Traversing](http://code.google.com/p/phpquery/wiki/Traversing)
    1. [Manipulation](http://code.google.com/p/phpquery/wiki/Manipulation)
    1. [Ajax](http://code.google.com/p/phpquery/wiki/Ajax)
    1. [Events](http://code.google.com/p/phpquery/wiki/Events)
    1. [Utilities](http://code.google.com/p/phpquery/wiki/Utilities)
    1. [Plugin ports](http://code.google.com/p/phpquery/wiki/PluginsClientSidePorts)
  1. [PHP Support](http://code.google.com/p/phpquery/wiki/PHPSupport)
  1. [Command Line Interface](http://code.google.com/p/phpquery/wiki/CommandLineInterface)
  1. [Multi document support](http://code.google.com/p/phpquery/wiki/MultiDocumentSupport)
  1. [Plugins](http://code.google.com/p/phpquery/wiki/PluginsServerSide)
    1. [WebBrowser](http://code.google.com/p/phpquery/wiki/WebBrowser)
    1. [Scripts](http://code.google.com/p/phpquery/wiki/ScriptsPlugin)
  1. [jQueryServer](http://code.google.com/p/phpquery/wiki/jQueryServer)
  1. [Debugging](http://code.google.com/p/phpquery/wiki/Debugging)
  1. Bootstrap file

## Documentation ##
  * **[Wiki](http://code.google.com/p/phpquery/w/list)**
  * [Manual](http://code.google.com/p/phpquery/wiki/Manual)
  * [API reference](http://meta20.net/phpquery-api/)
  * [jQuery documentation wiki](http://docs.jquery.com/Main_Page)
    * [CHM version](http://www.box.net/index.php?rm=box_download_shared_file&file_id=f_196697302&shared_name=p5gk0bnk94)
    * [CheatSheet](http://colorcharge.com/wp-content/uploads/2007/12/jquery12_colorcharge.png)

## Publications ##
  * **[Official blog](http://phpquery-library.blogspot.com/)** with latest [release notes](http://phpquery-library.blogspot.com/search/label/release)
  * [Author's blog](http://tobiasz123.wordpress.com/) with [examples and new feature sneak peaks](http://tobiasz123.wordpress.com/tag/phpquery/)
  * Follow **[phpQuery on Twitter](http://twitter.com/phpQuery)**
  * Roadmap: [Planned](http://code.google.com/p/phpquery/issues/list?q=label%3AEnhancement&can=2&sort=milestone) / [Completed](http://code.google.com/p/phpquery/issues/list?can=1&q=label%3AEnhancement%20status%3AFixed&sort=milestone)

## Feedback ##
  * **[Issue/Bug Tracker](http://code.google.com/p/phpquery/issues/list?sort=milestone)** ([new issue](http://code.google.com/p/phpquery/issues/entry))
  * **[Google Group](http://groups.google.com/group/phpquery/topics?gvc=2)**
  * **IRC** #phpquery at [freenode.net](http://freenode.net/)
  * **ohloh.net** has [phpQuery project](https://www.ohloh.net/projects/phpquery)

---

# Examples #
## [CLI](CommandLineInterface.md) ##
Fetch number of downloads of all release packages
```
phpquery 'http://code.google.com/p/phpquery/downloads/list?can=1' \
  --find '.vt.col_4 a' --contents \
  --getString null array_sum
```
## PHP ##
Examples from [demo.php](http://code.google.com/p/phpquery/source/browse/branches/dev/demo.php)
```
require('phpQuery/phpQuery.php');
// for PEAR installation use this
// require('phpQuery.php');
```

#### INITIALIZE IT ####
```
// $doc = phpQuery::newDocumentHTML($markup);
// $doc = phpQuery::newDocumentXML();
// $doc = phpQuery::newDocumentFileXHTML('test.html');
// $doc = phpQuery::newDocumentFilePHP('test.php');
// $doc = phpQuery::newDocument('test.xml', 'application/rss+xml');
// this one defaults to text/html in utf8
$doc = phpQuery::newDocument('<div/>');
```

#### FILL IT ####
```
// array syntax works like ->find() here
$doc['div']->append('<ul></ul>');
// array set changes inner html
$doc['div ul'] = '<li>1</li><li>2</li><li>3</li>';
```

#### MANIPULATE IT ####
```
// almost everything can be a chain
$li = null;
$doc['ul > li']
	->addClass('my-new-class')
	->filter(':last')
		->addClass('last-li')
// save it anywhere in the chain
		->toReference($li);
```

#### SELECT DOCUMENT ####
```
// pq(); is using selected document as default
phpQuery::selectDocument($doc);
// documents are selected when created or by above method
// query all unordered lists in last selected document
pq('ul')->insertAfter('div');
```

#### ITERATE IT ####
```
// all LIs from last selected DOM
foreach(pq('li') as $li) {
	// iteration returns PLAIN dom nodes, NOT phpQuery objects
	$tagName = $li->tagName;
	$childNodes = $li->childNodes;
	// so you NEED to wrap it within phpQuery, using pq();
	pq($li)->addClass('my-second-new-class');
}
```

#### PRINT OUTPUT ####
```
// 1st way
print phpQuery::getDocument($doc->getDocumentID());
// 2nd way
print phpQuery::getDocument(pq('div')->getDocumentID());
// 3rd way
print pq('div')->getDocument();
// 4th way
print $doc->htmlOuter();
// 5th way
print $doc;
// another...
print $doc['ul'];
```