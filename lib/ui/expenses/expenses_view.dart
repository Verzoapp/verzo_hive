import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/expenses/expenses_view_model.dart';
import 'package:verzo_one/ui/invoicing/invoicing_view.dart';
import 'package:verzo_one/ui/sales/sales_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:verzo_one/ui/update_expenses/update_expenses_view_model.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final navigationService = locator<NavigationService>();

  int selectedPageIndex = 2;
  void onHomeTapped() {
    setState(() {
      selectedPageIndex = 0;
    });
    navigationService.replaceWith(Routes.dashboardRoute);
  }

  void onSalesTapped() {
    setState(() {
      selectedPageIndex = 1;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalesView()),
    );
  }

  void onExpensesTapped() {
    setState(() {
      selectedPageIndex = 2;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpensesView()),
    );
  }

  void onInvoicingTapped() {
    setState(() {
      selectedPageIndex = 3;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InvoicesView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpensesViewModel>.reactive(
        viewModelBuilder: () => ExpensesViewModel(),
        onModelReady: (model) async {
          model.addNewExpense;
          model.archiveExpense;
        },
        builder: (context, model, child) {
          if (model.isBusy) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kcPrimaryColor,
              onPressed: () {
                navigationService.navigateTo(Routes.addExpenseRoute);
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                fixedColor: kcPrimaryColor,
                iconSize: 24,
                showUnselectedLabels: true,
                unselectedItemColor: kcTextColorLight,
                currentIndex: selectedPageIndex,
                onTap: (index) {
                  if (index == 0) {
                    onHomeTapped();
                  } else if (index == 1) {
                    onSalesTapped();
                  } else if (index == 3) {
                    onInvoicingTapped();
                  }
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sell), label: 'Sales'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: 'Expenses'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.receipt_long), label: 'Incoicing')
                ]),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Expenses',
                        style: ktsHeaderText,
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  // if (model.expenses.isEmpty)
                  //   const Text('No Expense')
                  // else
                  //   ListView.separated(
                  //     scrollDirection: Axis.vertical,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     primary: true,
                  //     shrinkWrap: true,
                  //     itemCount: model.expenses.length + (model.isBusy ? 1 : 0),
                  //     itemBuilder: (context, index) {
                  //       if (index == model.expenses.length) {
                  //         return const CircularProgressIndicator();
                  //       } else {
                  //         return ExpenseCard(
                  //           expenses: model.expenses[index]!,
                  //           archiveExpense: () {
                  //             model.archiveExpense(model.expenses[index].id);
                  //           },
                  //           expenseId: model.expenses[index].id,
                  //         );
                  //       }
                  //     },
                  //     separatorBuilder: (BuildContext context, int index) {
                  //       return verticalSpaceTiny;
                  //     },
                  //   ),
                  if (model.data == null)
                    const Text('No Expense')
                  else
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        var expense = model.data![index];
                        if (index == model.data!.length) {
                          return const CircularProgressIndicator();
                        } else {
                          return ExpenseCard(
                            expenses: expense,
                            archiveExpense: () {
                              model.archiveExpense(expense.id);
                            },
                            expenseId: expense.id,
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            // verticalSpaceTiny,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Divider(
                                thickness: 0.4,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        });
  }
}

class ExpenseCard extends StatelessWidget {
  ExpenseCard({
    Key? key,
    required this.expenses,
    required this.archiveExpense,
    required this.expenseId,
  }) : super(key: key);
  final navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Expenses expenses;
  final String expenseId;

  final Function archiveExpense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: defaultTagBorderRadius),
      // tileColor: kcStrokeColor,
      title: Text(
        expenses.description,
        style: ktsBodyText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        expenses.expenseDate,
        style: ktsBodyTextLight,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            NumberFormat.currency(locale: 'en', symbol: '\N')
                .format(expenses.amount),
            style: ktsBodyText,
          ),
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: (() {
              navigationService.navigateToViewExpenseRoute(
                  selectedExpense: expenses);
            }),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 20,
            ),
            onPressed: (() {
              navigationService.navigateToUpdateExpenseRoute(
                  selectedExpense: expenses);
            }),
          ),
          IconButton(
              onPressed: () async {
                final DialogResponse? response =
                    await _dialogService.showConfirmationDialog(
                        dialogPlatform: DialogPlatform.Cupertino,
                        title: 'Archive Expense',
                        description:
                            'Are you sure you want to archive this expense?',
                        barrierDismissible: true,
                        cancelTitle: 'Cancel',
                        confirmationTitle: 'Ok');
                if (response?.confirmed == true) {
// Call the archiveExpense function
                  archiveExpense();
                }
              },
              icon: const Icon(
                Icons.archive,
                size: 20,
              ))
        ],
      ),
    );
  }
}

// Text(
//                     expenses.description,
//                     style: ktsBodyText,
//                   ),
//                   Text(
//                     'expenses.createdAt',
//                     style: ktsBodyTextLight,
//                   ),
//                 ],
//               ),
//               Text(
//                 NumberFormat.currency(locale: 'en_NG', symbol: '\$')
//                     .format(expenses.amount),
//                 style: ktsBodyText,
//               )
