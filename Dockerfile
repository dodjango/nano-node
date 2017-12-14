# escape=`

FROM microsoft/nanoserver:sac2016

LABEL maintainer="dertorsten@planetdjango.de" `
      version="1.0" `
      description="microsoft windows nanoserver and node.js"

ADD https://nodejs.org/dist/v8.9.3/node-v8.9.3-win-x64.zip /temp/node-v8.9.3-win-x64.zip

SHELL ["powershell", "-command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NODE_PATH c:\node

  # apply new path environment variable including node, nanoserver has no powershell way to set the machine's or user's environment
RUN $newPath = ('{0};{1}' -f $env:NODE_PATH, $env:PATH); `
  	Write-Host ('Updating PATH: {0}' -f $newPath); `
    setx /M PATH $newPath; `
  # extract node.js
    Expand-Archive /temp/node-v8.9.3-win-x64.zip /; `
    mv /node-v8.9.3-win-x64 /node; `
  # clean up
    rmdir /temp -recurse;

WORKDIR ${NODE_PATH}

ENTRYPOINT [ "cmd" ]