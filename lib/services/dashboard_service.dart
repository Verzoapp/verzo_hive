import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DashboardService {
  ValueNotifier<GraphQLClient> client;

  final QueryOptions _getBusinessesByUserQuery;

  DashboardService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _getBusinessesByUserQuery = QueryOptions(
          document: gql('''
        query GetBusinessesByUser {
          getBusinessesByUser {
            id
            businessName
            businessEmail
            businessMobile
            }
            }
            '''),
        );

  Future<BusinessIdResult> businessIdLoginOrSignUp() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return BusinessIdResult.error(
        error: GraphQLAuthError(
          message: "Access token not found",
        ),
      );
    }
    final authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );

    // Create a new GraphQLClient with the authlink
    final newClient = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(HttpLink('https://api.verzo.app/graphql')),
    );

    final QueryResult businessIdResult =
        await newClient.query(_getBusinessesByUserQuery);

    var result_businessid = businessIdResult.data?['getBusinessesByUser']['id'];
    var result_businessName =
        businessIdResult.data?['getBusinessesByUser']['businessName'];
    var result_businessEmail =
        businessIdResult.data?['getBusinessesByUser']['businessEmail'];
    var result_businessMobile =
        businessIdResult.data?['getBusinessesByUser']['businessMobile'];

    if (businessIdResult.hasException) {
      return BusinessIdResult.error(
        error: GraphQLAuthError(
          message: businessIdResult.exception?.graphqlErrors.first.message
              .toString(),
        ),
      );
    }

    prefs.setString('id', result_businessid ?? '');

    var businessId = BusinessIdSuccessResult(
        result_businessId: result_businessid,
        result_businessName: result_businessName,
        result_businessEmail: result_businessName,
        result_businessMobile: result_businessMobile);
    return BusinessIdResult(businessId: businessId);
  }
}

class BusinessIdResult {
  late final BusinessIdSuccessResult? businessId;
  late final GraphQLAuthError? error;

  BusinessIdResult({this.businessId}) : error = null;
  BusinessIdResult.error({this.error}) : businessId = null;

  bool get hasError => error != null;
}

class BusinessIdSuccessResult {
  BusinessIdSuccessResult({
    this.result_businessId,
    this.result_businessName,
    this.result_businessEmail,
    this.result_businessMobile,
  });

  late final String? result_businessId;
  late final String? result_businessName;
  late final String? result_businessEmail;
  late final String? result_businessMobile;
}

class GraphQLAuthError {
  final String? message;

  GraphQLAuthError({required this.message});
}
