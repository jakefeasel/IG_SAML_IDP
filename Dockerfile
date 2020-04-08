FROM forgerock-docker-public.bintray.io/forgerock/openig:6.5.0

COPY --chown=forgerock lib /var/openig/lib

RUN mkdir /usr/local/tomcat/webapps/ROOT && \
    cp /usr/local/tomcat/webapps/ROOT.war /usr/local/tomcat/webapps/ROOT && \
    cd /usr/local/tomcat/webapps/ROOT && \
    unzip ROOT.war && rm ROOT.war

RUN cp /var/openig/lib/* /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

COPY --chown=forgerock security /usr/local/tomcat/security
COPY --chown=forgerock config /var/openig/config
COPY --chown=forgerock scripts /var/openig/scripts
