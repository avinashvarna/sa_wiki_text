# Sanskrit Wikipedia Text Dump

This repo uses [WikiExtractor](https://github.com/attardi/wikiextractor) for dumping the text from Sanskrit Wikipedia. 
The zipped dumped text in XML format is available [here](https://github.com/avinashvarna/sa_wiki_text/blob/gh-pages/sawiki.xml.zip?raw=true). The XML document format is specified [here](https://github.com/attardi/wikiextractor/wiki/File-Format).

Please see this [notebook](https://github.com/avinashvarna/sa_wiki_text/blob/master/process_sa_wiki_dump.ipynb) for an example of how to use the data.

As a hack, this repo uses Travis-CI to run the dump script periodically and upate the dump.
