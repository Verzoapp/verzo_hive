import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:verzo_one/services/authentication_service.dart';
import 'package:verzo_one/services/business_profile_service.dart';
import 'package:verzo_one/services/dashboard_service.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/merchant_service.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/otp_verification_service.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/add_customers/add_customers_view.dart';
import 'package:verzo_one/ui/add_expenses/add_expenses_view.dart';
import 'package:verzo_one/ui/add_invoices/add_invoices_view.dart';
import 'package:verzo_one/ui/add_item/add_item_view.dart';
import 'package:verzo_one/ui/add_products_services/add_products_services_view.dart';
import 'package:verzo_one/ui/add_sales/add_sales_view.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.dart';
import 'package:verzo_one/ui/choose_item/choose_item_view.dart';
import 'package:verzo_one/ui/create_account/create_account_view.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart';
import 'package:verzo_one/ui/customers/customers_view.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view.dart';
import 'package:verzo_one/ui/forgot_password/forgot_password_view.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view.dart';
import 'package:verzo_one/ui/login/login_view.dart';
import 'package:verzo_one/ui/products_services/products_services_view.dart';
import 'package:verzo_one/ui/sales/sales_view.dart';
import 'package:verzo_one/ui/select_tags/select_tags_view.dart';
import 'package:verzo_one/ui/update_expenses/update_expenses_view.dart';
import 'package:verzo_one/ui/update_invoices/update_invoices_view.dart';
import 'package:verzo_one/ui/verification/verification_view.dart';
import 'package:verzo_one/ui/view_customers/view_customers_view.dart';
import 'package:verzo_one/ui/view_expenses/view_expenses_view.dart';
import 'package:verzo_one/ui/views/first_screen.dart';
import 'package:verzo_one/ui/views/home_screen.dart';
import 'package:verzo_one/ui/views/login_screen.dart';
import 'package:verzo_one/ui/views/second_screen.dart';

@StackedApp(
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    Singleton(classType: AuthenticationService),
    Singleton(classType: OTPVerificationService),
    Singleton(classType: MerchantService),
    Singleton(classType: BusinessCreationService),
    Singleton(classType: ExpenseService),
    Singleton(classType: InvoiceService),
    Singleton(classType: ProductsxServicesService),
    Singleton(classType: DashboardService)
  ],
  routes: [
    MaterialRoute(page: HomeScreen, name: 'homeScreenRoute'),
    MaterialRoute(
      page: FirstScreen,
      name: 'firstScreenRoute',
    ),
    MaterialRoute(
      page: LoginScreen,
      name: 'LoginScreenRoute',
    ),
    MaterialRoute(
      page: SecondScreen,
      name: 'secondScreenRoute',
    ),
    CupertinoRoute(page: CreateAccountView, name: 'createAccountRoute'),
    CupertinoRoute(page: LoginView, name: 'loginRoute', initial: true),
    CupertinoRoute(
      page: ForgotPasswordView,
      name: 'forgotPasswordRoute',
    ),
    CupertinoRoute(page: VerificationView, name: 'verificationRoute'),
    CupertinoRoute(
      page: BusinessProfileCreationView,
      name: 'businessProfileCreationRoute',
    ),
    CupertinoRoute(
      page: SelectTagsView,
      name: 'selectTagsRoute',
    ),
    CupertinoRoute(page: DashboardView, name: 'dashboardRoute'),
    CupertinoRoute(page: ExpensesView, name: 'expensesRoute'),
    CupertinoRoute(page: SalesView, name: 'salesRoute'),
    CupertinoRoute(
      page: InvoicesView,
      name: 'invoicingRoute',
    ),
    CupertinoRoute(page: ChooseItemView, name: 'chooseItemRoute'),
    CupertinoRoute(page: AddItemView, name: 'addItemRoute'),
    CupertinoRoute(page: AddExpensesView, name: 'addExpenseRoute'),
    CupertinoRoute(
      page: AddSalesView,
      name: 'addSalesRoute',
    ),
    CupertinoRoute(page: AddInvoicesView, name: 'addInvoiceRoute'),
    CupertinoRoute(page: UpdateExpensesView, name: 'updateExpenseRoute'),
    CupertinoRoute(page: UpdateInvoicesView, name: 'updateInvoiceRoute'),
    CupertinoRoute(page: ViewExpensesView, name: 'viewExpenseRoute'),
    CupertinoRoute(page: ViewCustomersView, name: 'viewCustomerRoute'),
    CupertinoRoute(page: ProductsServicesView, name: 'productsServicesRoute'),
    CupertinoRoute(page: CustomersView, name: 'customersRoute'),
    CupertinoRoute(page: AddCustomersView, name: 'addCustomersRoute'),
    CupertinoRoute(
        page: AddProductsServicesView, name: 'addProductsServicesRoute'),
    CupertinoRoute(page: CreateMerchantView, name: 'createMerchantRoute'),
  ],
)
class App extends StackedApp {
  App({required super.routes});
}
