import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_viewmodel.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

class BusinessProfileCreationView extends StatelessWidget {
  final bool busy;

  const BusinessProfileCreationView({Key? key, this.busy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessProfileCreationViewModel>.reactive(
      viewModelBuilder: () => BusinessProfileCreationViewModel(),
      onModelReady: (model) => () {},
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
                onPressed: () {},
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
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Business location',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter email',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Contact persons name',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Contact persons phone number',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLines: 4,
                      maxLength: 200,
                      decoration: InputDecoration(
                          hintText: 'Write a short description about ',
                          labelText:
                              'Write a short description about your business',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                    ),
                  ],
                ),
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
                          'Next',
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
