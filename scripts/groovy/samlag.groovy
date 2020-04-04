
import org.forgerock.identityconnect.saml.AssertionGenerator;

if (!globals.ag) {
    AssertionGenerator ag = new AssertionGenerator(homeUrl, cert, targetUrl, certAlias);
    // cache a copy of the AssertionGenerator in the global context, because we can assume that all
    // invocations of it will have the same base arguments provided.
    globals.ag = ag;
}

// getResponse arguments:
// userDetails: Map<String, String> of values to include in the assertion
// authnRequestString: When SP-Initiated, the value given to return back. null for IDP-initiated
attributes.assertion = globals.ag.getResponse(userInfo, null);

return next.handle(context, request);
