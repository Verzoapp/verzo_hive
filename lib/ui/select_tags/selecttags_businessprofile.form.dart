// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String BusinessNameValueKey = 'businessName';
const String BusinessEmailValueKey = 'businessEmail';
const String BusinessMobileValueKey = 'businessMobile';
const String BusinessCategoryIdValueKey = 'businessCategoryId';

final Map<String, TextEditingController>
    _BusinessProfileCreationViewTextEditingControllers = {};

final Map<String, FocusNode> _BusinessProfileCreationViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _BusinessProfileCreationViewTextValidations = {
  BusinessNameValueKey: null,
  BusinessEmailValueKey: null,
  BusinessMobileValueKey: null,
  BusinessCategoryIdValueKey: null,
};

mixin $BusinessProfileCreationView on StatelessWidget {
  TextEditingController get businessNameController =>
      _getFormTextEditingController(BusinessNameValueKey);
  TextEditingController get businessEmailController =>
      _getFormTextEditingController(BusinessEmailValueKey);
  TextEditingController get businessMobileController =>
      _getFormTextEditingController(BusinessMobileValueKey);
  TextEditingController get businessCategoryIdController =>
      _getFormTextEditingController(BusinessCategoryIdValueKey);
  FocusNode get businessNameFocusNode =>
      _getFormFocusNode(BusinessNameValueKey);
  FocusNode get businessEmailFocusNode =>
      _getFormFocusNode(BusinessEmailValueKey);
  FocusNode get businessMobileFocusNode =>
      _getFormFocusNode(BusinessMobileValueKey);
  FocusNode get businessCategoryIdFocusNode =>
      _getFormFocusNode(BusinessCategoryIdValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_BusinessProfileCreationViewTextEditingControllers.containsKey(key)) {
      return _BusinessProfileCreationViewTextEditingControllers[key]!;
    }
    _BusinessProfileCreationViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _BusinessProfileCreationViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_BusinessProfileCreationViewFocusNodes.containsKey(key)) {
      return _BusinessProfileCreationViewFocusNodes[key]!;
    }
    _BusinessProfileCreationViewFocusNodes[key] = FocusNode();
    return _BusinessProfileCreationViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    businessNameController.addListener(() => _updateFormData(model));
    businessEmailController.addListener(() => _updateFormData(model));
    businessMobileController.addListener(() => _updateFormData(model));
    businessCategoryIdController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    businessNameController.addListener(() => _updateFormData(model));
    businessEmailController.addListener(() => _updateFormData(model));
    businessMobileController.addListener(() => _updateFormData(model));
    businessCategoryIdController.addListener(() => _updateFormData(model));
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
          BusinessNameValueKey: businessNameController.text,
          BusinessEmailValueKey: businessEmailController.text,
          BusinessMobileValueKey: businessMobileController.text,
          BusinessCategoryIdValueKey: businessCategoryIdController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        BusinessNameValueKey: _getValidationMessage(BusinessNameValueKey),
        BusinessEmailValueKey: _getValidationMessage(BusinessEmailValueKey),
        BusinessMobileValueKey: _getValidationMessage(BusinessMobileValueKey),
        BusinessCategoryIdValueKey:
            _getValidationMessage(BusinessCategoryIdValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _BusinessProfileCreationViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _BusinessProfileCreationViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _BusinessProfileCreationViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _BusinessProfileCreationViewFocusNodes.values) {
      focusNode.dispose();
    }

    _BusinessProfileCreationViewTextEditingControllers.clear();
    _BusinessProfileCreationViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get businessNameValue =>
      this.formValueMap[BusinessNameValueKey] as String?;
  String? get businessEmailValue =>
      this.formValueMap[BusinessEmailValueKey] as String?;
  String? get businessMobileValue =>
      this.formValueMap[BusinessMobileValueKey] as String?;
  String? get businessCategoryIdValue =>
      this.formValueMap[BusinessCategoryIdValueKey] as String?;

  bool get hasBusinessName =>
      this.formValueMap.containsKey(BusinessNameValueKey) &&
      (businessNameValue?.isNotEmpty ?? false);
  bool get hasBusinessEmail =>
      this.formValueMap.containsKey(BusinessEmailValueKey) &&
      (businessEmailValue?.isNotEmpty ?? false);
  bool get hasBusinessMobile =>
      this.formValueMap.containsKey(BusinessMobileValueKey) &&
      (businessMobileValue?.isNotEmpty ?? false);
  bool get hasBusinessCategoryId =>
      this.formValueMap.containsKey(BusinessCategoryIdValueKey) &&
      (businessCategoryIdValue?.isNotEmpty ?? false);

  bool get hasBusinessNameValidationMessage =>
      this.fieldsValidationMessages[BusinessNameValueKey]?.isNotEmpty ?? false;
  bool get hasBusinessEmailValidationMessage =>
      this.fieldsValidationMessages[BusinessEmailValueKey]?.isNotEmpty ?? false;
  bool get hasBusinessMobileValidationMessage =>
      this.fieldsValidationMessages[BusinessMobileValueKey]?.isNotEmpty ??
      false;
  bool get hasBusinessCategoryIdValidationMessage =>
      this.fieldsValidationMessages[BusinessCategoryIdValueKey]?.isNotEmpty ??
      false;

  String? get businessNameValidationMessage =>
      this.fieldsValidationMessages[BusinessNameValueKey];
  String? get businessEmailValidationMessage =>
      this.fieldsValidationMessages[BusinessEmailValueKey];
  String? get businessMobileValidationMessage =>
      this.fieldsValidationMessages[BusinessMobileValueKey];
  String? get businessCategoryIdValidationMessage =>
      this.fieldsValidationMessages[BusinessCategoryIdValueKey];
}

extension Methods on FormViewModel {
  setBusinessNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BusinessNameValueKey] = validationMessage;
  setBusinessEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BusinessEmailValueKey] = validationMessage;
  setBusinessMobileValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BusinessMobileValueKey] = validationMessage;
  setBusinessCategoryIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BusinessCategoryIdValueKey] =
          validationMessage;
}
