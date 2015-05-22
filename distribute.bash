#/bin/bash
name="ligo"
state="unstable"
projectdir="/home/thiolliere/love/project/"$name
sitedir="/home/thiolliere/site/jekyll/"

cd $projectdir
mkdir ../zip
cp -r * -d ../zip
cd ../zip
zip -9r $name".love" .

mv $name".love" $sitedir"/"$name"/download/"$state
cd ..
rm -r "zip"
cd $sitedir"/"$name"/download/"$state

unzip $name"_win32.zip"
unzip $name"_win64.zip"
rm $name"_win32.zip"
rm $name"_win64.zip"
cat $name"_win64/love.exe" $name".love" > $name"_win64/"$name".exe"
cat $name"_win32/love.exe" $name".love" > $name"_win32/"$name".exe"
zip -9r $name"_win32.zip" $name"_win32"
zip -9r $name"_win64.zip" $name"_win64"
rm -r $name"_win32"
rm -r $name"_win64"

unzip $name"_osx.zip"
cp -r $name".love" $name".app/Contents/Resources/"
zip -9qr $name"_osx.zip" $name".app"
rm -r $name".app"

cd $sitedir
jekyll build
