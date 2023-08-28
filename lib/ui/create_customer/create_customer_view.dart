import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view.form.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view_model.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_viewmodel.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'customerName'),
  FormTextField(name: 'mobile'),
  FormTextField(name: 'email'),
  FormTextField(name: 'address'),
])
class CreateCustomerView extends StatelessWidget with $CreateCustomerView {
  CreateCustomerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateCustomerViewModel>.reactive(
      viewModelBuilder: () => CreateCustomerViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: AuthenticationLayout(
          busy: model.isBusy,
          validationMessage: model.validationMessage,
          // onBackPressed: model.navigateBack,
          onMainButtonTapped: model.saveCustomerData,
          title: 'Create a Customer',
          subtitle: 'Pls fill the form to create a customer',
          mainButtonTitle: 'Add',
          form: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Customer name',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.name,
                controller: customerNameController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Customer mobile',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.number,
                controller: mobileController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Customer email',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Customer address (optional)',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.name,
                controller: addressController,
              ),
            ],
          ),
        ),
      ),
    );
    // Padding(
    //   padding: MediaQuery.of(context).viewInsets,
    //   child: Container(
    //     height: MediaQuery.of(context).size.height * 0.85,
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
    //     child: Column(
    //       children: [
    //         Text(
    //           "Create a Customer",
    //           style: ktsHeaderText,
    //         ),
    //         verticalSpaceSmall,
    //         Text(
    //           "Pls fill the form to create a customer",
    //           style: ktsParagraphText,
    //         ),
    //         verticalSpaceSmall,
    //         TextFormField(
    //           decoration: InputDecoration(
    //               labelText: 'Customer name',
    //               labelStyle: ktsFormText,
    //               border: defaultFormBorder),
    //           keyboardType: TextInputType.name,
    //           controller: customerNameController,
    //         ),
    //         verticalSpaceSmall,
    //         TextFormField(
    //           decoration: InputDecoration(
    //               labelText: 'Customer mobile',
    //               labelStyle: ktsFormText,
    //               border: defaultFormBorder),
    //           keyboardType: TextInputType.number,
    //           controller: mobileController,
    //         ),
    //         verticalSpaceSmall,
    //         TextFormField(
    //           decoration: InputDecoration(
    //               labelText: 'Customer email',
    //               labelStyle: ktsFormText,
    //               border: defaultFormBorder),
    //           keyboardType: TextInputType.emailAddress,
    //           controller: emailController,
    //         ),
    //         verticalSpaceSmall,
    //         TextFormField(
    //           decoration: InputDecoration(
    //               labelText: 'Customer address',
    //               labelStyle: ktsFormText,
    //               border: defaultFormBorder),
    //           keyboardType: TextInputType.name,
    //           controller: addressController,
    //         ),
    //         verticalSpaceIntermitent,
    //         GestureDetector(
    //           onTap: () {
    //             model.saveCustomerData();
    //             Navigator.pop(context);
    //           },
    //           child: Container(
    //             width: double.infinity,
    //             height: 50,
    //             alignment: Alignment.center,
    //             decoration: BoxDecoration(
    //               borderRadius: defaultBorderRadius,
    //               color: kcPrimaryColor,
    //             ),
    //             child: model.isBusy
    //                 ? const CircularProgressIndicator(
    //                     valueColor: AlwaysStoppedAnimation(Colors.white),
    //                   )
    //                 : Text(
    //                     "Create",
    //                     style: ktsButtonText,
    //                   ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
  }
}
