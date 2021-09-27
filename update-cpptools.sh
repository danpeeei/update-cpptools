#!/usr/bin/env bash

endpoint="https://api.github.com/repos/microsoft/vscode-cpptools/releases"
artifact="cpptools-linux.vsix"

if !(type jq >/dev/null 2>&1); then
    echo -e "\nCommand 'jq' is not found. Please install following command:"
    echo -e "\nsudo apt install jq\n"
    exit 1
fi
download_url=$(curl -sSL $endpoint | jq -r '[.[] | select(.prerelease == false)][0].assets[] | select(.name == "cpptools-linux.vsix").browser_download_url')
if [ -z "${download_url}" ]; then
    echo "Failed to extract download URL"
    exit 1
fi
wget ${download_url}
echo "Start the installation..."
code --install-extension ${artifact}
rm -i ${artifact}
