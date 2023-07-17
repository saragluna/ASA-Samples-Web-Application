#!/bin/bash

#      Copyright (c) Microsoft Corporation.
#      Copyright (c) IBM Corporation. 
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#           http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

set -Eeuo pipefail

# Fail fast the deployment if envs are empty
if [[ -z "$SUBSCRIPTION_ID" ]]; then
  echo "The subscription Id is not successfully retrieved, please retry another deployment." >&2
  exit 1
fi

if [[ -z "$RESOURCE_GROUP" ]]; then
  echo "The resource group is not successfully retrieved, please retry another deployment." >&2
  exit 1
fi

if [[ -z "$ASA_SERVICE_NAME" ]]; then
  echo "The Azure Spring Apps service name is not successfully retrieved, please retry another deployment." >&2
  exit 1
fi

upload_url=$(az rest -m post -u "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.AppPlatform/Spring/$ASA_SERVICE_NAME/apps/simple-todo-web/getResourceUploadUrl?api-version=2023-05-01-preview" | jq -r '.uploadUrl')
source_url="https://github-registry-files.githubusercontent.com/659212286/dbf9ab80-221e-11ee-80bc-d0871ee1e962?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230714%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230714T081855Z&X-Amz-Expires=300&X-Amz-Signature=78af7659c5039f9fdf37157ca612f885e015378ad7f0cced161f7c452a7e3656&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=659212286&response-content-disposition=filename%3Dsimple-todo-web-0.0.1-20230714.081623-1.jar&response-content-type=application%2Foctet-stream"
auth_header="no-auth"

storage_account_name=$(echo $upload_url | awk -F'[/.]' '{print $3}')
storage_endpoint=$(echo $upload_url | awk -F'/' '{print "https://" $3}')
share_name=$(echo $upload_url | awk -F'/' '{print $4}')
folder=$(echo $upload_url | awk -F'?' '{print $1}' | awk -F'/' '{for(i=5;i<NF-1;i++) printf "%s/",$i; print $(NF-1)}')
path=$(echo $upload_url | awk -F'[/?]' '{print $(NF-1)}')
sas_token=$(echo $upload_url | awk -F'?' '{print $2}')

# Download binary
mkdir resources
echo "Downloading binary from $source_url"
if [ "$auth_header" == "no-auth" ]; then
    curl "$source_url" -o $path
else
    curl -H "Authorization: $auth_header" "$source_url" -o $path
fi

# Upload to remote
echo "Upload $source_url to $storage_account_name at $storage_endpoint/$share_name/$folder/$path"

echo "az storage file upload -s $share_name --source $path --account-name  $storage_account_name --file-endpoint $storage_endpoint --sas-token $sas_token -p $folder"

az storage file upload -s $share_name --source $path --account-name  $storage_account_name --file-endpoint "$storage_endpoint" --sas-token "$sas_token"  -p "$folder"

relative_path=$(az rest -m post -u "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.AppPlatform/Spring/$ASA_SERVICE_NAME/apps/simple-todo-web/getResourceUploadUrl?api-version=2023-05-01-preview" | jq -r '.relativePath')
echo "{\"relativePath\": $relative_path}" > $AZ_SCRIPTS_OUTPUT_PATH"
