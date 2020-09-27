#!/bin/bash


DUMP_URL=http://download.wikimedia.org/sawiki/latest/sawiki-latest-pages-articles.xml.bz2

# Create a temp directory for intermediate files
mkdir temp
cd temp
wget ${DUMP_URL}

# Get WikiExtractor
git clone https://github.com/attardi/wikiextractor.git
cd wikiextractor
# Checkout the last commit that was working. 
# See https://github.com/attardi/wikiextractor/issues/216#issuecomment-692529763
git checkout e4abb4cbd019b0257824ee47c23dd163919b731b
cd -
# Run wikiextractor
python wikiextractor/WikiExtractor.py -c -o sawiki --no_templates sawiki-latest-pages-articles.xml.bz2
# Dump all the files into one XML file and zip
find sawiki -name '*bz2' -exec bunzip2 -c {} \; > sawiki.xml
zip ../sawiki.xml.zip sawiki.xml

# Cleanup
cd ..
rm -rf temp
ls -lh