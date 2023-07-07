import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthenticationService {
  ValueNotifier<GraphQLClient> client;

  final MutationOptions _signInMutation;
  final MutationOptions _logOutMutation;
  final MutationOptions _signUpMutation;

  AuthenticationService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _signInMutation = MutationOptions(
          document: gql('''
        mutation SignIn(\$input: SignInDetails!) {
          signIn(input: \$input) {
            access_token
            refresh_token
          }
        }
      '''),
        ),
        _logOutMutation = MutationOptions(
          document: gql('''
        mutation LogOut {
          logOut 
        }
      '''),
        ),
        _signUpMutation = MutationOptions(
          document: gql('''
        mutation SignUp(\$input: SignUpDetails!) {
          signUp(input: \$input) {
            access_token
            refresh_token
          }
        }
      '''),
        );

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<AuthenticationResult> loginWithEmail(
      {required String email, required String password}) async {
    final MutationOptions options = MutationOptions(
      document: _signInMutation.document,
      variables: {
        'input': {
          'email': email,
          'password': password,
        },
      },
    );

    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      return AuthenticationResult.error(
        error: GraphQLAuthError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    var accessToken = result.data?['signIn']['access_token'];
    var refreshToken = result.data?['signIn']['refresh_token'];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken ?? "");
    prefs.setString('refresh_token', refreshToken ?? "");
    prefs.setBool('isLoggedIn', true);

    var tokens = AuthenticationSuccessResult(
        accessToken: accessToken, refreshToken: refreshToken);

    return AuthenticationResult(tokens: tokens);
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLAuthError(
        message: "Access token not found",
      );
    }
// Use the token to create an authlink
    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    // Create a new GraphQLClient with the authlink
    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    // Make a GraphQL mutation to the authentication endpoint to log out the current user
    final MutationOptions options = MutationOptions(
      document: _logOutMutation.document,
    );

    final QueryResult result = await newClient.mutate(options);

    prefs.setString('access_token', '');
    prefs.setString('refresh_token', '');
    prefs.setBool('isLoggedIn', false);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }
    bool logOut = result.data?['logOut'];

    return logOut;
  }

  Future<CreateAccountWithEmailResult> createAccountWithEmail(
      {required String email,
      required String password,
      required String fullName}) async {
    // Make a GraphQL mutation to the authentication endpoint to register a new user with the given email, password, and full name
    final MutationOptions options = MutationOptions(
      document: _signUpMutation.document,
      variables: {
        'input': {
          'email': email,
          'password': password,
          'fullname': fullName,
        },
      },
    );

    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      return CreateAccountWithEmailResult.error(
        error: GraphQLAuthError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    var accessToken = result.data?['signUp']['access_token'];
    var refreshToken = result.data?['signUp']['refresh_token'];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken ?? "");
    prefs.setString('refresh_token', refreshToken ?? "");
    prefs.setBool('isLoggedIn', false);

    var tokens = CreateAccountWithEmailSuccessResult(
        accessToken: accessToken, refreshToken: refreshToken);

    return CreateAccountWithEmailResult(tokens: tokens);
  }
}

class CreateAccountWithEmailResult {
  late final CreateAccountWithEmailSuccessResult? tokens;
  late final GraphQLAuthError? error;

  CreateAccountWithEmailResult({this.tokens}) : error = null;

  CreateAccountWithEmailResult.error({this.error}) : tokens = null;

  bool get hasError => error != null && error!.message!.isNotEmpty;
}

class CreateAccountWithEmailSuccessResult {
  CreateAccountWithEmailSuccessResult({
    required this.accessToken,
    required this.refreshToken,
  });

  late final String accessToken;
  late final String refreshToken;
}

class AuthenticationResult {
  late final AuthenticationSuccessResult? tokens;
  late final GraphQLAuthError? error;

  AuthenticationResult({this.tokens}) : error = null;
  AuthenticationResult.error({this.error}) : tokens = null;

  bool get hasError => error != null;
}

class AuthenticationSuccessResult {
  AuthenticationSuccessResult({
    required this.accessToken,
    required this.refreshToken,
  });

  late final String accessToken;
  late final String refreshToken;
}

class GraphQLAuthError {
  final String? message;

  GraphQLAuthError({required this.message});
}
