import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/ui/select_tags/select_tags_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

final chipList = [
  'Agriculture',
  'Education',
  'Accounting',
  'Food & Drinks',
  'Pharmacy',
  'Airline'
];

class SelectTagsView extends StatefulWidget {
  final bool busy;

  const SelectTagsView({Key? key, this.busy = false}) : super(key: key);

  @override
  _SelectTagsViewState createState() => _SelectTagsViewState();
}

class _SelectTagsViewState extends State<SelectTagsView> {
  final List<String> _selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    for (var i = 0; i < chipList.length; i++) {
      final item = chipList[i];
      final isSelected = _selectedChoices.contains(item);

      tiles.add(
        ChoiceChip(
          label: Text(item),
          labelStyle: isSelected ? ktsButtonText : ktsBodyText,
          selected: isSelected,
          selectedColor: isSelected ? kcPrimaryColor : kcTextColor,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedChoices.add(item);
              } else {
                _selectedChoices.remove(item);
              }
            });
          },
        ),
      );
    }
    return ViewModelBuilder<SelectTagsViewModel>.reactive(
      viewModelBuilder: () => SelectTagsViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, Widget? child) => Scaffold(
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
              Text('Select Tags', //title
                  style: ktsHeaderText),
              verticalSpaceSmall,
              Text(
                  'Please select at least 2 tags that relate to your business', //subtitle
                  style: ktsParagraphText),
              verticalSpaceRegular,
              Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  direction: Axis.horizontal,
                  children: tiles),
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
                  child: widget.busy
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
