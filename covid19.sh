#!/bin/bash
# 
if ! command -v curl &> /dev/null
then
	echo "Error: curl is not installed."
	exit
fi
if ! command -v jq &> /dev/null
then
	echo "Error: jq is not installed."
	exit
fi

read -p 'Country code: ' country

api="https://disease.sh/v3/covid-19/countries/"
updated="$(curl -s -X GET "${api}${country}" | jq '.updated')"
confirmed="$(curl -s -X GET "${api}${country}" | jq '.cases')"
recovered="$(curl -s -X GET "${api}${country}" | jq '.recovered')"
deaths="$(curl -s -X GET "${api}${country}" | jq '.deaths')"
todayCases="$(curl -s -X GET "${api}${country}" | jq '.todayCases')"
todayRecovered="$(curl -s -X GET "${api}${country}" | jq '.todayRecovered')"
todayDeaths="$(curl -s -X GET "${api}${country}" | jq '.todayDeaths')"
tests="$(curl -s -X GET "${api}${country}" | jq '.tests')"

date -d "@$((updated/1000))" +"%B %d %Y %I:%M %p" && echo -e
echo "Confirmed: ${confirmed}"
echo "Recovered: ${recovered}"
echo "Deaths: ${deaths}"
echo -e
echo "Cases Today: ${todayCases}"
echo "Recovered Today: ${todayRecovered}"
echo "Deaths Today: ${todayDeaths}"
echo -e
echo "Tests: ${tests}"


