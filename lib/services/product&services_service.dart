import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductsxServicesService {
  ValueNotifier<GraphQLClient> client;

//Products
  final MutationOptions _createProductMutation;

//Services
  final MutationOptions _createServiceMutation;

//product/services
  final QueryOptions _getProductOrServiceByBusinessQuery;

  ProductsxServicesService()
      : client = ValueNotifier(GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink('https://api.verzo.app/graphql'),
        )),
        _createProductMutation = MutationOptions(
          document: gql('''
        mutation CreateProduct(\$input: CreateProduct!) {
          createProduct(input: \$input) {
            id
            productName
            price
          }
        }
      '''),
        ),
        _createServiceMutation = MutationOptions(
          document: gql('''
        mutation CreateService(\$input: CreateService!) {
          createService(input:\$input) {
            id
            name
            price
          }
         }
        '''),
        ),
        _getProductOrServiceByBusinessQuery = QueryOptions(
          document: gql('''
        query GetProductOrServiceByBusiness(\$input: String!) {
          getProductOrServiceByBusiness(businessId: \$input) {
            id
            title
            type
            price
            businessId
            }
          }
        '''),
        );

//Product
  Future<ProductCreationResult> createProducts(
      {required String productName,
      required double price,
      required double basicUnit,
      required double quantityInStock,
      required String businessId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('id');

    if (token == null) {
      return ProductCreationResult.error(
        error: GraphQLProductError(
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
      document: _createProductMutation.document,
      variables: {
        'input': {
          'productName': productName,
          'price': price,
          'basicUnit': basicUnit,
          'quantityInStock': quantityInStock,
          'businessId': businessId
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return ProductCreationResult.error(
        error: GraphQLProductError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createProduct'] == null) {
      return ProductCreationResult.error(
        error: GraphQLProductError(
          message: "Error parsing response data",
        ),
      );
    }

    var result_id = result.data?['createProduct']['id'];
    var result_productName = result.data?['createProduct']['productName'];
    var result_price = result.data?['createProduct']['price'];

    var product = ProductCreationSuccessResult(
        result_id: result_id,
        result_productName: result_productName,
        result_price: result_price);

    return ProductCreationResult(product: product);
  }

//Service
  Future<ServiceCreationResult> createServices(
      {required String name,
      required double price,
      required String businessId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('id');

    if (token == null) {
      return ServiceCreationResult.error(
        error: GraphQLServiceError(
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
      document: _createServiceMutation.document,
      variables: {
        'input': {'name': name, 'price': price, 'businessId': businessId},
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return ServiceCreationResult.error(
        error: GraphQLServiceError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['createService'] == null) {
      return ServiceCreationResult.error(
        error: GraphQLServiceError(
          message: "Error parsing response data",
        ),
      );
    }

    var result_id = result.data?['createService']['id'];
    var result_name = result.data?['createService']['name'];
    var result_price = result.data?['createService']['price'];

    var service = ServiceCreationSuccessResult(
        result_id: result_id,
        result_name: result_name,
        result_price: result_price);

    return ServiceCreationResult(service: service);
  }

  Future<List<Items>> getProductOrServiceByBusiness(
      {required String businessId}) async {
    final QueryOptions options = QueryOptions(
      document: _getProductOrServiceByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult productorserviceByBusinessResult =
        await client.value.query(options);

    // if (productorserviceByBusinessResult.hasException) {
    //   throw GraphQLInvoiceError(
    //     message: productorserviceByBusinessResult
    //         .exception?.graphqlErrors.first.message
    //         .toString(),
    //   );
    // }

    final List productsorservicesData = productorserviceByBusinessResult
            .data?['getProductOrServiceByBusiness'] ??
        [];

    final List<Items> items = productsorservicesData.map((data) {
      return Items(
          id: data['id'],
          title: data['title'],
          type: data['type'],
          price: data['price'],
          quantity: 1);
    }).toList();

    return items;
  }
}

class Items {
  final String id;
  final String title;
  final String type;
  num price;
  num? quantity = 1;

  Items(
      {required this.id,
      required this.title,
      required this.type,
      required this.price,
      required this.quantity});
}

class ProductCreationResult {
  late final ProductCreationSuccessResult? product;
  late final GraphQLProductError? error;

  ProductCreationResult({this.product}) : error = null;
  ProductCreationResult.error({this.error}) : product = null;

  bool get hasError => error != null;
}

class ProductCreationSuccessResult {
  ProductCreationSuccessResult(
      {required this.result_id,
      required this.result_productName,
      required this.result_price});

  late final String result_id;
  late final String result_productName;
  late final num result_price;
}

class GraphQLProductError {
  final String? message;

  GraphQLProductError({required this.message});
}

class ServiceCreationResult {
  late final ServiceCreationSuccessResult? service;
  late final GraphQLServiceError? error;

  ServiceCreationResult({this.service}) : error = null;
  ServiceCreationResult.error({this.error}) : service = null;

  bool get hasError => error != null;
}

class ServiceCreationSuccessResult {
  ServiceCreationSuccessResult(
      {required this.result_id,
      required this.result_name,
      required this.result_price});

  late final String result_id;
  late final String result_name;
  late final num result_price;
}

class GraphQLServiceError {
  final String? message;

  GraphQLServiceError({required this.message});
}
