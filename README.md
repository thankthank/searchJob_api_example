# Search Job API Example

This is the complete example to run search job API based on the guide, https://help.sumologic.com/docs/api/search-job/

This example will run the query below with -15m time range.
```
_sourceCategory=*
| count by _sourceCategory
```

## Below are the steps to run this query

### Download the script, run.sh
Downlowd the script, run.sh in a linux machine.
Add execution permission.
```
chmod 755 ./run.sh
```

### Get Access key
Use the guide to get an access key. https://help.sumologic.com/docs/manage/security/access-keys/
And put this in the part of the script below.
```
#!/bin/bash

# API endpoint and key
ID="xxxxx"
KEY="xxxxxxxxxxxx"
.
.
.
```

### Get the API endpoint
Find what API endpoint you need to use in the guide. https://help.sumologic.com/docs/api/getting-started/
And put this in the part of the script below. You can see the example value.
```
.
.
.
ENDPOINT="https://api.sumologic.com" 
.
.
.
```

### Run the script
```
./run.sh
```
