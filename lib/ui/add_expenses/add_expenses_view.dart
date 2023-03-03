import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/enums/bottomsheet_type.dart';
import 'package:verzo_one/ui/add_expenses/add_expenses_view_model.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';

import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class AddExpensesView extends StatelessWidget {
  final bool busy;
  const AddExpensesView({Key? key, this.busy = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddExpensesViewModel>.reactive(
      viewModelBuilder: () => AddExpensesViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, child) => Scaffold(
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
                  icon: Icon(Icons.receipt_long), label: 'Invoicing')
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ListView(
            children: [
              verticalSpaceTiny,
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: kcTextColor,
                ),
              ),
              verticalSpaceIntermitent,
              Text(
                'Add Expenses',
                style: ktsHeaderText,
              ),
              verticalSpaceMedium,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLines: 4,
                    decoration: InputDecoration(
                        labelText: 'Expense description',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.name,
                  ),
                  verticalSpaceSmall,
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    items: <String>[
                      'Agriculture',
                      'Education',
                      'Accounting',
                      'Airline'
                    ].map<DropdownMenuItem<String>>((String list) {
                      return DropdownMenuItem<String>(
                        value: list,
                        child: Text(
                          list,
                          style: ktsBodyText,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    inputFormatters: [CurrencyTextInputFormatter(symbol: '₦')],
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.number,
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );
                    },
                  ),
                ],
              ),
              verticalSpaceRegular,
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: defaultBorderRadius,
                    color: kcPrimaryColor,
                  ),
                  child: busy
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : Text(
                          'Add',
                          style: ktsButtonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
