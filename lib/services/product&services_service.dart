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
  final MutationOptions _updateProductMutation;
  final MutationOptions _archiveProductMutation;
  final QueryOptions _getProductUnits;

//Services
  final MutationOptions _createServiceMutation;
  final MutationOptions _updateServiceMutation;
  final MutationOptions _archiveServiceMutation;
  final QueryOptions _getServiceUnits;

//product/services
  final QueryOptions _getProductOrServiceByBusinessQuery;
  final QueryOptions _getProductsByBusinessQuery;

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
        _updateProductMutation = MutationOptions(
          document: gql('''
            mutation UpdateProduct(\$productId: String!, \$input: UpdateProduct) {
              updateProduct(productId: \$productId, input: \$input) {
                id
                
              }
            }
          '''),
        ),
        _archiveProductMutation = MutationOptions(
          document: gql('''
        mutation ArchiveProductByBusiness(\$productId: String!) {
          archiveProductByBusiness(productId: \$productId)
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
        _updateServiceMutation = MutationOptions(
          document: gql('''
            mutation UpdateService(\$serviceId: String!, \$input: UpdateService) {
              updateService(serviceId: \$serviceId, input: \$input) {
                id
              }
            }
          '''),
        ),
        _archiveServiceMutation = MutationOptions(
          document: gql('''
        mutation ArchiveServiceByBusiness(\$serviceId: String!) {
          archiveServiceByBusiness(serviceId: \$serviceId)
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
            productOrServiceByBusiness{
              id
              title
              type
              price
              businessId
              product{
              productName
              basicUnit
              productUnitId
              productUnit{
                id
                unitName
              }
                }
              service{
              name
              serviceUnitId
              serviceUnit{
                id
                unitName
              }
              }
            }
            cursorId
            }
          }
        '''),
        ),
        _getProductsByBusinessQuery = QueryOptions(
          document: gql('''
        query GetProductsByBusiness(\$input: String!) {
          getProductsByBusiness(businessId: \$input) {
            productByBusiness{
              id
              productName
              price
            }
            }
          }
        '''),
        );

//Product
  Future<ProductCreationResult> createProducts(
      {required String productName,
      required double price,
      required double basicUnit,
      // double? quantityInStock,
      required String businessId,
      required String productUnitId}) async {
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
          // 'quantityInStock': quantityInStock,
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

  Future<ProductUpdateResult> updateProducts(
      {required String productId,
      String? productName,
      double? price,
      double? basicUnit,
      // double? quantityInStock,
      String? productUnitId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return ProductUpdateResult.error(
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
      document: _updateProductMutation.document,
      variables: {
        'productId': productId,
        'input': {
          'productName': productName,
          'price': price,
          'productUnitId': productUnitId,
          // 'quantityInStock': quantityInStock,
          'basicUnit': basicUnit,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return ProductUpdateResult.error(
        error: GraphQLProductError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['updateProduct'] == null) {
      return ProductUpdateResult.error(
        error: GraphQLProductError(
          message: "Error parsing response data",
        ),
      );
    }

    var resultexpense_id = result.data?['updateProduct']['id'];

    var product = ProductUpdateSuccessResult(
      result_id: resultexpense_id,
    );

    return ProductUpdateResult(product: product);
  }

  Future<bool> archiveProduct({required String productId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLProductError(
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

    final MutationOptions options = MutationOptions(
      document: _archiveProductMutation.document,
      variables: {
        'productId': productId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isArchived = result.data?['archiveProductByBusiness'] ?? false;

    return isArchived;
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
      required String serviceUnitId}) async {
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

  Future<ServiceUpdateResult> updateServices(
      {required String serviceId,
      String? name,
      double? price,
      String? serviceUnitId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return ServiceUpdateResult.error(
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
      document: _updateServiceMutation.document,
      variables: {
        'serviceId': serviceId,
        'input': {
          'name': name,
          'price': price,
          'serviceUnitId': serviceUnitId,
        },
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      return ServiceUpdateResult.error(
        error: GraphQLServiceError(
          message: result.exception?.graphqlErrors.first.message.toString(),
        ),
      );
    }

    if (result.data == null || result.data!['updateService'] == null) {
      return ServiceUpdateResult.error(
        error: GraphQLServiceError(
          message: "Error parsing response data",
        ),
      );
    }

    var resultexpense_id = result.data?['updateService']['id'];

    var service = ServiceUpdateSuccessResult(
      result_id: resultexpense_id,
    );

    return ServiceUpdateResult(service: service);
  }

  Future<bool> archiveService({required String serviceId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLServiceError(
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

    final MutationOptions options = MutationOptions(
      document: _archiveServiceMutation.document,
      variables: {
        'serviceId': serviceId,
      },
    );

    final QueryResult result = await newClient.mutate(options);

    if (result.hasException) {
      // Handle any errors that may have occurred during the log out process
      throw Exception(result.exception);
    }

    bool isArchived = result.data?['archiveServiceByBusiness'] ?? false;

    return isArchived;
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLProductError(
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
    final QueryOptions options = QueryOptions(
      document: _getProductOrServiceByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult productorserviceByBusinessResult =
        await newClient.query(options);

    if (productorserviceByBusinessResult.hasException) {
      throw GraphQLProductError(
        message: productorserviceByBusinessResult
            .exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List productsorservicesData =
        productorserviceByBusinessResult.data?['getProductOrServiceByBusiness']
                ['productOrServiceByBusiness'] ??
            [];

    final List<Items> items = productsorservicesData.map((data) {
      final productData = data['product'];
      final serviceData = data['service'];

      return Items(
        id: data['id'],
        title: data['title'],
        type: data['type'],
        price: data['price'],
        productUnitId:
            productData != null ? productData['productUnitId'] : null,
        productName: productData != null ? productData['productName'] : null,
        productUnitName:
            productData != null && productData['productUnit'] != null
                ? productData['productUnit']['unitName']
                : null,
        serviceUnitId:
            serviceData != null ? serviceData['serviceUnitId'] : null,
        serviceName: serviceData != null ? serviceData['name'] : null,
        serviceUnitName:
            serviceData != null && serviceData['serviceUnit'] != null
                ? serviceData['serviceUnit']['unitName']
                : null,
        basicUnit: productData != null ? productData['basicUnit'] : null,
        quantity: 1,
      );
    }).toList();

    return items;

//     final List<Items> items = productsorservicesData.map((data) {
//       return Items(
//         id: data['id'],
//         title: data['title'],
//         type: data['type'],
//         price: data['price'],
//         productUnitId:
//             data['product'] != null ? data['product']['productUnitId'] : null,
//         productName:
//             data['product'] != null ? data['product']['productName'] : null,
//         productUnitName: data['product']['productUnit'] != null
//             ? data['product']['productUnit']['unitName']
//             : null,
//         serviceUnitId:
//             data['service'] != null ? data['service']['serviceUnitId'] : null,

//         serviceName: data['service'] != null ? data['service']['name'] : null,
// //  serviceUnitName: data['service']['serviceUnit'] != null
//         //     ? data['service']['serviceUnit']['unitName']
//         //     : null,
//         basicUnit:
//             data['product'] != null ? data['product']['basicUnit'] : null,
//         quantity: 1,
//       );
//     }).toList();

    // return items;
  }

  Future<List<Products>> getProductsByBusiness(
      {required String businessId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw GraphQLProductError(
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
    final QueryOptions options = QueryOptions(
      document: _getProductsByBusinessQuery.document,
      variables: {'input': businessId},
    );

    final QueryResult productsByBusinessResult = await newClient.query(options);

    if (productsByBusinessResult.hasException) {
      throw GraphQLProductError(
        message: productsByBusinessResult.exception?.graphqlErrors.first.message
            .toString(),
      );
    }

    final List productsData = productsByBusinessResult
            .data?['getProductsByBusiness']['productByBusiness'] ??
        [];

    final List<Products> products = productsData.map((data) {
      return Products(
          id: data['id'],
          productName: data['productName'],
          quantity: 1,
          price: data['price']);
    }).toList();

    return products;
  }
}

class Products {
  final String id;
  final String productName;
  num quantity = 1;
  num price;

  Products(
      {required this.id,
      required this.productName,
      required this.quantity,
      required this.price});
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
  num? basicUnit;
  // num? quantityInStock;
  String? productUnitName;
  String? productName;
  String? serviceName;
  String? serviceUnitName;

  Items(
      {required this.id,
      required this.title,
      required this.type,
      this.productUnitId,
      this.serviceUnitId,
      required this.price,
      required this.quantity,
      this.basicUnit,
      // this.quantityInStock,
      this.productUnitName,
      this.productName,
      this.serviceName,
      this.serviceUnitName});
}

class ProductCreationResult {
  late final ProductCreationSuccessResult? product;
  late final GraphQLProductError? error;

  ProductCreationResult({this.product}) : error = null;
  ProductCreationResult.error({this.error}) : product = null;

  bool get hasError => error != null;
}

class ProductCreationSuccessResult {
  ProductCreationSuccessResult({
    required this.result_id,
    required this.result_productName,
    required this.result_price,
    // this.basicUnit,
    // this.quantityInStock,
    // this.productUnitName
  });

  late final String result_id;
  late final String result_productName;
  late final num result_price;
  // num? basicUnit;
  // num? quantityInStock;
  // String? productUnitName;
}

class ProductUpdateResult {
  late final ProductUpdateSuccessResult? product;
  late final GraphQLProductError? error;

  ProductUpdateResult({this.product}) : error = null;
  ProductUpdateResult.error({this.error}) : product = null;

  bool get hasError => error != null;
}

class ProductUpdateSuccessResult {
  ProductUpdateSuccessResult({
    required this.result_id,
  });

  late final String result_id;
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

class ServiceUpdateResult {
  late final ServiceUpdateSuccessResult? service;
  late final GraphQLServiceError? error;

  ServiceUpdateResult({this.service}) : error = null;
  ServiceUpdateResult.error({this.error}) : service = null;

  bool get hasError => error != null;
}

class ServiceUpdateSuccessResult {
  ServiceUpdateSuccessResult({
    required this.result_id,
  });

  late final String result_id;
}

class GraphQLServiceError {
  final String? message;

  GraphQLServiceError({required this.message});
}
