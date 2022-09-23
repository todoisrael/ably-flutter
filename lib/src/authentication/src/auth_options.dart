import 'package:ably_flutter/ably_flutter.dart';

/// BEGIN LEGACY DOCSTRING
/// A class providing configurable authentication options used when
/// authenticating or issuing tokens explicitly.
///
/// These options are used when invoking Auth#authorize, Auth#requestToken,
/// Auth#createTokenRequest and Auth#authorize.
///
/// https://docs.ably.com/client-lib-development-guide/features/#AO1
/// END LEGACY DOCSTRING

/// BEGIN LEGACY DOCSTRING
/// Passes authentication-specific properties in authentication requests to
/// Ably. Properties set using AuthOptions are used instead of the default
/// values set when the client library is instantiated, as opposed to being
/// merged with them.
/// END LEGACY DOCSTRING
abstract class AuthOptions {
  /// BEGIN LEGACY DOCSTRING
  /// A function which is called when a new token is required.
  ///
  /// The role of the callback is to either generate a signed [TokenRequest]
  /// which may then be submitted automatically by the library to
  /// the Ably REST API requestToken; or to provide a valid token
  /// as a [TokenDetails] object.
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2b
  /// END LEGACY DOCSTRING

  /// BEGIN LEGACY DOCSTRING
  /// Called when a new token is required. The role of the callback is to obtain
  /// a fresh token, one of: an Ably Token string (in plain text format);
  /// a signed [TokenRequest]{@link TokenRequest}; a
  /// TokenDetails]{@link TokenDetails} (in JSON format); an [Ably JWT](https://ably.com/docs/core-features/authentication#ably-jwt).
  /// See the [authentication documentation](https://ably.com/docs/realtime/authentication)
  /// for details of the Ably [TokenRequest]{@link TokenRequest} format and
  /// associated API calls.
  /// END LEGACY DOCSTRING
  AuthCallback? authCallback;

  /// BEGIN LEGACY DOCSTRING
  /// A URL that the library may use to obtain
  /// a token String (in plain text format),
  /// or a signed [TokenRequest] or [TokenDetails] (in JSON format).
  ///
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2c
  /// END LEGACY DOCSTRING
  String? authUrl;

  /// BEGIN LEGACY DOCSTRING
  /// HTTP Method used when a request is made using authURL
  ///
  /// defaults to 'GET', supports 'GET' and 'POST'
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2d
  /// END LEGACY DOCSTRING

  /// BEGIN LEGACY DOCSTRING
  /// The HTTP verb to use for any request made to the authUrl, either GET or
  /// POST. The default value is GET.
  /// END LEGACY DOCSTRING
  String? authMethod;

  /// BEGIN LEGACY DOCSTRING
  /// Full Ably key string, as obtained from dashboard,
  /// used when signing token requests locally
  ///
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2a
  /// END LEGACY DOCSTRING
  String? key;

  /// BEGIN LEGACY DOCSTRING
  /// An authentication token issued for this application
  ///
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2i
  /// END LEGACY DOCSTRING
  TokenDetails? tokenDetails;

  /// BEGIN LEGACY DOCSTRING
  /// Headers to be included in any request made to the [authUrl]
  ///
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2e
  /// END LEGACY DOCSTRING

  /// BEGIN LEGACY DOCSTRING
  /// A set of key-value pair headers to be added to any request made to the
  /// authUrl. Useful when an application requires these to be added to validate
  /// the request or implement the response. If the authHeaders object contains
  /// an authorization key, then withCredentials is set on the XHR request.
  /// END LEGACY DOCSTRING
  Map<String, String>? authHeaders;

  /// BEGIN LEGACY DOCSTRING
  /// Additional params to be included in any request made to the [authUrl]
  ///
  /// As query params in the case of GET
  /// and as form-encoded in the body in the case of POST
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2f
  /// END LEGACY DOCSTRING

  /// BEGIN LEGACY DOCSTRING
  /// A set of key-value pair params to be added to any request made to the
  ///  authUrl. When the authMethod is GET, query params are added to the URL,
  /// whereas when authMethod is POST, the params are sent as URL encoded form
  /// data. Useful when an application requires these to be added to validate
  /// the request or implement the response.
  /// END LEGACY DOCSTRING
  Map<String, String>? authParams;

  /// BEGIN LEGACY DOCSTRING
  /// If true, the library will when issuing a token request query
  /// the Ably system for the current time instead of relying on a
  /// locally-available time of day.
  ///
  /// https://docs.ably.com/client-lib-development-guide/features/#AO2g
  /// END LEGACY DOCSTRING
  bool? queryTime;

  /// BEGIN LEGACY DOCSTRING
  /// Token Auth is used if useTokenAuth is set to true
  ///
  /// or if useTokenAuth is unspecified and any one of
  /// [authUrl], [authCallback], token, or [TokenDetails] is provided
  /// https://docs.ably.com/client-lib-development-guide/features/#RSA4
  /// END LEGACY DOCSTRING
  bool? useTokenAuth;

// TODO(tiholic) missing token attribute here
//  see: https://docs.ably.com/client-lib-development-guide/features/#AO2h

  /// BEGIN LEGACY DOCSTRING
  /// Initializes an instance without any defaults
  /// END LEGACY DOCSTRING
  AuthOptions({
    this.authCallback,
    this.authHeaders,
    this.authMethod,
    this.authParams,
    this.authUrl,
    this.key,
    this.queryTime,
    this.tokenDetails,
    this.useTokenAuth,
  }) {
    if (key != null && !key!.contains(':')) {
      tokenDetails = TokenDetails(key);
      key = null;
    }
  }

  /// BEGIN LEGACY DOCSTRING
  /// Convenience constructor, to create an AuthOptions based
  /// on the key string obtained from the application dashboard.
  /// param [key]: the full key string as obtained from the dashboard
  /// END LEGACY DOCSTRING
  @Deprecated("Use AuthOptions constructor with named 'key' parameter instead")
  AuthOptions.fromKey(String key) {
    if (key.contains(':')) {
      this.key = key;
    } else {
      tokenDetails = TokenDetails(key);
    }
  }
}

/// BEGIN LEGACY DOCSTRING
/// Function-type alias implemented by a function that provides either tokens,
/// or signed token requests, in response to a request with given token params.
///
/// Java: io.ably.lib.rest.Auth.TokenCallback.getTokenRequest(TokenParams)
/// returns either a [String] token or [TokenDetails] or [TokenRequest]
/// END LEGACY DOCSTRING
typedef AuthCallback = Future<Object> Function(TokenParams params);
