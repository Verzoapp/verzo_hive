import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/ui/expenses/expenses_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpensesViewModel>.reactive(
      viewModelBuilder: () => ExpensesViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, child) => Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kcPrimaryColor,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: kcPrimaryColor,
            iconSize: 24,
            showUnselectedLabels: true,
            unselectedItemColor: kcTextColorLight,
            currentIndex: 2,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sales'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Expenses'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long), label: 'Incoicing')
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ListView(
            children: [
              verticalSpaceTiny,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/verzo_logo.svg',
                    width: 102,
                    height: 21,
                  ),
                  const CircleAvatar(
                    backgroundColor: kcTextColorLight,
                    foregroundColor: kcButtonTextColor,
                    radius: 16,
                    child: Text('V'),
                  ),
                ],
              ),
              verticalSpaceRegular,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Expenses',
                    style: ktsHeaderText,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '-N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '-N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '-N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '-N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '-N200,000',
                              style: ktsBodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: kcButtonTextColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: defaultTagBorderRadius),
                      margin: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steven Summers',
                                  style: ktsBodyText,
                                ),
                                Text(
                                  '02 Minutes Ago',
                                  style: ktsBodyTextLight,
                                ),
                              ],
                            ),
                            Text(
                              '-N200,000',
                              style: ktsBodyText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
