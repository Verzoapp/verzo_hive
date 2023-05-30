// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String UpdateDescriptionValueKey = 'updateDescription';
const String UpdateAmountValueKey = 'updateAmount';
const String UpdateExpenseCategoryIdValueKey = 'updateExpenseCategoryId';
const String UpdateExpenseDateValueKey = 'updateExpenseDate';
const String UpdateMerchantIdValueKey = 'updateMerchantId';

final Map<String, TextEditingController>
    _UpdateExpensesViewTextEditingControllers = {};

final Map<String, FocusNode> _UpdateExpensesViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _UpdateExpensesViewTextValidations = {
  UpdateDescriptionValueKey: null,
  UpdateAmountValueKey: null,
  UpdateExpenseCategoryIdValueKey: null,
  UpdateExpenseDateValueKey: null,
  UpdateMerchantIdValueKey: null,
};

mixin $UpdateExpensesView on StatelessWidget {
  TextEditingController get updateDescriptionController =>
      _getFormTextEditingController(UpdateDescriptionValueKey);
  TextEditingController get updateAmountController =>
      _getFormTextEditingController(UpdateAmountValueKey);
  TextEditingController get updateExpenseCategoryIdController =>
      _getFormTextEditingController(UpdateExpenseCategoryIdValueKey);
  TextEditingController get updateExpenseDateController =>
      _getFormTextEditingController(UpdateExpenseDateValueKey);
  TextEditingController get updateMerchantIdController =>
      _getFormTextEditingController(UpdateMerchantIdValueKey);
  FocusNode get updateDescriptionFocusNode =>
      _getFormFocusNode(UpdateDescriptionValueKey);
  FocusNode get updateAmountFocusNode =>
      _getFormFocusNode(UpdateAmountValueKey);
  FocusNode get updateExpenseCategoryIdFocusNode =>
      _getFormFocusNode(UpdateExpenseCategoryIdValueKey);
  FocusNode get updateExpenseDateFocusNode =>
      _getFormFocusNode(UpdateExpenseDateValueKey);
  FocusNode get updateMerchantIdFocusNode =>
      _getFormFocusNode(UpdateMerchantIdValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_UpdateExpensesViewTextEditingControllers.containsKey(key)) {
      return _UpdateExpensesViewTextEditingControllers[key]!;
    }
    _UpdateExpensesViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _UpdateExpensesViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_UpdateExpensesViewFocusNodes.containsKey(key)) {
      return _UpdateExpensesViewFocusNodes[key]!;
    }
    _UpdateExpensesViewFocusNodes[key] = FocusNode();
    return _UpdateExpensesViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    updateDescriptionController.addListener(() => _updateFormData(model));
    updateAmountController.addListener(() => _updateFormData(model));
    updateExpenseCategoryIdController.addListener(() => _updateFormData(model));
    updateExpenseDateController.addListener(() => _updateFormData(model));
    updateMerchantIdController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    updateDescriptionController.addListener(() => _updateFormData(model));
    updateAmountController.addListener(() => _updateFormData(model));
    updateExpenseCategoryIdController.addListener(() => _updateFormData(model));
    updateExpenseDateController.addListener(() => _updateFormData(model));
    updateMerchantIdController.addListener(() => _updateFormData(model));
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
          UpdateDescriptionValueKey: updateDescriptionController.text,
          UpdateAmountValueKey: updateAmountController.text,
          UpdateExpenseCategoryIdValueKey:
              updateExpenseCategoryIdController.text,
          UpdateExpenseDateValueKey: updateExpenseDateController.text,
          UpdateMerchantIdValueKey: updateMerchantIdController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        UpdateDescriptionValueKey:
            _getValidationMessage(UpdateDescriptionValueKey),
        UpdateAmountValueKey: _getValidationMessage(UpdateAmountValueKey),
        UpdateExpenseCategoryIdValueKey:
            _getValidationMessage(UpdateExpenseCategoryIdValueKey),
        UpdateExpenseDateValueKey:
            _getValidationMessage(UpdateExpenseDateValueKey),
        UpdateMerchantIdValueKey:
            _getValidationMessage(UpdateMerchantIdValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _UpdateExpensesViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_UpdateExpensesViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _UpdateExpensesViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _UpdateExpensesViewFocusNodes.values) {
      focusNode.dispose();
    }

    _UpdateExpensesViewTextEditingControllers.clear();
    _UpdateExpensesViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get updateDescriptionValue =>
      this.formValueMap[UpdateDescriptionValueKey] as String?;
  String? get updateAmountValue =>
      this.formValueMap[UpdateAmountValueKey] as String?;
  String? get updateExpenseCategoryIdValue =>
      this.formValueMap[UpdateExpenseCategoryIdValueKey] as String?;
  String? get updateExpenseDateValue =>
      this.formValueMap[UpdateExpenseDateValueKey] as String?;
  String? get updateMerchantIdValue =>
      this.formValueMap[UpdateMerchantIdValueKey] as String?;

  bool get hasUpdateDescription =>
      this.formValueMap.containsKey(UpdateDescriptionValueKey) &&
      (updateDescriptionValue?.isNotEmpty ?? false);
  bool get hasUpdateAmount =>
      this.formValueMap.containsKey(UpdateAmountValueKey) &&
      (updateAmountValue?.isNotEmpty ?? false);
  bool get hasUpdateExpenseCategoryId =>
      this.formValueMap.containsKey(UpdateExpenseCategoryIdValueKey) &&
      (updateExpenseCategoryIdValue?.isNotEmpty ?? false);
  bool get hasUpdateExpenseDate =>
      this.formValueMap.containsKey(UpdateExpenseDateValueKey) &&
      (updateExpenseDateValue?.isNotEmpty ?? false);
  bool get hasUpdateMerchantId =>
      this.formValueMap.containsKey(UpdateMerchantIdValueKey) &&
      (updateMerchantIdValue?.isNotEmpty ?? false);

  bool get hasUpdateDescriptionValidationMessage =>
      this.fieldsValidationMessages[UpdateDescriptionValueKey]?.isNotEmpty ??
      false;
  bool get hasUpdateAmountValidationMessage =>
      this.fieldsValidationMessages[UpdateAmountValueKey]?.isNotEmpty ?? false;
  bool get hasUpdateExpenseCategoryIdValidationMessage =>
      this
          .fieldsValidationMessages[UpdateExpenseCategoryIdValueKey]
          ?.isNotEmpty ??
      false;
  bool get hasUpdateExpenseDateValidationMessage =>
      this.fieldsValidationMessages[UpdateExpenseDateValueKey]?.isNotEmpty ??
      false;
  bool get hasUpdateMerchantIdValidationMessage =>
      this.fieldsValidationMessages[UpdateMerchantIdValueKey]?.isNotEmpty ??
      false;

  String? get updateDescriptionValidationMessage =>
      this.fieldsValidationMessages[UpdateDescriptionValueKey];
  String? get updateAmountValidationMessage =>
      this.fieldsValidationMessages[UpdateAmountValueKey];
  String? get updateExpenseCategoryIdValidationMessage =>
      this.fieldsValidationMessages[UpdateExpenseCategoryIdValueKey];
  String? get updateExpenseDateValidationMessage =>
      this.fieldsValidationMessages[UpdateExpenseDateValueKey];
  String? get updateMerchantIdValidationMessage =>
      this.fieldsValidationMessages[UpdateMerchantIdValueKey];
}

extension Methods on FormViewModel {
  setUpdateDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateDescriptionValueKey] =
          validationMessage;
  setUpdateAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateAmountValueKey] = validationMessage;
  setUpdateExpenseCategoryIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateExpenseCategoryIdValueKey] =
          validationMessage;
  setUpdateExpenseDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateExpenseDateValueKey] =
          validationMessage;
  setUpdateMerchantIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateMerchantIdValueKey] =
          validationMessage;
}
