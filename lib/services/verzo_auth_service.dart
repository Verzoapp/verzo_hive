import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class VerzoAuthService {
  ValueNotifier<GraphQLClient> client;

  final MutationOptions _signInMutation;
  final MutationOptions _logOutMutation;
  final MutationOptions _signUpMutation;

  VerzoAuthService()
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
        mutation LogOut(\$userId: String!) {
          logOut(userId: \$userId) {
            message
          }
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

  Future<Map<String, String>> login(String email, String password) async {
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
      // Handle any errors that may have occurred during the sign-in process
      throw Exception(result.exception);
    }

    // Return the `access_token` and `refresh_token` from the query results
    return {
      'access_token': result.data?['signIn']['access_token'],
      'refresh_token': result.data?['signIn']['refresh_token'],
    };
  }

  Future<void> logout(String userId) async {
    // Make a GraphQL mutation to the authentication endpoint to log out the current user
    final MutationOptions options = MutationOptions(
      document: _logOutMutation.document,
      variables: {
        'input': {
          'userId': userId,
        },
      },
    );

    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }
  }

  Future<void> register(String email, String password, String fullname) async {
    // Make a GraphQL mutation to the authentication endpoint to register a new user with the given email, password, and full name
    final MutationOptions options = MutationOptions(
      document: _signUpMutation.document,
      variables: {
        'input': {
          'email': email,
          'password': password,
          'fullname': fullname,
        },
      },
    );

    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }
  }
}
