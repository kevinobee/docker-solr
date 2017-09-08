# Builds the base ASP.NET image for an environment
# escape=\
FROM microsoft/windowsservercore

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

# Download and install Java - Solr dependency
RUN Invoke-WebRequest -Method Get -Uri http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185 -OutFile /jreinstaller.exe ; \
    Start-Process -filepath C:\jreinstaller.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\Java\jre" ; \
    del C:\jreinstaller.exe

ENV JAVA_HOME c:\\Java\\jre

# Write variables to the master environment in the registry
RUN setx PATH '%PATH%;c:\\Java\\jre'

# Download and extract Solr project files
RUN Invoke-WebRequest -Method Get -Uri http://apache.mirror.anlx.net/lucene/solr/6.6.0/solr-6.6.0.zip -OutFile /solr.zip ; \
	Expand-Archive -Path /solr.zip -DestinationPath /solr ; \
	Remove-Item /solr.zip -Force

WORKDIR /solr/solr-6.6.0

EXPOSE 8983

ENTRYPOINT bin/solr start -port 8983 -f -noprompt -V