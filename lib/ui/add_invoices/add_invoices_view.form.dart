// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CustomerIdValueKey = 'customerId';
const String ItemValueKey = 'item';

final Map<String, TextEditingController>
    _AddInvoicesViewTextEditingControllers = {};

final Map<String, FocusNode> _AddInvoicesViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddInvoicesViewTextValidations =
    {
  CustomerIdValueKey: null,
  ItemValueKey: null,
};

mixin $AddInvoicesView on StatelessWidget {
  TextEditingController get customerIdController =>
      _getFormTextEditingController(CustomerIdValueKey);
  TextEditingController get itemController =>
      _getFormTextEditingController(ItemValueKey);
  FocusNode get customerIdFocusNode => _getFormFocusNode(CustomerIdValueKey);
  FocusNode get itemFocusNode => _getFormFocusNode(ItemValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_AddInvoicesViewTextEditingControllers.containsKey(key)) {
      return _AddInvoicesViewTextEditingControllers[key]!;
    }
    _AddInvoicesViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddInvoicesViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddInvoicesViewFocusNodes.containsKey(key)) {
      return _AddInvoicesViewFocusNodes[key]!;
    }
    _AddInvoicesViewFocusNodes[key] = FocusNode();
    return _AddInvoicesViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    customerIdController.addListener(() => _updateFormData(model));
    itemController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    customerIdController.addListener(() => _updateFormData(model));
    itemController.addListener(() => _updateFormData(model));
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
          ItemValueKey: itemController.text,
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
        ItemValueKey: _getValidationMessage(ItemValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _AddInvoicesViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_AddInvoicesViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddInvoicesViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddInvoicesViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddInvoicesViewTextEditingControllers.clear();
    _AddInvoicesViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get customerIdValue =>
      this.formValueMap[CustomerIdValueKey] as String?;
  String? get itemValue => this.formValueMap[ItemValueKey] as String?;

  bool get hasCustomerId =>
      this.formValueMap.containsKey(CustomerIdValueKey) &&
      (customerIdValue?.isNotEmpty ?? false);
  bool get hasItem =>
      this.formValueMap.containsKey(ItemValueKey) &&
      (itemValue?.isNotEmpty ?? false);

  bool get hasCustomerIdValidationMessage =>
      this.fieldsValidationMessages[CustomerIdValueKey]?.isNotEmpty ?? false;
  bool get hasItemValidationMessage =>
      this.fieldsValidationMessages[ItemValueKey]?.isNotEmpty ?? false;

  String? get customerIdValidationMessage =>
      this.fieldsValidationMessages[CustomerIdValueKey];
  String? get itemValidationMessage =>
      this.fieldsValidationMessages[ItemValueKey];
}

extension Methods on FormViewModel {
  setCustomerIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CustomerIdValueKey] = validationMessage;
  setItemValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ItemValueKey] = validationMessage;
}
