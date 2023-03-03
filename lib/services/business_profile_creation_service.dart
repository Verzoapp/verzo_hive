import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BusinessCreationService {
  ValueNotifier<GraphQLClient> client;

  final MutationOptions _createBusinessMutation;

  BusinessCreationService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _createBusinessMutation = MutationOptions(
          document: gql('''
        mutation CreateBusiness(\$input: CreateBusiness!) {
          createBusiness(input: \$input) {
            id
            businessName
            businessEmail
            businessMobile
          }
        }
      '''),
        );

  Future<BusinessCreationResult> createBusinessProfile(
      {required String businessName,
      String? businessEmail,
      String? businessMobile,
      required String businessCategoryId}) async {
    final MutationOptions options = MutationOptions(
      document: _createBusinessMutation.document,
      variables: {
        'input': {
          'businessName': businessName,
          'businessEmail': businessEmail,
          'businessMobile': businessMobile,
          'businessCategoryId': businessCategoryId
        },
      },
    );

    final QueryResult result = await client.value.mutate(options);

    var Id = result.data?['createBusiness']['id'];
    var BusinessName = result.data?['createBusiness']['businessName'];
    var BusinessEmail = result.data?['createBusiness']['businessEmail'];
    var BusinessMobile = result.data?['createBusiness']['businessMobile'];

    if (result.hasException) {
      return BusinessCreationResult.error(
        error: GraphQLAuthError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', Id ?? "");
    prefs.setString('businessName', BusinessName ?? "");
    prefs.setString('businessEmail', BusinessEmail ?? "");
    prefs.setString('businessMobile', BusinessMobile ?? "");

    var business = BusinessCreationSuccessResult(
      Id: Id,
      BusinessName: BusinessName,
      BusinessEmail: BusinessEmail,
      BusinessMobile: BusinessMobile,
    );
    return BusinessCreationResult(business: business);
  }
}

class BusinessCreationResult {
  late final BusinessCreationSuccessResult? business;
  late final GraphQLAuthError? error;

  BusinessCreationResult({this.business}) : error = null;
  BusinessCreationResult.error({this.error}) : business = null;

  bool get hasError => error != null;
}

class BusinessCreationSuccessResult {
  BusinessCreationSuccessResult({
    required this.Id,
    required this.BusinessName,
    this.BusinessEmail,
    this.BusinessMobile,
  });

  late final String Id;
  late final String BusinessName;
  late final String? BusinessEmail;
  late final String? BusinessMobile;
}

class GraphQLAuthError {
  final String? message;

  GraphQLAuthError({required this.message});
}
