# Search Job API Example

This is the complete example to run search job API based on the guide. https://help.sumologic.com/docs/api/search-job/

This example will run the query below with a fixed time range.
```
_sourceCategory=*
| count by _sourceCategory
```

## Below are the steps to run this script

### Install jq in your machine.
For openSUSEleap, run the command below.
```
zypper in jq
```

For Mac, run the command below.
```
/bin/bash -c "$(curl -fsSL raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install jq
```

### Download the script, run.sh
* Downlowd the script, run.sh in your machine. https://github.com/thankthank/searchJob_api_example/blob/main/run.sh
* Add execution permission.
```
chmod 755 ./run.sh
```

### Get Access key
* Use the guide to get an access key. https://help.sumologic.com/docs/manage/security/access-keys/
* And put this in the part of the script below.
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
* Find what API endpoint you need to use in the guide. https://help.sumologic.com/docs/api/getting-started/
* And put this in the part of the script below. You can see the example value.
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
