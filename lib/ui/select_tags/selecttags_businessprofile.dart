import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.form.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_viewmodel.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'businessName'),
  FormTextField(name: 'businessEmail'),
  FormTextField(name: 'businessMobile'),
  FormTextField(name: 'businessCategoryId'),
])
class BusinessProfileCreationView extends StatelessWidget
    with $BusinessProfileCreationView {
  final bool busy;

  BusinessProfileCreationView({
    Key? key,
    this.busy = false,
  }) : super(key: key);

  String? _selectedChoice;
  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    for (var i = 0; i < chipList.length; i++) {
      final item = chipList[i];
      final isSelected = _selectedChoice == item;
    }
    return ViewModelBuilder<BusinessProfileCreationViewModel>.reactive(
      viewModelBuilder: () => BusinessProfileCreationViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ListView(
            children: [
              verticalSpaceTiny,
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: kcTextColor,
                ),
                onPressed: model.navigateBack,
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/verzo_logo.svg',
                    width: 102,
                    height: 21,
                  )
                ],
              ),
              verticalSpaceRegular,
              Text('Business Profile', //title
                  style: ktsHeaderText),
              verticalSpaceSmall,
              Text(
                  'Please fill the form below to create a business profile', //subtitle
                  style: ktsParagraphText),
              verticalSpaceRegular,
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter business name',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      controller: businessNameController,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter email',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      controller: businessEmailController,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter phone number',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      controller: businessMobileController,
                    ),
                    verticalSpaceRegular,
                    Text(
                        'Select a category that relates to your business', //subtitle
                        style: ktsParagraphText),
                    verticalSpaceSmall,
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      direction: Axis.horizontal,
                      children: chipList
                          .map((businessCategory) => ChoiceChip(
                                label: Text(businessCategory),
                                labelStyle: _selectedChoice == businessCategory
                                    ? ktsButtonText
                                    : ktsBodyText,
                                selected: _selectedChoice == businessCategory,
                                selectedColor:
                                    _selectedChoice == businessCategory
                                        ? kcPrimaryColor
                                        : kcTextColor,
                                onSelected: (isSelected) {
                                  _selectedChoice =
                                      isSelected ? businessCategory : null;
                                  businessCategoryIdController.text =
                                      isSelected ? businessCategory : '';
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              verticalSpaceRegular,
              GestureDetector(
                onTap: () {},
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
                          'Create Business',
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

final chipList = [
  'Agriculture',
  'Education',
  'Accounting',
  'Food & Drinks',
  'Pharmacy',
  'Airline',
];
