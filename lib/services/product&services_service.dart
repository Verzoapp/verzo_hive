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
  final QueryOptions _getProductUnits;

//Services
  final MutationOptions _createServiceMutation;
  final QueryOptions _getServiceUnits;

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
        _getProductUnits = QueryOptions(
          document: gql('''
        query GetProductUnits{
          getProductUnits{
            id
            unitName
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
        _getServiceUnits = QueryOptions(
          document: gql('''
        query GetServiceUnits{
          getServiceUnits{
            id
            unitName
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
            productUnitId
            serviceUnitId
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
      required String businessId,
      String? productUnitId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

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
          'businessId': businessId,
          'productUnitId': productUnitId
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

  Future<List<ProductUnit>> getProductUnits() async {
    final QueryOptions options = QueryOptions(
      document: _getProductUnits.document,
    );

    final QueryResult productUnitsResult = await client.value.query(options);

    if (productUnitsResult.hasException) {
      throw GraphQLProductError(
        message: productUnitsResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List productUnitsData =
        productUnitsResult.data?['getProductUnits'] ?? [];

    final List<ProductUnit> productUnits = productUnitsData.map((data) {
      return ProductUnit(id: data['id'], unitName: data['unitName']);
    }).toList();

    return productUnits;
  }

//Service
  Future<ServiceCreationResult> createServices(
      {required String name,
      required double price,
      required String businessId,
      String? serviceUnitId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final businessId = prefs.getString('businessId');

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
        'input': {
          'name': name,
          'price': price,
          'businessId': businessId,
          'serviceUnitId': serviceUnitId
        },
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

  Future<List<ServiceUnit>> getServiceUnits() async {
    final QueryOptions options = QueryOptions(
      document: _getServiceUnits.document,
    );

    final QueryResult serviceUnitsResult = await client.value.query(options);

    if (serviceUnitsResult.hasException) {
      throw GraphQLProductError(
        message: serviceUnitsResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List serviceUnitsData =
        serviceUnitsResult.data?['getServiceUnits'] ?? [];

    final List<ServiceUnit> serviceUnits = serviceUnitsData.map((data) {
      return ServiceUnit(id: data['id'], unitName: data['unitName']);
    }).toList();

    return serviceUnits;
  }

  Future<List<Items>> getProductOrServiceByBusiness(
      {required String businessId}) async {
    final QueryOptions options = QueryOptions(
      document: _getProductOrServiceByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult productorserviceByBusinessResult =
        await client.value.query(options);

    if (productorserviceByBusinessResult.hasException) {
      throw GraphQLProductError(
        message: productorserviceByBusinessResult
            .exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List productsorservicesData = productorserviceByBusinessResult
            .data?['getProductOrServiceByBusiness'] ??
        [];

    final List<Items> items = productsorservicesData.map((data) {
      return Items(
          id: data['id'],
          title: data['title'],
          type: data['type'],
          price: data['price'],
          productUnitId: data['productUnitId'],
          serviceUnitId: data['serviceUnitId'],
          quantity: 1);
    }).toList();

    return items;
  }
}

class ProductUnit {
  final String id;
  final String unitName;

  ProductUnit({required this.id, required this.unitName});
}

class ServiceUnit {
  final String id;
  final String unitName;

  ServiceUnit({required this.id, required this.unitName});
}

class Items {
  final String id;
  final String title;
  late final String type;
  final String? productUnitId;
  final String? serviceUnitId;
  num price;
  num quantity = 1;

  Items(
      {required this.id,
      required this.title,
      required this.type,
      this.productUnitId,
      this.serviceUnitId,
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
