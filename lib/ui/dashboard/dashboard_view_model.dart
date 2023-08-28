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
  bool isInitialLoading = true;

  bool _isViewLoaded = false;

  // Add your data loading logic here, you can use loadData() as before.

  // Custom method to load data only once
  Future<void> loadDataOnce() async {
    // Load data only if the view has not been loaded yet
    if (!_isViewLoaded) {
      setBusy(true); // Show the loading state

      try {
        await loadData(); // Your existing data loading logic

        // Once data is loaded, set the flag to true
        _isViewLoaded = true;
      } catch (e) {
        // Handle errors
        print('Error while loading data: $e');
      } finally {
        setBusy(false); // Hide the loading state
      }
    }
  }

  Future<void> loadData() async {
    // Set the ViewModel as busy to show the loading state
    if (isInitialLoading) {
      setBusy(true);
    }

    // Add try-catch blocks to handle errors during data fetching
    try {
      await getBusinessesByUserId();
      await getExpenseByBusiness();
      await getInvoiceByBusiness();
      await getCustomerByBusiness();
      await getExpensesForWeek();
      await getPurchasesForWeek();
      await totalWeeklyInvoicesAmount();
      await getExpensesForMonth();
      await getPurchasesForMonth();
      await totalMonthlyInvoicesAmount();
      await getOverdueInvoiceByBusiness();

      setBusy(false);
      // Once all the data is fetched, set the ViewModel as not busy
      isInitialLoading = false;
    } catch (e) {
      // If there's an error during data fetching, handle it appropriately
      // For example, show an error message to the user
      // and set the ViewModel as not busy
      // Handle the error, e.g., show an error dialog or log the error
      print('Error while loading data: $e');
    } finally {
      setBusy(
          false); // Set the ViewModel as not busy, whether there was an error or not
    }
  }

  final _expenses = ReactiveValue<List<Expenses>>([]);
  List<Expenses> get expenses => _expenses.value;
  final _take = ReactiveValue<int>(3);
  int get take => _take.value;

  final _invoices = ReactiveValue<List<Invoices>>([]);
  List<Invoices> get invoices => _invoices.value;

  final _overdueInvoices = ReactiveValue<List<Invoices>>([]);
  List<Invoices> get overdueInvoices => _overdueInvoices.value;

  final _customers = ReactiveValue<List<Customers?>>([]);
  List<Customers?> get customers => _customers.value;

  final _expenseForWeek = ReactiveValue<ExpensesForWeek?>(null);
  ExpensesForWeek? get expenseForWeek => _expenseForWeek.value;

  final _purchaseForWeek = ReactiveValue<PurchasesForWeek?>(null);
  PurchasesForWeek? get purchaseForWeek => _purchaseForWeek.value;

  final _weeklyInvoices = ReactiveValue<WeeklyInvoices?>(null);
  WeeklyInvoices? get weeklyInvoices => _weeklyInvoices.value;

  final _expenseForMonth = ReactiveValue<ExpensesForMonth?>(null);
  ExpensesForMonth? get expenseForMonth => _expenseForMonth.value;

  final _purchaseForMonth = ReactiveValue<PurchasesForMonth?>(null);
  PurchasesForMonth? get purchaseForMonth => _purchaseForMonth.value;

  final _monthlyInvoices = ReactiveValue<MonthlyInvoices?>(null);
  MonthlyInvoices? get monthlyInvoices => _monthlyInvoices.value;
  DashboardViewModel() {
    listenToReactiveValues([
      _expenses,
      _invoices,
      _customers,
      _take,
      _expenseForWeek,
      _purchaseForWeek,
      _expenseForMonth,
      _purchaseForMonth,
      _weeklyInvoices,
      _monthlyInvoices
    ]);
  }
  Future<void> getBusinessesByUserId() async {
    await _dashboardService.businessId();
    if (_dashboardService.businessId == null) {
      navigationService.replaceWith(Routes.verificationRoute);
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

  Future<List<Invoices>> getOverdueInvoiceByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing expense categories
    final invoiceList = await _invoiceService.getInvoiceByBusiness(
      businessId: businessIdValue,
    );

    final overdueInvoiceList =
        invoiceList.where((invoice) => invoice.overdue == true).toList();

    final limitedOverdueInvoiceList =
        overdueInvoiceList.take(_take.value).toList();

    _overdueInvoices.value.addAll(limitedOverdueInvoiceList);
    notifyListeners();
    return _overdueInvoices.value;
  }

  Future<List<Customers?>> getCustomerByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing expense categories
    final customerList = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue, take: _take.value);
    _customers.value.addAll(customerList);
    notifyListeners();
    return _customers.value;
  }

  Future<ExpensesForWeek?> getExpensesForWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _expenseForWeek.value =
        await _dashboardService.getExpensesForWeek(businessId: businessIdValue);
    return _expenseForWeek.value;
  }

  Future<PurchasesForWeek?> getPurchasesForWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _purchaseForWeek.value = await _dashboardService.getPurchasesForWeek(
        businessId: businessIdValue);
    return _purchaseForWeek.value;
  }

  Future<ExpensesForMonth?> getExpensesForMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _expenseForMonth.value = await _dashboardService.getExpensesForMonth(
        businessId: businessIdValue);
    return _expenseForMonth.value;
  }

  Future<PurchasesForMonth?> getPurchasesForMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';
    _purchaseForMonth.value = await _dashboardService.getPurchasesForMonth(
        businessId: businessIdValue);
    return _purchaseForMonth.value;
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
