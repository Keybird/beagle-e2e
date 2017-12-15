#!/bin/bash
# show versions
echo "npm" + $(npm --version)
echo "protractor" + $(protractor --version)
google-chrome --version
java -version
curl --version

# start selenium server in background
echo "Starting selenium server"
webdriver-manager start &

# small delay
sleep 5

# run test
echo "Running tests"
protractor $@

# Have it quit correctly
RESULT=$?
echo "Done running test: ${RESULT}"
exit ${RESULT}