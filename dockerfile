# Builds Solr image for a Windows container environment
# escape=\
FROM microsoft/windowsservercore

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

# Download and install Java - Solr dependency
RUN Invoke-WebRequest -Method Get -Uri http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185 -OutFile /jreinstaller.exe ; \
    Start-Process -FilePath C:\jreinstaller.exe -PassThru -wait -ArgumentList "/s,INSTALLDIR=c:\Java\jre" ; \
    del C:\jreinstaller.exe

ENV JAVA_HOME c:\\Java\\jre

# Write variables to the master environment in the registry
RUN setx PATH '%PATH%;c:\\Java\\jre'

# Download and extract Solr project files
RUN Invoke-WebRequest -Method Get -Uri "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/lucene/solr/6.6.1/solr-6.6.1.zip" -OutFile /solr.zip ; \
    Expand-Archive -Path /solr.zip -DestinationPath /solr ; \
    Remove-Item /solr.zip -Force

WORKDIR "/solr/solr-6.6.1"

EXPOSE 8983

HEALTHCHECK CMD powershell -command \
    try { \
        $response = iwr "http://localhost:8983" -UseBasicParsing; \
        if ($response.StatusCode -eq 200) { return 0} else {return 1}; \
    } catch { return 1 }

ENTRYPOINT bin/solr start -port 8983 -f -noprompt