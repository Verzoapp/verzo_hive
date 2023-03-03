import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';

class AddExpensesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();

  Future<void> init() async {}

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  void navigateBack() => navigationService.back();
}
