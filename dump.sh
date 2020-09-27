#!/bin/bash

DUMP_URL=http://download.wikimedia.org/sawiki/latest/sawiki-latest-pages-articles.xml.bz2
wget ${DUMP_URL}

# Check if the dump file has changed
if [ -f prev_checksum.txt ]
then
    md5sum sawiki-latest-pages-articles.xml.bz2 > curr_checksum.txt
    diff prev_checksum.txt curr_checksum.txt >/dev/null 2>&1
	if [ $? -eq 0 ]
	then
		exit
	fi
fi

# Get WikiExtractor
git clone https://github.com/attardi/wikiextractor.git
cd wikiextractor
# Checkout the last commit that was working. 
# See https://github.com/attardi/wikiextractor/issues/216#issuecomment-692529763
git checkout e4abb4cbd019b0257824ee47c23dd163919b731b
# Run wikiextractor
python WikiExtractor.py -c -o sawiki --no-templates sawiki-latest-pages-articles.xml.bz2
# Dump all the files into one XML file and zip
find sawiki -name '*bz2' -exec bunzip2 -c {} \; > sawiki.xml
zip sawiki.xml.zip sawiki.xml

# Update checksum
md5sum sawiki-latest-pages-articles.xml.bz2 > prev_checksum.txt