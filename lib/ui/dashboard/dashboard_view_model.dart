import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/authentication_service.dart';
import 'package:verzo_one/services/dashboard_service.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/invoices_service.dart';

class DashboardViewModel extends BaseViewModel with ReactiveServiceMixin {
  final navigationService = locator<NavigationService>();
  final _dashboardService = locator<DashboardService>();
  final _expenseService = locator<ExpenseService>();
  final _invoiceService = locator<InvoiceService>();
  final _authenticationService = locator<AuthenticationService>();
  final DialogService dialogService = locator<DialogService>();

  // late WeeklyInvoices weeklyInvoices;
  // late MonthlyInvoices monthlyInvoices;

  // final navigationService = locator<NavigationService>();
  // final _invoiceService = locator<InvoiceService>();
  // final _expenseService = locator<ExpenseService>();

  final _expenses = ReactiveValue<List<Expenses>>([]);
  List<Expenses> get expenses => _expenses.value;
  final _take = ReactiveValue<num>(3);
  num get take => _take.value;

  final _invoices = ReactiveValue<List<Invoices>>([]);
  List<Invoices> get invoices => _invoices.value;

  final _customers = ReactiveValue<List<Customers>>([]);
  List<Customers> get customers => _customers.value;

  final _expenseForWeek = ReactiveValue<ExpensesForWeek?>(null);
  ExpensesForWeek? get expenseForWeek => _expenseForWeek.value;

  final _weeklyInvoices = ReactiveValue<WeeklyInvoices?>(null);
  WeeklyInvoices? get weeklyInvoices => _weeklyInvoices.value;

  final _expenseForMonth = ReactiveValue<ExpensesForMonth?>(null);
  ExpensesForMonth? get expenseForMonth => _expenseForMonth.value;

  final _monthlyInvoices = ReactiveValue<MonthlyInvoices?>(null);
  MonthlyInvoices? get monthlyInvoices => _monthlyInvoices.value;
  DashboardViewModel() {
    listenToReactiveValues([
      _expenses,
      _invoices,
      _customers,
      _take,
      _expenseForWeek,
      _expenseForMonth,
      _weeklyInvoices,
      _monthlyInvoices
    ]);
  }
  Future<ExpensesForWeek?> getExpensesForWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _expenseForWeek.value =
        await _dashboardService.getExpensesForWeek(businessId: businessIdValue);
    return _expenseForWeek.value;
  }

  Future<ExpensesForMonth?> getExpensesForMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _expenseForMonth.value = await _dashboardService.getExpensesForMonth(
        businessId: businessIdValue);
    return _expenseForMonth.value;
  }

  Future<WeeklyInvoices?> totalWeeklyInvoicesAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _weeklyInvoices.value = await _dashboardService.totalWeeklyInvoicesAmount(
        businessId: businessIdValue);
    return _weeklyInvoices.value;
  }

  Future<MonthlyInvoices?> totalMonthlyInvoicesAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _monthlyInvoices.value = await _dashboardService.totalMonthlyInvoicesAmount(
        businessId: businessIdValue);
    return _monthlyInvoices.value;
  }

  Future<void> getBusinessesByUserId() => _dashboardService.businessId();
  Future<void> logout() async {
    final DialogResponse? response = await dialogService.showConfirmationDialog(
      dialogPlatform: DialogPlatform.Cupertino,
      title: 'Logout',
      description: 'Are you sure you want to logout?',
      barrierDismissible: true,
      cancelTitle: 'Cancel',
      confirmationTitle: 'Ok',
    );
    if (response?.confirmed == true) {
      await _authenticationService.logout();
      navigationService.replaceWith(Routes.loginRoute);
      // Perform any additional logout actions
    }
  }

  Future<List<Expenses>> getExpenseByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing expense categories
    final expenseList = await _expenseService.getExpenseByBusiness(
        businessId: businessIdValue, take: _take.value);
    _expenses.value.addAll(expenseList);
    notifyListeners();
    return _expenses.value;
  }

  Future<List<Invoices>> getInvoiceByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing expense categories
    final invoiceList = await _invoiceService.getInvoiceByBusiness(
        businessId: businessIdValue, take: _take.value);
    _invoices.value.addAll(invoiceList);
    notifyListeners();
    return _invoices.value;
  }

  Future<List<Customers>> getCustomerByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing expense categories
    final customerList = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue, take: _take.value);
    _customers.value.addAll(customerList);
    notifyListeners();
    return _customers.value;
  }

  // Future<List<Invoices>> getInvoiceByBusiness() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String businessIdValue = prefs.getString('businessId') ?? '';

  //   // Retrieve existing expense categories
  //   final invoices =
  //       await _invoiceService.getInvoiceByBusiness(businessId: businessIdValue);
  //   return invoices;
  // }

  // Future<List<Expenses>> getExpenseByBusiness() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String businessIdValue = prefs.getString('businessId') ?? '';

  //   // Retrieve existing expense categories
  //   final expenses = await _expenseService.getExpenseByBusiness(
  //       businessId: businessIdValue, take: 3);
  //   return expenses;
  // }
}
