// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i42;
import 'package:flutter/foundation.dart' as _i43;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i48;
import 'package:verzo_one/services/expenses_service.dart' as _i44;
import 'package:verzo_one/services/invoices_service.dart' as _i45;
import 'package:verzo_one/services/product&services_service.dart' as _i47;
import 'package:verzo_one/services/purchase_order_service.dart' as _i46;
import 'package:verzo_one/ui/add_customers/add_customers_view.dart' as _i37;
import 'package:verzo_one/ui/add_expenses/add_expenses_view.dart' as _i20;
import 'package:verzo_one/ui/add_invoices/add_invoices_view.dart' as _i22;
import 'package:verzo_one/ui/add_item/add_item_view.dart' as _i18;
import 'package:verzo_one/ui/add_products_services/add_products_services_view.dart'
    as _i38;
import 'package:verzo_one/ui/add_purchase_item/add_purchase_item_view.dart'
    as _i19;
import 'package:verzo_one/ui/add_purchase_order/add_purchase_order_view.dart'
    as _i36;
import 'package:verzo_one/ui/add_sales/add_sales_view.dart' as _i21;
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.dart'
    as _i10;
import 'package:verzo_one/ui/choose_item/choose_item_view.dart' as _i16;
import 'package:verzo_one/ui/choose_purchaseItem/choose_purchaseItem_view.dart'
    as _i17;
import 'package:verzo_one/ui/create_account/create_account_view.dart' as _i6;
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart' as _i39;
import 'package:verzo_one/ui/customers/customers_view.dart' as _i34;
import 'package:verzo_one/ui/dashboard/dashboard_view.dart' as _i12;
import 'package:verzo_one/ui/expenses/expenses_view.dart' as _i13;
import 'package:verzo_one/ui/forgot_password/forgot_password_view.dart' as _i8;
import 'package:verzo_one/ui/invoicing/invoicing_view.dart' as _i15;
import 'package:verzo_one/ui/login/login_view.dart' as _i7;
import 'package:verzo_one/ui/make_purchase_payment/make_purchase_payment_view.dart'
    as _i41;
import 'package:verzo_one/ui/products_services/products_services_view.dart'
    as _i33;
import 'package:verzo_one/ui/purchase_order/purchase_order_view.dart' as _i35;
import 'package:verzo_one/ui/sales/sales_view.dart' as _i14;
import 'package:verzo_one/ui/select_tags/select_tags_view.dart' as _i11;
import 'package:verzo_one/ui/update_customers/update_customers_view.dart'
    as _i24;
import 'package:verzo_one/ui/update_expenses/update_expenses_view.dart' as _i23;
import 'package:verzo_one/ui/update_invoices/update_invoices_view.dart' as _i27;
import 'package:verzo_one/ui/update_products_services/update_products_services_view.dart'
    as _i26;
import 'package:verzo_one/ui/update_purchases/update_purchases_view.dart'
    as _i25;
import 'package:verzo_one/ui/upload_merchant_invoice_to_purchase/upload_merchant_invoice_to_purchase_view.dart'
    as _i40;
import 'package:verzo_one/ui/verification/verification_view.dart' as _i9;
import 'package:verzo_one/ui/view_customers/view_customers_view.dart' as _i30;
import 'package:verzo_one/ui/view_expenses/view_expenses_view.dart' as _i28;
import 'package:verzo_one/ui/view_invoices/view_invoices_view.dart' as _i29;
import 'package:verzo_one/ui/view_products_services/view_products_services_view.dart'
    as _i32;
import 'package:verzo_one/ui/view_purchase/view_purchase_view.dart' as _i31;
import 'package:verzo_one/ui/views/first_screen.dart' as _i3;
import 'package:verzo_one/ui/views/home_screen.dart' as _i2;
import 'package:verzo_one/ui/views/login_screen.dart' as _i4;
import 'package:verzo_one/ui/views/second_screen.dart' as _i5;

class Routes {
  static const homeScreenRoute = '/home-screen';

  static const firstScreenRoute = '/first-screen';

  static const LoginScreenRoute = '/login-screen';

  static const secondScreenRoute = '/second-screen';

  static const createAccountRoute = '/create-account-view';

  static const loginRoute = '/';

  static const forgotPasswordRoute = '/forgot-password-view';

  static const verificationRoute = '/verification-view';

  static const businessProfileCreationRoute = '/business-profile-creation-view';

  static const selectTagsRoute = '/select-tags-view';

  static const dashboardRoute = '/dashboard-view';

  static const expensesRoute = '/expenses-view';

  static const salesRoute = '/sales-view';

  static const invoicingRoute = '/invoices-view';

  static const chooseItemRoute = '/choose-item-view';

  static const choosePurchaseItemRoute = '/choose-purchase-item-view';

  static const addItemRoute = '/add-item-view';

  static const addPurchaseItemRoute = '/add-purchase-item-view';

  static const addExpenseRoute = '/add-expenses-view';

  static const addSalesRoute = '/add-sales-view';

  static const addInvoiceRoute = '/add-invoices-view';

  static const updateExpenseRoute = '/update-expenses-view';

  static const updateCustomerRoute = '/update-customers-view';

  static const updatePurchaseRoute = '/update-purchases-view';

  static const updateProductsServicesRoute = '/update-products-services-view';

  static const updateInvoiceRoute = '/update-invoices-view';

  static const viewExpenseRoute = '/view-expenses-view';

  static const viewInvoiceRoute = '/view-invoices-view';

  static const viewCustomerRoute = '/view-customers-view';

  static const viewPurchaseRoute = '/view-purchase-view';

  static const viewProductsServicesRoute = '/view-products-services-view';

  static const productsServicesRoute = '/products-services-view';

  static const customersRoute = '/customers-view';

  static const purchaseOrderRoute = '/purchase-order-view';

  static const addPurchaseOrderRoute = '/add-purchase-order-view';

  static const addCustomersRoute = '/add-customers-view';

  static const addProductsServicesRoute = '/add-products-services-view';

  static const createMerchantRoute = '/create-merchant-view';

  static const uploadMerchantInvoiceToPurchaseRoute =
      '/upload-merchant-invoice-to-purchase-view';

  static const makePurchasePaymentRoute = '/make-purchase-payment-view';

  static const all = <String>{
    homeScreenRoute,
    firstScreenRoute,
    LoginScreenRoute,
    secondScreenRoute,
    createAccountRoute,
    loginRoute,
    forgotPasswordRoute,
    verificationRoute,
    businessProfileCreationRoute,
    selectTagsRoute,
    dashboardRoute,
    expensesRoute,
    salesRoute,
    invoicingRoute,
    chooseItemRoute,
    choosePurchaseItemRoute,
    addItemRoute,
    addPurchaseItemRoute,
    addExpenseRoute,
    addSalesRoute,
    addInvoiceRoute,
    updateExpenseRoute,
    updateCustomerRoute,
    updatePurchaseRoute,
    updateProductsServicesRoute,
    updateInvoiceRoute,
    viewExpenseRoute,
    viewInvoiceRoute,
    viewCustomerRoute,
    viewPurchaseRoute,
    viewProductsServicesRoute,
    productsServicesRoute,
    customersRoute,
    purchaseOrderRoute,
    addPurchaseOrderRoute,
    addCustomersRoute,
    addProductsServicesRoute,
    createMerchantRoute,
    uploadMerchantInvoiceToPurchaseRoute,
    makePurchasePaymentRoute,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeScreenRoute,
      page: _i2.HomeScreen,
    ),
    _i1.RouteDef(
      Routes.firstScreenRoute,
      page: _i3.FirstScreen,
    ),
    _i1.RouteDef(
      Routes.LoginScreenRoute,
      page: _i4.LoginScreen,
    ),
    _i1.RouteDef(
      Routes.secondScreenRoute,
      page: _i5.SecondScreen,
    ),
    _i1.RouteDef(
      Routes.createAccountRoute,
      page: _i6.CreateAccountView,
    ),
    _i1.RouteDef(
      Routes.loginRoute,
      page: _i7.LoginView,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordRoute,
      page: _i8.ForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.verificationRoute,
      page: _i9.VerificationView,
    ),
    _i1.RouteDef(
      Routes.businessProfileCreationRoute,
      page: _i10.BusinessProfileCreationView,
    ),
    _i1.RouteDef(
      Routes.selectTagsRoute,
      page: _i11.SelectTagsView,
    ),
    _i1.RouteDef(
      Routes.dashboardRoute,
      page: _i12.DashboardView,
    ),
    _i1.RouteDef(
      Routes.expensesRoute,
      page: _i13.ExpensesView,
    ),
    _i1.RouteDef(
      Routes.salesRoute,
      page: _i14.SalesView,
    ),
    _i1.RouteDef(
      Routes.invoicingRoute,
      page: _i15.InvoicesView,
    ),
    _i1.RouteDef(
      Routes.chooseItemRoute,
      page: _i16.ChooseItemView,
    ),
    _i1.RouteDef(
      Routes.choosePurchaseItemRoute,
      page: _i17.ChoosePurchaseItemView,
    ),
    _i1.RouteDef(
      Routes.addItemRoute,
      page: _i18.AddItemView,
    ),
    _i1.RouteDef(
      Routes.addPurchaseItemRoute,
      page: _i19.AddPurchaseItemView,
    ),
    _i1.RouteDef(
      Routes.addExpenseRoute,
      page: _i20.AddExpensesView,
    ),
    _i1.RouteDef(
      Routes.addSalesRoute,
      page: _i21.AddSalesView,
    ),
    _i1.RouteDef(
      Routes.addInvoiceRoute,
      page: _i22.AddInvoicesView,
    ),
    _i1.RouteDef(
      Routes.updateExpenseRoute,
      page: _i23.UpdateExpensesView,
    ),
    _i1.RouteDef(
      Routes.updateCustomerRoute,
      page: _i24.UpdateCustomersView,
    ),
    _i1.RouteDef(
      Routes.updatePurchaseRoute,
      page: _i25.UpdatePurchasesView,
    ),
    _i1.RouteDef(
      Routes.updateProductsServicesRoute,
      page: _i26.UpdateProductsServicesView,
    ),
    _i1.RouteDef(
      Routes.updateInvoiceRoute,
      page: _i27.UpdateInvoicesView,
    ),
    _i1.RouteDef(
      Routes.viewExpenseRoute,
      page: _i28.ViewExpensesView,
    ),
    _i1.RouteDef(
      Routes.viewInvoiceRoute,
      page: _i29.ViewInvoicesView,
    ),
    _i1.RouteDef(
      Routes.viewCustomerRoute,
      page: _i30.ViewCustomersView,
    ),
    _i1.RouteDef(
      Routes.viewPurchaseRoute,
      page: _i31.ViewPurchaseView,
    ),
    _i1.RouteDef(
      Routes.viewProductsServicesRoute,
      page: _i32.ViewProductsServicesView,
    ),
    _i1.RouteDef(
      Routes.productsServicesRoute,
      page: _i33.ProductsServicesView,
    ),
    _i1.RouteDef(
      Routes.customersRoute,
      page: _i34.CustomersView,
    ),
    _i1.RouteDef(
      Routes.purchaseOrderRoute,
      page: _i35.PurchaseOrderView,
    ),
    _i1.RouteDef(
      Routes.addPurchaseOrderRoute,
      page: _i36.AddPurchaseOrderView,
    ),
    _i1.RouteDef(
      Routes.addCustomersRoute,
      page: _i37.AddCustomersView,
    ),
    _i1.RouteDef(
      Routes.addProductsServicesRoute,
      page: _i38.AddProductsServicesView,
    ),
    _i1.RouteDef(
      Routes.createMerchantRoute,
      page: _i39.CreateMerchantView,
    ),
    _i1.RouteDef(
      Routes.uploadMerchantInvoiceToPurchaseRoute,
      page: _i40.UploadMerchantInvoiceToPurchaseView,
    ),
    _i1.RouteDef(
      Routes.makePurchasePaymentRoute,
      page: _i41.MakePurchasePaymentView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeScreen: (data) {
      final args = data.getArgs<HomeScreenArguments>(
        orElse: () => const HomeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeScreen(key: args.key),
        settings: data,
      );
    },
    _i3.FirstScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.FirstScreen(),
        settings: data,
      );
    },
    _i4.LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginScreen(),
        settings: data,
      );
    },
    _i5.SecondScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SecondScreen(),
        settings: data,
      );
    },
    _i6.CreateAccountView: (data) {
      final args = data.getArgs<CreateAccountViewArguments>(
        orElse: () => const CreateAccountViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i6.CreateAccountView(key: args.key),
        settings: data,
      );
    },
    _i7.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i7.LoginView(key: args.key),
        settings: data,
      );
    },
    _i8.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i8.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i9.VerificationView: (data) {
      final args = data.getArgs<VerificationViewArguments>(
        orElse: () => const VerificationViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i9.VerificationView(key: args.key),
        settings: data,
      );
    },
    _i10.BusinessProfileCreationView: (data) {
      final args = data.getArgs<BusinessProfileCreationViewArguments>(
        orElse: () => const BusinessProfileCreationViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i10.BusinessProfileCreationView(key: args.key),
        settings: data,
      );
    },
    _i11.SelectTagsView: (data) {
      final args = data.getArgs<SelectTagsViewArguments>(
        orElse: () => const SelectTagsViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) =>
            _i11.SelectTagsView(key: args.key, busy: args.busy),
        settings: data,
      );
    },
    _i12.DashboardView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i12.DashboardView(),
        settings: data,
      );
    },
    _i13.ExpensesView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i13.ExpensesView(),
        settings: data,
      );
    },
    _i14.SalesView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i14.SalesView(),
        settings: data,
      );
    },
    _i15.InvoicesView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i15.InvoicesView(),
        settings: data,
      );
    },
    _i16.ChooseItemView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i16.ChooseItemView(),
        settings: data,
      );
    },
    _i17.ChoosePurchaseItemView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i17.ChoosePurchaseItemView(),
        settings: data,
      );
    },
    _i18.AddItemView: (data) {
      final args = data.getArgs<AddItemViewArguments>(
        orElse: () => const AddItemViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i18.AddItemView(key: args.key),
        settings: data,
      );
    },
    _i19.AddPurchaseItemView: (data) {
      final args = data.getArgs<AddPurchaseItemViewArguments>(
        orElse: () => const AddPurchaseItemViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i19.AddPurchaseItemView(key: args.key),
        settings: data,
      );
    },
    _i20.AddExpensesView: (data) {
      final args = data.getArgs<AddExpensesViewArguments>(
        orElse: () => const AddExpensesViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i20.AddExpensesView(key: args.key),
        settings: data,
      );
    },
    _i21.AddSalesView: (data) {
      final args = data.getArgs<AddSalesViewArguments>(
        orElse: () => const AddSalesViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i21.AddSalesView(key: args.key, busy: args.busy),
        settings: data,
      );
    },
    _i22.AddInvoicesView: (data) {
      final args = data.getArgs<AddInvoicesViewArguments>(
        orElse: () => const AddInvoicesViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i22.AddInvoicesView(key: args.key),
        settings: data,
      );
    },
    _i23.UpdateExpensesView: (data) {
      final args = data.getArgs<UpdateExpensesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i23.UpdateExpensesView(
            key: args.key, selectedExpense: args.selectedExpense),
        settings: data,
      );
    },
    _i24.UpdateCustomersView: (data) {
      final args = data.getArgs<UpdateCustomersViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i24.UpdateCustomersView(
            key: args.key, selectedCustomer: args.selectedCustomer),
        settings: data,
      );
    },
    _i25.UpdatePurchasesView: (data) {
      final args = data.getArgs<UpdatePurchasesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i25.UpdatePurchasesView(
            key: args.key, selectedPurcahses: args.selectedPurcahses),
        settings: data,
      );
    },
    _i26.UpdateProductsServicesView: (data) {
      final args =
          data.getArgs<UpdateProductsServicesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i26.UpdateProductsServicesView(
            key: args.key, selectedItem: args.selectedItem),
        settings: data,
      );
    },
    _i27.UpdateInvoicesView: (data) {
      final args = data.getArgs<UpdateInvoicesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i27.UpdateInvoicesView(
            key: args.key, selectedInvoice: args.selectedInvoice),
        settings: data,
      );
    },
    _i28.ViewExpensesView: (data) {
      final args = data.getArgs<ViewExpensesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i28.ViewExpensesView(
            key: args.key, selectedExpense: args.selectedExpense),
        settings: data,
      );
    },
    _i29.ViewInvoicesView: (data) {
      final args = data.getArgs<ViewInvoicesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i29.ViewInvoicesView(
            key: args.key, selectedInvoice: args.selectedInvoice),
        settings: data,
      );
    },
    _i30.ViewCustomersView: (data) {
      final args = data.getArgs<ViewCustomersViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i30.ViewCustomersView(
            key: args.key, selectedCustomer: args.selectedCustomer),
        settings: data,
      );
    },
    _i31.ViewPurchaseView: (data) {
      final args = data.getArgs<ViewPurchaseViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i31.ViewPurchaseView(
            key: args.key, selectedPurchase: args.selectedPurchase),
        settings: data,
      );
    },
    _i32.ViewProductsServicesView: (data) {
      final args =
          data.getArgs<ViewProductsServicesViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i32.ViewProductsServicesView(
            key: args.key, selecteditem: args.selecteditem),
        settings: data,
      );
    },
    _i33.ProductsServicesView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i33.ProductsServicesView(),
        settings: data,
      );
    },
    _i34.CustomersView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i34.CustomersView(),
        settings: data,
      );
    },
    _i35.PurchaseOrderView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i35.PurchaseOrderView(),
        settings: data,
      );
    },
    _i36.AddPurchaseOrderView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i36.AddPurchaseOrderView(),
        settings: data,
      );
    },
    _i37.AddCustomersView: (data) {
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i37.AddCustomersView(),
        settings: data,
      );
    },
    _i38.AddProductsServicesView: (data) {
      final args = data.getArgs<AddProductsServicesViewArguments>(
        orElse: () => const AddProductsServicesViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i38.AddProductsServicesView(key: args.key),
        settings: data,
      );
    },
    _i39.CreateMerchantView: (data) {
      final args = data.getArgs<CreateMerchantViewArguments>(
        orElse: () => const CreateMerchantViewArguments(),
      );
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i39.CreateMerchantView(key: args.key),
        settings: data,
      );
    },
    _i40.UploadMerchantInvoiceToPurchaseView: (data) {
      final args = data.getArgs<UploadMerchantInvoiceToPurchaseViewArguments>(
          nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i40.UploadMerchantInvoiceToPurchaseView(
            key: args.key, selectedPurchase: args.selectedPurchase),
        settings: data,
      );
    },
    _i41.MakePurchasePaymentView: (data) {
      final args =
          data.getArgs<MakePurchasePaymentViewArguments>(nullOk: false);
      return _i42.CupertinoPageRoute<dynamic>(
        builder: (context) => _i41.MakePurchasePaymentView(
            key: args.key, selectedPurchase: args.selectedPurchase),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeScreenArguments {
  const HomeScreenArguments({this.key});

  final _i43.Key? key;
}

class CreateAccountViewArguments {
  const CreateAccountViewArguments({this.key});

  final _i43.Key? key;
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i43.Key? key;
}

class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i43.Key? key;
}

class VerificationViewArguments {
  const VerificationViewArguments({this.key});

  final _i43.Key? key;
}

class BusinessProfileCreationViewArguments {
  const BusinessProfileCreationViewArguments({this.key});

  final _i43.Key? key;
}

class SelectTagsViewArguments {
  const SelectTagsViewArguments({
    this.key,
    this.busy = false,
  });

  final _i43.Key? key;

  final bool busy;
}

class AddItemViewArguments {
  const AddItemViewArguments({this.key});

  final _i43.Key? key;
}

class AddPurchaseItemViewArguments {
  const AddPurchaseItemViewArguments({this.key});

  final _i43.Key? key;
}

class AddExpensesViewArguments {
  const AddExpensesViewArguments({this.key});

  final _i43.Key? key;
}

class AddSalesViewArguments {
  const AddSalesViewArguments({
    this.key,
    this.busy = false,
  });

  final _i43.Key? key;

  final bool busy;
}

class AddInvoicesViewArguments {
  const AddInvoicesViewArguments({this.key});

  final _i43.Key? key;
}

class UpdateExpensesViewArguments {
  const UpdateExpensesViewArguments({
    this.key,
    required this.selectedExpense,
  });

  final _i43.Key? key;

  final _i44.Expenses selectedExpense;
}

class UpdateCustomersViewArguments {
  const UpdateCustomersViewArguments({
    this.key,
    required this.selectedCustomer,
  });

  final _i43.Key? key;

  final _i45.Customers selectedCustomer;
}

class UpdatePurchasesViewArguments {
  const UpdatePurchasesViewArguments({
    this.key,
    required this.selectedPurcahses,
  });

  final _i43.Key? key;

  final _i46.Purchases selectedPurcahses;
}

class UpdateProductsServicesViewArguments {
  const UpdateProductsServicesViewArguments({
    this.key,
    required this.selectedItem,
  });

  final _i43.Key? key;

  final _i47.Items selectedItem;
}

class UpdateInvoicesViewArguments {
  const UpdateInvoicesViewArguments({
    this.key,
    required this.selectedInvoice,
  });

  final _i43.Key? key;

  final _i45.Invoices selectedInvoice;
}

class ViewExpensesViewArguments {
  const ViewExpensesViewArguments({
    this.key,
    required this.selectedExpense,
  });

  final _i43.Key? key;

  final _i44.Expenses selectedExpense;
}

class ViewInvoicesViewArguments {
  const ViewInvoicesViewArguments({
    this.key,
    required this.selectedInvoice,
  });

  final _i43.Key? key;

  final _i45.Invoices selectedInvoice;
}

class ViewCustomersViewArguments {
  const ViewCustomersViewArguments({
    this.key,
    required this.selectedCustomer,
  });

  final _i43.Key? key;

  final _i45.Customers selectedCustomer;
}

class ViewPurchaseViewArguments {
  const ViewPurchaseViewArguments({
    this.key,
    required this.selectedPurchase,
  });

  final _i43.Key? key;

  final _i46.Purchases selectedPurchase;
}

class ViewProductsServicesViewArguments {
  const ViewProductsServicesViewArguments({
    this.key,
    required this.selecteditem,
  });

  final _i43.Key? key;

  final _i47.Items selecteditem;
}

class AddProductsServicesViewArguments {
  const AddProductsServicesViewArguments({this.key});

  final _i43.Key? key;
}

class CreateMerchantViewArguments {
  const CreateMerchantViewArguments({this.key});

  final _i43.Key? key;
}

class UploadMerchantInvoiceToPurchaseViewArguments {
  const UploadMerchantInvoiceToPurchaseViewArguments({
    this.key,
    required this.selectedPurchase,
  });

  final _i43.Key? key;

  final _i46.Purchases selectedPurchase;
}

class MakePurchasePaymentViewArguments {
  const MakePurchasePaymentViewArguments({
    this.key,
    required this.selectedPurchase,
  });

  final _i43.Key? key;

  final _i46.Purchases selectedPurchase;
}

extension NavigatorStateExtension on _i48.NavigationService {
  Future<dynamic> navigateToHomeScreenRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeScreenRoute,
        arguments: HomeScreenArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFirstScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.firstScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.LoginScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSecondScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.secondScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateAccountRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createAccountRoute,
        arguments: CreateAccountViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginRoute,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.forgotPasswordRoute,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerificationRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.verificationRoute,
        arguments: VerificationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBusinessProfileCreationRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.businessProfileCreationRoute,
        arguments: BusinessProfileCreationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectTagsRoute({
    _i43.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.selectTagsRoute,
        arguments: SelectTagsViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpensesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.expensesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSalesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.salesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInvoicingRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.invoicingRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChooseItemRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chooseItemRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChoosePurchaseItemRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.choosePurchaseItemRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddItemRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addItemRoute,
        arguments: AddItemViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddPurchaseItemRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addPurchaseItemRoute,
        arguments: AddPurchaseItemViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddExpenseRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addExpenseRoute,
        arguments: AddExpensesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddSalesRoute({
    _i43.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addSalesRoute,
        arguments: AddSalesViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddInvoiceRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addInvoiceRoute,
        arguments: AddInvoicesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateExpenseRoute({
    _i43.Key? key,
    required _i44.Expenses selectedExpense,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateExpenseRoute,
        arguments: UpdateExpensesViewArguments(
            key: key, selectedExpense: selectedExpense),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateCustomerRoute({
    _i43.Key? key,
    required _i45.Customers selectedCustomer,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateCustomerRoute,
        arguments: UpdateCustomersViewArguments(
            key: key, selectedCustomer: selectedCustomer),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdatePurchaseRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurcahses,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updatePurchaseRoute,
        arguments: UpdatePurchasesViewArguments(
            key: key, selectedPurcahses: selectedPurcahses),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateProductsServicesRoute({
    _i43.Key? key,
    required _i47.Items selectedItem,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateProductsServicesRoute,
        arguments: UpdateProductsServicesViewArguments(
            key: key, selectedItem: selectedItem),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateInvoiceRoute({
    _i43.Key? key,
    required _i45.Invoices selectedInvoice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateInvoiceRoute,
        arguments: UpdateInvoicesViewArguments(
            key: key, selectedInvoice: selectedInvoice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewExpenseRoute({
    _i43.Key? key,
    required _i44.Expenses selectedExpense,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewExpenseRoute,
        arguments: ViewExpensesViewArguments(
            key: key, selectedExpense: selectedExpense),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewInvoiceRoute({
    _i43.Key? key,
    required _i45.Invoices selectedInvoice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewInvoiceRoute,
        arguments: ViewInvoicesViewArguments(
            key: key, selectedInvoice: selectedInvoice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewCustomerRoute({
    _i43.Key? key,
    required _i45.Customers selectedCustomer,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewCustomerRoute,
        arguments: ViewCustomersViewArguments(
            key: key, selectedCustomer: selectedCustomer),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewPurchaseRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurchase,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewPurchaseRoute,
        arguments: ViewPurchaseViewArguments(
            key: key, selectedPurchase: selectedPurchase),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewProductsServicesRoute({
    _i43.Key? key,
    required _i47.Items selecteditem,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewProductsServicesRoute,
        arguments: ViewProductsServicesViewArguments(
            key: key, selecteditem: selecteditem),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductsServicesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.productsServicesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomersRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customersRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPurchaseOrderRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.purchaseOrderRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddPurchaseOrderRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addPurchaseOrderRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCustomersRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addCustomersRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddProductsServicesRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addProductsServicesRoute,
        arguments: AddProductsServicesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateMerchantRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createMerchantRoute,
        arguments: CreateMerchantViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUploadMerchantInvoiceToPurchaseRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurchase,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.uploadMerchantInvoiceToPurchaseRoute,
        arguments: UploadMerchantInvoiceToPurchaseViewArguments(
            key: key, selectedPurchase: selectedPurchase),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMakePurchasePaymentRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurchase,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.makePurchasePaymentRoute,
        arguments: MakePurchasePaymentViewArguments(
            key: key, selectedPurchase: selectedPurchase),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeScreenRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeScreenRoute,
        arguments: HomeScreenArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFirstScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.firstScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.LoginScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSecondScreenRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.secondScreenRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateAccountRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createAccountRoute,
        arguments: CreateAccountViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginRoute,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotPasswordRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.forgotPasswordRoute,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerificationRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.verificationRoute,
        arguments: VerificationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBusinessProfileCreationRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.businessProfileCreationRoute,
        arguments: BusinessProfileCreationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectTagsRoute({
    _i43.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.selectTagsRoute,
        arguments: SelectTagsViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpensesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.expensesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSalesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.salesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInvoicingRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.invoicingRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChooseItemRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chooseItemRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChoosePurchaseItemRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.choosePurchaseItemRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddItemRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addItemRoute,
        arguments: AddItemViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddPurchaseItemRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addPurchaseItemRoute,
        arguments: AddPurchaseItemViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddExpenseRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addExpenseRoute,
        arguments: AddExpensesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddSalesRoute({
    _i43.Key? key,
    bool busy = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addSalesRoute,
        arguments: AddSalesViewArguments(key: key, busy: busy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddInvoiceRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addInvoiceRoute,
        arguments: AddInvoicesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateExpenseRoute({
    _i43.Key? key,
    required _i44.Expenses selectedExpense,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateExpenseRoute,
        arguments: UpdateExpensesViewArguments(
            key: key, selectedExpense: selectedExpense),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateCustomerRoute({
    _i43.Key? key,
    required _i45.Customers selectedCustomer,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateCustomerRoute,
        arguments: UpdateCustomersViewArguments(
            key: key, selectedCustomer: selectedCustomer),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdatePurchaseRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurcahses,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updatePurchaseRoute,
        arguments: UpdatePurchasesViewArguments(
            key: key, selectedPurcahses: selectedPurcahses),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateProductsServicesRoute({
    _i43.Key? key,
    required _i47.Items selectedItem,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateProductsServicesRoute,
        arguments: UpdateProductsServicesViewArguments(
            key: key, selectedItem: selectedItem),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateInvoiceRoute({
    _i43.Key? key,
    required _i45.Invoices selectedInvoice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateInvoiceRoute,
        arguments: UpdateInvoicesViewArguments(
            key: key, selectedInvoice: selectedInvoice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewExpenseRoute({
    _i43.Key? key,
    required _i44.Expenses selectedExpense,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewExpenseRoute,
        arguments: ViewExpensesViewArguments(
            key: key, selectedExpense: selectedExpense),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewInvoiceRoute({
    _i43.Key? key,
    required _i45.Invoices selectedInvoice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewInvoiceRoute,
        arguments: ViewInvoicesViewArguments(
            key: key, selectedInvoice: selectedInvoice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewCustomerRoute({
    _i43.Key? key,
    required _i45.Customers selectedCustomer,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewCustomerRoute,
        arguments: ViewCustomersViewArguments(
            key: key, selectedCustomer: selectedCustomer),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewPurchaseRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurchase,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewPurchaseRoute,
        arguments: ViewPurchaseViewArguments(
            key: key, selectedPurchase: selectedPurchase),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewProductsServicesRoute({
    _i43.Key? key,
    required _i47.Items selecteditem,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewProductsServicesRoute,
        arguments: ViewProductsServicesViewArguments(
            key: key, selecteditem: selecteditem),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductsServicesRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.productsServicesRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomersRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customersRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPurchaseOrderRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.purchaseOrderRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddPurchaseOrderRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addPurchaseOrderRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddCustomersRoute([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addCustomersRoute,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddProductsServicesRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addProductsServicesRoute,
        arguments: AddProductsServicesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateMerchantRoute({
    _i43.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createMerchantRoute,
        arguments: CreateMerchantViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUploadMerchantInvoiceToPurchaseRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurchase,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.uploadMerchantInvoiceToPurchaseRoute,
        arguments: UploadMerchantInvoiceToPurchaseViewArguments(
            key: key, selectedPurchase: selectedPurchase),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMakePurchasePaymentRoute({
    _i43.Key? key,
    required _i46.Purchases selectedPurchase,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.makePurchasePaymentRoute,
        arguments: MakePurchasePaymentViewArguments(
            key: key, selectedPurchase: selectedPurchase),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
