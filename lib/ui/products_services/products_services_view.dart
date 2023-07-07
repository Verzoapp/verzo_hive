import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/customers/customers_view.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './products_services_view_model.dart';

class ProductsServicesView extends StatefulWidget {
  @override
  State<ProductsServicesView> createState() => _ProductsServicesViewState();
}

class _ProductsServicesViewState extends State<ProductsServicesView> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsServicesViewModel>.reactive(
      viewModelBuilder: () => ProductsServicesViewModel(),
      onModelReady: (model) async {
        model.getProductOrServiceByBusiness();
        model.addNewItem(model.newItem);
      },
      builder: (
        BuildContext context,
        ProductsServicesViewModel model,
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
                              'Products & Services',
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
                        top: 25,
                        bottom: 50,
                        left: 15,
                        right: 15,
                      ),
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
                                      .navigateTo(
                                          Routes.addProductsServicesRoute),
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
                                  return const Text('No Products or services');
                                }
                                return ListView.separated(
                                  padding: const EdgeInsets.all(18),
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: model.data!.length,
                                  itemBuilder: (context, index) {
                                    var items = model.data![index];
                                    return ItemCard(item: items);
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

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Items item;

  @override
  Widget build(BuildContext context) {
    IconData iconData;

    // Set the icon based on the item.type value
    if (item.type == 'P') {
      iconData = Icons.inventory;
    } else {
      iconData = Icons.handyman;
    }
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
            color: kcStrokeColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Icon(
            iconData,
            color: kcPrimaryColor,
            size: 20,
          ),
        ),
      ),
      title: Text(
        item.title,
        style: ktsBodyTextBoldOpaque,
      ),
      subtitle: Text(
        NumberFormat.currency(locale: 'en', symbol: 'N').format(item.price),
        style: ktsBodyTextBoldOpaque,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: (() {
              // navigationService.navigateToViewExpenseRoute(
              //     selectedExpense: expenses);
            }),
          ),
          IconButton(
            icon: const Icon(
              Icons.archive,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
