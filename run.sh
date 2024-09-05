#!/bin/bash

# API endpoint and key
ID="<AccessID>"
KEY="<AccessKey>"

#Choose your endpoint based on your Sumologic deployment. https://help.sumologic.com/docs/api/getting-started/
ENDPOINT="https://api.sumologic.com" 

createQuery()
{
        cat <<EOFF > ./query.txt
_sourceCategory=*
| count by _sourceCategory
EOFF

}

createJsonEscapedQuery_querypayload()
{
    # DURATION_MS=900; #last 15m
    # EPOC=$(date +%s)
    # ((EPOC_F=EPOC - DURATION_MS - 120 )) 
    # ((EPOC_T=EPOC - 120 ))
    # TIME_F=$(date --date=@${EPOC_F} "+%FT%H:%M:00")
    # TIME_T=$(date --date=@${EPOC_T} "+%FT%H:%M:00")

    # Change the time range as you want
    TIME_F="2024-09-01T00:00:00"
    TIME_T="2024-09-01T01:00:00"


    cat ./query.txt | jq -Rs . > ./jsonEscapedQuery.txt

    cat <<EOFF > ./createSearchJob.json
{
"query": `cat ./jsonEscapedQuery.txt`,
"from": "${TIME_F}",
"to": "${TIME_T}",
"timeZone": "Asia/Seoul",
"byReceiptTime": false
}
EOFF

}

runSearch()
{

    APIENDPOINT="$ENDPOINT/api/v1/search/jobs"
 
    ## Run Search Job
    RUNID=`curl -b cookies.txt -c cookies.txt -H 'Content-type: application/json' -H 'Accept: application/json' -X POST -T ./createSearchJob.json --user $ID:$KEY $APIENDPOINT | jq -r '.id'`    
    echo "RUNID: $RUNID"
    sleep 5;

 
    ## Status check
    echo "Status check Started"
    CHECK="GATHERING RESULTS"
    while [[ "$CHECK" == "GATHERING RESULTS" ]];do
    CHECK=`curl  -b cookies.txt -c cookies.txt -H 'Accept: application/json' --user $ID:$KEY ${APIENDPOINT}/$RUNID | jq -r '.state'`

    echo "Status: $CHECK"
    sleep 10;
    done

    ## Get aggregated results
    curl -b cookies.txt -c cookies.txt -H 'Accept: application/json' --user $ID:$KEY ${APIENDPOINT}/$RUNID/records?offset=0\&limit=10000 | tee ./agg_result.txt

    ## Get messages results
    curl -b cookies.txt -c cookies.txt -H 'Accept: application/json' --user $ID:$KEY ${APIENDPOINT}/$RUNID/messages?offset=0\&limit=10000 | tee ./msg_result.txt
    

    # Deleate the search Job
    curl -b cookies.txt -c cookies.txt -X DELETE -H 'Accept: application/json' --user $ID:$KEY ${APIENDPOINT}/$RUNID

}


createQuery;
createJsonEscapedQuery_querypayload
runSearch;