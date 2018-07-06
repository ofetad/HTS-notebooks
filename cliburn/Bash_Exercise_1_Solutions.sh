
rm -rf ~/docs

cd
mkdir docs
cd docs

echo 'first,last,middle,age,sex' > echo.txt
echo 'Jane,Frost,G,23,F' >> echo.txt
echo 'John,Mundy,F,25,M' >> echo.txt
echo 'Bob,Evans,H,57,M' >> echo.txt
echo 'John,Smith,M,4,M' >> echo.txt

cat echo.txt

cat <<EOF > cat.txt
first,last,middle,age,sex
Jane,Frost,G,23,F
John,Mundy,F,25,M
Bob,Evans,H,57,M
John,Smith,M,4,M
EOF

cat cat.txt

# Simulate using editor
# You should not do this!

cp cat.txt editor.txt

pwd

cd

ls docs

mkdir docs/stuff

cd docs
mv cat.txt editor.txt stuff

cp echo.txt stuff/echoecho.txt

ls -R ~/docs

rm -rf stuff
cd
ls -R docs

tail +2 docs/echo.txt

tail +2 docs/echo.txt | sort -t',' -k 1

tail +2 docs/echo.txt | sort -t',' -rn -k 4

grep 'John' docs/echo.txt

grep -v 'John' docs/echo.txt

grep 'J...' docs/echo.txt

cat docs/echo.txt | cut -d ',' -f 1-3 | tail +2 | sort -t ',' -k 2 > docs/names.txt 

cat docs/names.txt

cat docs/echo.txt | sed 's/John/Tom/g'

cat docs/echo.txt | awk 'BEGIN {FS = ","} ; $5 == "M"' > docs/male.txt

cat docs/male.txt

ls docs

for FILE in $(ls ~/docs/*)
do
    DIR_NAME=$(dirname $FILE)
    FILE_NAME=$(basename $FILE)
    NAME=${FILE_NAME%.*}
    NEW_DIR=$DIR_NAME/$NAME
    NEW_FILE=${NAME}-copy.txt
    mkdir -p $NEW_DIR
    cat $FILE | head -3 | tail -2  > $NEW_DIR/$NEW_FILE
done

ls -R ~/docs

wc docs/*/*
