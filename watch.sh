fswatch -0 index.rhtml | while read -d "" event
do
  echo -n "Building... "
  erb index.rhtml &> index.html
  if [ $? -ne 0 ]; then
    sed -i '' -e '1i\
    <pre style="background:#fdd;">' index.html
  fi
  echo "done."
done
