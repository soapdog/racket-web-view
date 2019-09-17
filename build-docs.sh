#!/bin/sh

cd ./scribblings
scribble --htmls ++main-xref-in --redirect-main http://docs.racket-lang.org/ --dest ../docs/ ./web-view.scrbl 
cd ../docs
mv ./web-view/* ./
rm -rf ./web-view
cd ..