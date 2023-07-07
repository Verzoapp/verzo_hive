import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BusinessCreationService {
  ValueNotifier<GraphQLClient> client;

  final MutationOptions _createBusinessMutation;
  final QueryOptions _getBusinessCategoriesQuery;

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
        ),
        _getBusinessCategoriesQuery = QueryOptions(
          document: gql('''
        query GetBusinessCategories {
          getBusinessCategories {
            id
            categoryName
            }
            }
            '''),
        );

  Future<BusinessCreationResult> createBusinessProfile(
      {required String businessName,
      required String businessEmail,
      String? businessMobile,
      required String businessCategoryId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return BusinessCreationResult.error(
        error: GraphQLBusinessError(
          message: "Access token not found",
        ),
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

    final MutationOptions options = MutationOptions(
      document: _createBusinessMutation.document,
      variables: {
        'input': {
          'businessName': businessName,
          'businessEmail': businessEmail,
          'businessMobile': businessMobile,
          'businessCategoryId': businessCategoryId,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return BusinessCreationResult.error(
        error: GraphQLBusinessError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    var resultbusiness_id = result.data?['createBusiness']['id'];
    var result_businessName = result.data?['createBusiness']['businessName'];
    var result_businessEmail = result.data?['createBusiness']['businessEmail'];
    var result_businessMobile =
        result.data?['createBusiness']['businessMobile'];

    // prefs.setString('id', resultbusiness_id ?? "");
    // prefs.setString('businessName', result_businessName ?? "");
    // prefs.setString('businessEmail', result_businessEmail ?? "");
    // prefs.setString('businessMobile', result_businessMobile ?? "");

    var business = BusinessCreationSuccessResult(
        resultbusiness_id: resultbusiness_id,
        result_businessName: result_businessName,
        result_businessEmail: result_businessEmail,
        result_businessMobile: result_businessMobile);
    return BusinessCreationResult(business: business);
  }

  Future<List<BusinessCategory>> getBusinessCategories() async {
    final QueryOptions options = QueryOptions(
      document: _getBusinessCategoriesQuery.document,
    );

    final QueryResult businessCategoriesResult =
        await client.value.query(options);

    if (businessCategoriesResult.hasException) {
      GraphQLBusinessError(
        message: businessCategoriesResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List businessCategoriesData =
        businessCategoriesResult.data?['getBusinessCategories'] ?? [];

    final List<BusinessCategory> businessCategories =
        businessCategoriesData.map((data) {
      return BusinessCategory(
        id: data['id'],
        categoryName: data['categoryName'],
      );
    }).toList();

    return businessCategories;
  }
}

class BusinessCategory {
  final String id;
  final String categoryName;

  BusinessCategory({required this.id, required this.categoryName});
}

class BusinessCreationResult {
  late final BusinessCreationSuccessResult? business;
  late final GraphQLBusinessError? error;

  BusinessCreationResult({this.business}) : error = null;
  BusinessCreationResult.error({this.error}) : business = null;

  bool get hasError => error != null;
}

class BusinessCreationSuccessResult {
  BusinessCreationSuccessResult({
    required this.resultbusiness_id,
    required this.result_businessName,
    required this.result_businessEmail,
    this.result_businessMobile,
  });

  late final String resultbusiness_id;
  late final String result_businessName;
  late final String result_businessEmail;
  late final String? result_businessMobile;
}

class GraphQLBusinessError {
  final String? message;

  GraphQLBusinessError({required this.message});
}
