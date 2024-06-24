#!/bin/bash

# run dotnet add package Microsoft.CodeAnalysis.LanguageServer.Linux-x64 --prerelease
# it will error but the package will be downloaded to ~/.nuget/packages/microsoft.codeanalysis.languageserver.linux-x64
# do the same thing but with the windows architecture to get the dlls

# Define the base paths
NUGET_PATH="$HOME/.nuget/packages/microsoft.codeanalysis.languageserver.linux-x64"
NVIM_ROSLYN_PATH="$HOME/.local/share/nvim/roslyn"

# Delete the contents of the NVIM_ROSLYN_PATH directory
rm -rf "$NVIM_ROSLYN_PATH"/*

# Find the latest version by sorting and picking the last one
LATEST_VERSION=$(ls -v $NUGET_PATH | tail -n 1)

# Check if the latest version directory exists
if [ -d "$NUGET_PATH/$LATEST_VERSION" ]; then
        # Copy the contents of the latest version to the NVIM_ROSLYN_PATH directory
        cp -r "$NUGET_PATH/$LATEST_VERSION/content/LanguageServer/linux-x64/"* "$NVIM_ROSLYN_PATH/"
        echo "Copied contents of version $LATEST_VERSION to $NVIM_ROSLYN_PATH"
else
        echo "Latest version directory not found!"
fi
