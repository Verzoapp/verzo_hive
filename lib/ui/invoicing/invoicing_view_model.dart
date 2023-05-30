import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';

class InvoicesViewModel extends FutureViewModel<List<Invoices>> {
  List<Invoices> newInvoice = [];
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();

  @override
  Future<List<Invoices>> futureToRun() => getInvoiceByBusiness();
  Future<List<Invoices>> getInvoiceByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

    // Retrieve existing expense categories
    final invoices =
        await _invoiceService.getInvoiceByBusiness(businessId: businessIdValue);
    return invoices;
  }

  void addNewInvoice(List<Invoices> invoice) {
    if (invoice.isNotEmpty) {
      newInvoice.addAll(invoice);
    }
    notifyListeners();
  }
}
