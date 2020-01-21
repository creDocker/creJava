sleep 2

if [ ! -f /cre/versions.txt ]; then
    echo "[FAIL]: File /cre/versions.txt not found!"
    exit 1
fi

isInFile=$(cat /cre/versions.txt | grep -c "creJava")
if [ $isInFile -eq 0 ]; then
    echo "[FAIL]: Java not installed!"
    exit 1
fi

isInFile=$(cat /cre/versions.txt | grep -cP "creJava \t $JAVA_VERSION")
if [ $isInFile -eq 0 ]; then
    echo "[WARNING]: Wrong version of Java installed!"
    #exit 1
fi

# No test in the moment

echo "[SUCCESS]"
exit 0
