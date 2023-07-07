import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/products_services/products_services_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import 'customers_view_model.dart';

class CustomersView extends StatefulWidget {
  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomersViewModel>.reactive(
      viewModelBuilder: () => CustomersViewModel(),
      onModelReady: (model) async {
        model.getCustomersByBusiness();
        model.addNewCustomer(model.newCustomer);
      },
      builder: (
        BuildContext context,
        CustomersViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            key: globalKey,
            drawer: Drawer(
              elevation: 100,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: kcPrimaryColor,
                    ),
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 36,
                        ),
                        verticalSpaceTiny,
                        Text(
                          'Tam',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        // Text(
                        //   'mem4real@gmail.com',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 24,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: Text('Home'),
                    onTap: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const DashboardView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                    ),
                    title: Text('Customers'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomersView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                    ),
                    title: Text('Products & Services'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsServicesView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Container(
                  height: 130,
                  color: kcPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        verticalSpaceMedium,
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.menu,
                                size: 32,
                              ),
                              color: kcButtonTextColor,
                              onPressed: () {
                                globalKey.currentState?.openDrawer();
                              },
                            ),
                            Text(
                              'Customers',
                              style: ktsHeaderTextWhite,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceTiny,
                Expanded(
                  child: SingleChildScrollView(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 50, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 300,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 60,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: kcPrimaryColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8)),
                                child: GestureDetector(
                                  onTap: () => model.navigationService
                                      .navigateTo(Routes.addCustomersRoute),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 16,
                                        color: kcPrimaryColor,
                                      ),
                                      Text(
                                        "NEW",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: kcPrimaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: kcButtonTextColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: kcTextColorLight.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Builder(builder: (context) {
                                if (model.isBusy) {
                                  return const CircularProgressIndicator(
                                    color: kcPrimaryColor,
                                  );
                                }
                                if (model.data == null) {
                                  return const Text('No Customers');
                                }
                                return ListView.separated(
                                  padding: const EdgeInsets.all(18),
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: model.data!.length,
                                  itemBuilder: (context, index) {
                                    var customer = model.data![index];
                                    return CustomerCard(
                                      customer: customer,
                                      archiveCustomer: () {
                                        model.archiveCustomer(customer.id);
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      child: Divider(
                                        thickness: 0.4,
                                      ),
                                    );
                                  },
                                );
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class CustomerCard extends StatelessWidget {
  CustomerCard({
    Key? key,
    required this.customer,
    required this.archiveCustomer,
  }) : super(key: key);
  final navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Customers customer;
  final Function archiveCustomer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        customer.name,
        style: ktsBodyTextBoldOpaque,
      ),
      subtitle: Text(
        customer.email,
        style: ktsBodyTextLight,
        // overflow: TextOverflow.values,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: (() {
              navigationService.navigateToViewCustomerRoute(
                  selectedCustomer: customer);
            }),
          ),
          IconButton(
              onPressed: () async {
                final DialogResponse? response =
                    await _dialogService.showConfirmationDialog(
                        dialogPlatform: DialogPlatform.Cupertino,
                        title: 'Archive Customer',
                        description:
                            'Are you sure you want to archive this customer?',
                        barrierDismissible: true,
                        cancelTitle: 'Cancel',
                        confirmationTitle: 'Ok');
                if (response?.confirmed == true) {
// Call the archiveExpense function
                  archiveCustomer();
                }
              },
              icon: const Icon(
                Icons.archive,
                size: 24,
              )),
        ],
      ),
    );
  }
}
