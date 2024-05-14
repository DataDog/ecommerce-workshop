#!/bin/bash
  
checkStoredog() {
  wget --quiet -O - $STOREDOG_URL |grep -qi storedog
}

printf "\nWaiting for Storedog"

until checkStoredog; do
  printf .
  sleep 2
done

printf "\nBrowser replay starting.\n\n"

while :
do
  node puppeteer.js $STOREDOG_URL
done
