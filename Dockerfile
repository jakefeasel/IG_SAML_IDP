FROM gcr.io/engineering-devops/ig-base:6.5

COPY --chown=forgerock lib /var/openig/lib

RUN mkdir /usr/local/tomcat/webapps/ROOT && \
    cp /usr/local/tomcat/webapps/ROOT.war /usr/local/tomcat/webapps/ROOT && \
    cd /usr/local/tomcat/webapps/ROOT && \
    unzip ROOT.war && rm ROOT.war && \
    rm /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/openam-federation-library* && \
    cp /var/openig/lib/* /usr/local/tomcat/webapps/ROOT/WEB-INF/lib && \
    mkdir /tmp/jar && cp /var/openig/lib/apollo-saml* /tmp/jar && \
    cd /tmp/jar && unzip apollo-saml* && \
    cp /tmp/jar/openam-federation-library* /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/ && \
    rm -rf /tmp/jar

COPY --chown=forgerock security /usr/local/tomcat/security
COPY --chown=forgerock config /var/openig/config
COPY --chown=forgerock scripts /var/openig/scripts
