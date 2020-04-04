# Apollo Sample IG project used to generate SAML Assertions

Starting point for integrating IG into an environment which has no other SAML IDP.

The assumption is that IG is operating as a reverse proxy in front of some existing
application. This application normally involves user login in some form. Once the
user is logged in, IG will be positioned such that the user's session cookie is
able to be intercepted. This cookie can be used to interact with some API secured
by that same cookie, and which returns user details. Once those user details are
present, they can be included in a SAML Assertion and then posted to some SAML SP.

This project does not attempt to demonstrate the capture of user details. That
is an exercise for the integrator. This project merely shows how those details can
be provided to the SAML Assertion Generator in order to produce a signed assertion.

Review config/routes/saml.json; the example "userInfo" data passed into the "args"
block is intended to be a placeholder. Replace it with the data fetched from the API.

The integrator should also create a new certificate (similar to the one shown in
security/signature_key.cer) and import that into security/keystore.jceks. This same
certificate must be passed into the SAML AG as part of the "args" block, replacing
the current value. Be sure to update the homeUrl and targetUrl values as well.

## Running the Sample

1. Build apollo-saml-assertion-gen.jar (Java 8 required):
```
git clone ssh://git@stash.forgerock.org:7999/~jake.feasel/openidm.git

git checkout apolloFork

cd openidm/identity-connect/identity-connect-saml-assertion-gen

mvn clean install
```

2. Copy jar into the lib dir for this project:
```
cp target/identity-connect-saml-assertion-gen* lib/apollo-saml-assertion-gen.jar
```

3. Build and run the docker container for this project:
```
docker build -t apollo:latest .

docker run -p 8080:8080 -d apollo:latest
```

4. Use a browser to open http://localhost:8080/saml

You will see a simple webpage with a "Login" button. Included in the page is a hidden
input with a SAML assertion value.
