import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MerchantService {
  ValueNotifier<GraphQLClient> client;

  final MutationOptions _createMerchantMutation;

  MerchantService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _createMerchantMutation = MutationOptions(
          document: gql('''
  mutation CreateMerchant(\$input: CreateMerchant!,\$userId: String) {
    createMerchant(input:\$input, userId: \$userId) {
      id
      name
      businessId
      business
      expenses
      createdAt
      updatedAt
    }
  }
'''),
        );

  Future<Merchant?> createMerchant({
    required String name,
    required String businessid,
  }) async {
    final MutationOptions options = MutationOptions(
      document: _createMerchantMutation.document,
      variables: {
        'input': {
          'name': name,
          'businessid': businessid,
        },
      },
    );

    final QueryResult result = await client.value.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    final data = result.data?['createMerchant'];
    if (data == null) {
      return null;
    }

    var success = MerchantResult(businessid: businessid, name: name);

    return Merchant(success: success);
  }
}

class Merchant {
  late final MerchantResult? success;
  late final GraphQLMerchantError? error;

  Merchant({this.success}) : error = null;
  Merchant.error({this.error}) : success = null;

  bool get hasError => error != null;
}

class MerchantResult {
  final String name;
  final String businessid;

  MerchantResult({
    required this.businessid,
    required this.name,
  });
}

class GraphQLMerchantError {
  final String? message;

  GraphQLMerchantError({required this.message});
}
