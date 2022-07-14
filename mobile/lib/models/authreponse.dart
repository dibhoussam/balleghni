// To parse this JSON data, do
//
//     final authReponse = authReponseFromJson(jsonString);

import 'dart:convert';

AuthReponse authReponseFromJson(String str) => AuthReponse.fromJson(json.decode(str));

String authReponseToJson(AuthReponse data) => json.encode(data.toJson());

class AuthReponse {
  AuthReponse({
    required this.accessToken,
    this.expiresIn,
    this.notBeforePolicy,
    this.refreshExpiresIn,
    required this.refreshToken,
    this.scope,
    this.sessionState,
    this.tokenType,
  });

   String accessToken;
   int? expiresIn;
   int? notBeforePolicy;
   int? refreshExpiresIn;
   String refreshToken;
   String? scope;
   String? sessionState;
   String? tokenType;

  factory AuthReponse.fromJson(Map<String, dynamic> json) => AuthReponse(
    accessToken: json["access_token"],
    expiresIn: json["expires_in"],
    notBeforePolicy: json["not-before-policy"],
    refreshExpiresIn: json["refresh_expires_in"],
    refreshToken: json["refresh_token"],
    scope: json["scope"],
    sessionState: json["session_state"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_in": expiresIn,
    "not-before-policy": notBeforePolicy,
    "refresh_expires_in": refreshExpiresIn,
    "refresh_token": refreshToken,
    "scope": scope,
    "session_state": sessionState,
    "token_type": tokenType,
  };
}
