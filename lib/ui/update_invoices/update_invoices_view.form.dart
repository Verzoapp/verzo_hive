// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CustomerIdValueKey = 'customerId';
const String DueDateValueKey = 'dueDate';
const String DateOfIssueValueKey = 'dateOfIssue';
const String VatValueKey = 'vat';
const String DiscountValueKey = 'discount';

final Map<String, TextEditingController>
    _UpdateInvoicesViewTextEditingControllers = {};

final Map<String, FocusNode> _UpdateInvoicesViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _UpdateInvoicesViewTextValidations = {
  CustomerIdValueKey: null,
  DueDateValueKey: null,
  DateOfIssueValueKey: null,
  VatValueKey: null,
  DiscountValueKey: null,
};

mixin $UpdateInvoicesView on StatelessWidget {
  TextEditingController get customerIdController =>
      _getFormTextEditingController(CustomerIdValueKey);
  TextEditingController get dueDateController =>
      _getFormTextEditingController(DueDateValueKey);
  TextEditingController get dateOfIssueController =>
      _getFormTextEditingController(DateOfIssueValueKey);
  TextEditingController get VATController =>
      _getFormTextEditingController(VatValueKey, initialValue: '0.00');
  TextEditingController get discountController =>
      _getFormTextEditingController(DiscountValueKey, initialValue: '0.00');
  FocusNode get customerIdFocusNode => _getFormFocusNode(CustomerIdValueKey);
  FocusNode get dueDateFocusNode => _getFormFocusNode(DueDateValueKey);
  FocusNode get dateOfIssueFocusNode => _getFormFocusNode(DateOfIssueValueKey);
  FocusNode get VATFocusNode => _getFormFocusNode(VatValueKey);
  FocusNode get discountFocusNode => _getFormFocusNode(DiscountValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_UpdateInvoicesViewTextEditingControllers.containsKey(key)) {
      return _UpdateInvoicesViewTextEditingControllers[key]!;
    }
    _UpdateInvoicesViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _UpdateInvoicesViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_UpdateInvoicesViewFocusNodes.containsKey(key)) {
      return _UpdateInvoicesViewFocusNodes[key]!;
    }
    _UpdateInvoicesViewFocusNodes[key] = FocusNode();
    return _UpdateInvoicesViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    customerIdController.addListener(() => _updateFormData(model));
    dueDateController.addListener(() => _updateFormData(model));
    dateOfIssueController.addListener(() => _updateFormData(model));
    VATController.addListener(() => _updateFormData(model));
    discountController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    customerIdController.addListener(() => _updateFormData(model));
    dueDateController.addListener(() => _updateFormData(model));
    dateOfIssueController.addListener(() => _updateFormData(model));
    VATController.addListener(() => _updateFormData(model));
    discountController.addListener(() => _updateFormData(model));
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
          CustomerIdValueKey: customerIdController.text,
          DueDateValueKey: dueDateController.text,
          DateOfIssueValueKey: dateOfIssueController.text,
          VatValueKey: VATController.text,
          DiscountValueKey: discountController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        CustomerIdValueKey: _getValidationMessage(CustomerIdValueKey),
        DueDateValueKey: _getValidationMessage(DueDateValueKey),
        DateOfIssueValueKey: _getValidationMessage(DateOfIssueValueKey),
        VatValueKey: _getValidationMessage(VatValueKey),
        DiscountValueKey: _getValidationMessage(DiscountValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _UpdateInvoicesViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_UpdateInvoicesViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _UpdateInvoicesViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _UpdateInvoicesViewFocusNodes.values) {
      focusNode.dispose();
    }

    _UpdateInvoicesViewTextEditingControllers.clear();
    _UpdateInvoicesViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get customerIdValue =>
      this.formValueMap[CustomerIdValueKey] as String?;
  String? get dueDateValue => this.formValueMap[DueDateValueKey] as String?;
  String? get dateOfIssueValue =>
      this.formValueMap[DateOfIssueValueKey] as String?;
  String? get vatValue => this.formValueMap[VatValueKey] as String?;
  String? get discountValue => this.formValueMap[DiscountValueKey] as String?;

  bool get hasCustomerId =>
      this.formValueMap.containsKey(CustomerIdValueKey) &&
      (customerIdValue?.isNotEmpty ?? false);
  bool get hasDueDate =>
      this.formValueMap.containsKey(DueDateValueKey) &&
      (dueDateValue?.isNotEmpty ?? false);
  bool get hasDateOfIssue =>
      this.formValueMap.containsKey(DateOfIssueValueKey) &&
      (dateOfIssueValue?.isNotEmpty ?? false);
  bool get hasVat =>
      this.formValueMap.containsKey(VatValueKey) &&
      (vatValue?.isNotEmpty ?? false);
  bool get hasDiscount =>
      this.formValueMap.containsKey(DiscountValueKey) &&
      (discountValue?.isNotEmpty ?? false);

  bool get hasCustomerIdValidationMessage =>
      this.fieldsValidationMessages[CustomerIdValueKey]?.isNotEmpty ?? false;
  bool get hasDueDateValidationMessage =>
      this.fieldsValidationMessages[DueDateValueKey]?.isNotEmpty ?? false;
  bool get hasDateOfIssueValidationMessage =>
      this.fieldsValidationMessages[DateOfIssueValueKey]?.isNotEmpty ?? false;
  bool get hasVatValidationMessage =>
      this.fieldsValidationMessages[VatValueKey]?.isNotEmpty ?? false;
  bool get hasDiscountValidationMessage =>
      this.fieldsValidationMessages[DiscountValueKey]?.isNotEmpty ?? false;

  String? get customerIdValidationMessage =>
      this.fieldsValidationMessages[CustomerIdValueKey];
  String? get dueDateValidationMessage =>
      this.fieldsValidationMessages[DueDateValueKey];
  String? get dateOfIssueValidationMessage =>
      this.fieldsValidationMessages[DateOfIssueValueKey];
  String? get vatValidationMessage =>
      this.fieldsValidationMessages[VatValueKey];
  String? get discountValidationMessage =>
      this.fieldsValidationMessages[DiscountValueKey];
}

extension Methods on FormViewModel {
  setCustomerIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CustomerIdValueKey] = validationMessage;
  setDueDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DueDateValueKey] = validationMessage;
  setDateOfIssueValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DateOfIssueValueKey] = validationMessage;
  setVatValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[VatValueKey] = validationMessage;
  setDiscountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DiscountValueKey] = validationMessage;
}
