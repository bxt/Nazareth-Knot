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

osascript <<END
  tell application "Firefox"
    activate
    tell application "System Events" to keystroke "r" using command down
  end tell
END

done
