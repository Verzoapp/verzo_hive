// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String BusinessIdValueKey = 'businessId';

final Map<String, TextEditingController>
    _CreateMerchantViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateMerchantViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CreateMerchantViewTextValidations = {
  NameValueKey: null,
  BusinessIdValueKey: null,
};

mixin $CreateMerchantView on StatelessWidget {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get businessIdController =>
      _getFormTextEditingController(BusinessIdValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get businessIdFocusNode => _getFormFocusNode(BusinessIdValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_CreateMerchantViewTextEditingControllers.containsKey(key)) {
      return _CreateMerchantViewTextEditingControllers[key]!;
    }
    _CreateMerchantViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateMerchantViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateMerchantViewFocusNodes.containsKey(key)) {
      return _CreateMerchantViewFocusNodes[key]!;
    }
    _CreateMerchantViewFocusNodes[key] = FocusNode();
    return _CreateMerchantViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    businessIdController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    businessIdController.addListener(() => _updateFormData(model));
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
          NameValueKey: nameController.text,
          BusinessIdValueKey: businessIdController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        NameValueKey: _getValidationMessage(NameValueKey),
        BusinessIdValueKey: _getValidationMessage(BusinessIdValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _CreateMerchantViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_CreateMerchantViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CreateMerchantViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateMerchantViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateMerchantViewTextEditingControllers.clear();
    _CreateMerchantViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get businessIdValue =>
      this.formValueMap[BusinessIdValueKey] as String?;

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasBusinessId =>
      this.formValueMap.containsKey(BusinessIdValueKey) &&
      (businessIdValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasBusinessIdValidationMessage =>
      this.fieldsValidationMessages[BusinessIdValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get businessIdValidationMessage =>
      this.fieldsValidationMessages[BusinessIdValueKey];
}

extension Methods on FormViewModel {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setBusinessIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BusinessIdValueKey] = validationMessage;
}
