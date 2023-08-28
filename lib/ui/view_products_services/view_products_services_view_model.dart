import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/product&services_service.dart';

class ViewProductsServicesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  late bool isProduct;
  late Items item;
  void navigateBack() => navigationService.back();

  ViewProductsServicesViewModel({required this.item}) {
    isProduct = item.type == 'P';
  }
  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
