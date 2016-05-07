INFILE=$1
OUTFILE=${INFILE%.rhtml}.html

echo $INFILE to $OUTFILE

fswatch -0 $INFILE | while read -d "" event
do
  echo -n "Building... "
  erb $INFILE &> $OUTFILE
  if [ $? -ne 0 ]; then
    sed -i '' -e '1i\
    <pre style="background:#fdd;">' $OUTFILE
  fi
  echo "done."
done
