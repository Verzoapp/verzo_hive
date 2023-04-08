// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String DescriptionValueKey = 'description';
const String AmountValueKey = 'amount';
const String ExpenseCategoryIdValueKey = 'expenseCategoryId';
const String ExpenseDateValueKey = 'expenseDate';
const String MerchantIdValueKey = 'merchantId';

final Map<String, TextEditingController>
    _AddExpensesViewTextEditingControllers = {};

final Map<String, FocusNode> _AddExpensesViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddExpensesViewTextValidations =
    {
  DescriptionValueKey: null,
  AmountValueKey: null,
  ExpenseCategoryIdValueKey: null,
  ExpenseDateValueKey: null,
  MerchantIdValueKey: null,
};

mixin $AddExpensesView on StatelessWidget {
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);
  TextEditingController get amountController =>
      _getFormTextEditingController(AmountValueKey);
  TextEditingController get expenseCategoryIdController =>
      _getFormTextEditingController(ExpenseCategoryIdValueKey);
  TextEditingController get expenseDateController =>
      _getFormTextEditingController(ExpenseDateValueKey);
  TextEditingController get merchantIdController =>
      _getFormTextEditingController(MerchantIdValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);
  FocusNode get amountFocusNode => _getFormFocusNode(AmountValueKey);
  FocusNode get expenseCategoryIdFocusNode =>
      _getFormFocusNode(ExpenseCategoryIdValueKey);
  FocusNode get expenseDateFocusNode => _getFormFocusNode(ExpenseDateValueKey);
  FocusNode get merchantIdFocusNode => _getFormFocusNode(MerchantIdValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_AddExpensesViewTextEditingControllers.containsKey(key)) {
      return _AddExpensesViewTextEditingControllers[key]!;
    }
    _AddExpensesViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddExpensesViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddExpensesViewFocusNodes.containsKey(key)) {
      return _AddExpensesViewFocusNodes[key]!;
    }
    _AddExpensesViewFocusNodes[key] = FocusNode();
    return _AddExpensesViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    descriptionController.addListener(() => _updateFormData(model));
    amountController.addListener(() => _updateFormData(model));
    expenseCategoryIdController.addListener(() => _updateFormData(model));
    expenseDateController.addListener(() => _updateFormData(model));
    merchantIdController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    descriptionController.addListener(() => _updateFormData(model));
    amountController.addListener(() => _updateFormData(model));
    expenseCategoryIdController.addListener(() => _updateFormData(model));
    expenseDateController.addListener(() => _updateFormData(model));
    merchantIdController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          DescriptionValueKey: descriptionController.text,
          AmountValueKey: amountController.text,
          ExpenseCategoryIdValueKey: expenseCategoryIdController.text,
          ExpenseDateValueKey: expenseDateController.text,
          MerchantIdValueKey: merchantIdController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        DescriptionValueKey: _getValidationMessage(DescriptionValueKey),
        AmountValueKey: _getValidationMessage(AmountValueKey),
        ExpenseCategoryIdValueKey:
            _getValidationMessage(ExpenseCategoryIdValueKey),
        ExpenseDateValueKey: _getValidationMessage(ExpenseDateValueKey),
        MerchantIdValueKey: _getValidationMessage(MerchantIdValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _AddExpensesViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_AddExpensesViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddExpensesViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddExpensesViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddExpensesViewTextEditingControllers.clear();
    _AddExpensesViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get descriptionValue =>
      this.formValueMap[DescriptionValueKey] as String?;
  String? get amountValue => this.formValueMap[AmountValueKey] as String?;
  String? get expenseCategoryIdValue =>
      this.formValueMap[ExpenseCategoryIdValueKey] as String?;
  String? get expenseDateValue =>
      this.formValueMap[ExpenseDateValueKey] as String?;
  String? get merchantIdValue =>
      this.formValueMap[MerchantIdValueKey] as String?;

  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);
  bool get hasAmount =>
      this.formValueMap.containsKey(AmountValueKey) &&
      (amountValue?.isNotEmpty ?? false);
  bool get hasExpenseCategoryId =>
      this.formValueMap.containsKey(ExpenseCategoryIdValueKey) &&
      (expenseCategoryIdValue?.isNotEmpty ?? false);
  bool get hasExpenseDate =>
      this.formValueMap.containsKey(ExpenseDateValueKey) &&
      (expenseDateValue?.isNotEmpty ?? false);
  bool get hasMerchantId =>
      this.formValueMap.containsKey(MerchantIdValueKey) &&
      (merchantIdValue?.isNotEmpty ?? false);

  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;
  bool get hasAmountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey]?.isNotEmpty ?? false;
  bool get hasExpenseCategoryIdValidationMessage =>
      this.fieldsValidationMessages[ExpenseCategoryIdValueKey]?.isNotEmpty ??
      false;
  bool get hasExpenseDateValidationMessage =>
      this.fieldsValidationMessages[ExpenseDateValueKey]?.isNotEmpty ?? false;
  bool get hasMerchantIdValidationMessage =>
      this.fieldsValidationMessages[MerchantIdValueKey]?.isNotEmpty ?? false;

  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
  String? get amountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey];
  String? get expenseCategoryIdValidationMessage =>
      this.fieldsValidationMessages[ExpenseCategoryIdValueKey];
  String? get expenseDateValidationMessage =>
      this.fieldsValidationMessages[ExpenseDateValueKey];
  String? get merchantIdValidationMessage =>
      this.fieldsValidationMessages[MerchantIdValueKey];
}

extension Methods on FormViewModel {
  setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;
  setAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AmountValueKey] = validationMessage;
  setExpenseCategoryIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ExpenseCategoryIdValueKey] =
          validationMessage;
  setExpenseDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ExpenseDateValueKey] = validationMessage;
  setMerchantIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MerchantIdValueKey] = validationMessage;
}
