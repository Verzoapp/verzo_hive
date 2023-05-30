// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String ProductNameValueKey = 'productName';
const String PriceValueKey = 'price';
const String BasicUnitValueKey = 'basicUnit';
const String QuantityInStockValueKey = 'quantityInStock';

final Map<String, TextEditingController> _AddItemViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AddItemViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddItemViewTextValidations = {
  ProductNameValueKey: null,
  PriceValueKey: null,
  BasicUnitValueKey: null,
  QuantityInStockValueKey: null,
};

mixin $AddItemView on StatelessWidget {
  TextEditingController get productNameController =>
      _getFormTextEditingController(ProductNameValueKey);
  TextEditingController get priceController =>
      _getFormTextEditingController(PriceValueKey);
  TextEditingController get basicUnitController =>
      _getFormTextEditingController(BasicUnitValueKey);
  TextEditingController get quantityInStockController =>
      _getFormTextEditingController(QuantityInStockValueKey);
  FocusNode get productNameFocusNode => _getFormFocusNode(ProductNameValueKey);
  FocusNode get priceFocusNode => _getFormFocusNode(PriceValueKey);
  FocusNode get basicUnitFocusNode => _getFormFocusNode(BasicUnitValueKey);
  FocusNode get quantityInStockFocusNode =>
      _getFormFocusNode(QuantityInStockValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_AddItemViewTextEditingControllers.containsKey(key)) {
      return _AddItemViewTextEditingControllers[key]!;
    }
    _AddItemViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddItemViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddItemViewFocusNodes.containsKey(key)) {
      return _AddItemViewFocusNodes[key]!;
    }
    _AddItemViewFocusNodes[key] = FocusNode();
    return _AddItemViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    productNameController.addListener(() => _updateFormData(model));
    priceController.addListener(() => _updateFormData(model));
    basicUnitController.addListener(() => _updateFormData(model));
    quantityInStockController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    productNameController.addListener(() => _updateFormData(model));
    priceController.addListener(() => _updateFormData(model));
    basicUnitController.addListener(() => _updateFormData(model));
    quantityInStockController.addListener(() => _updateFormData(model));
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
          ProductNameValueKey: productNameController.text,
          PriceValueKey: priceController.text,
          BasicUnitValueKey: basicUnitController.text,
          QuantityInStockValueKey: quantityInStockController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        ProductNameValueKey: _getValidationMessage(ProductNameValueKey),
        PriceValueKey: _getValidationMessage(PriceValueKey),
        BasicUnitValueKey: _getValidationMessage(BasicUnitValueKey),
        QuantityInStockValueKey: _getValidationMessage(QuantityInStockValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _AddItemViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_AddItemViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddItemViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddItemViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddItemViewTextEditingControllers.clear();
    _AddItemViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get productNameValue =>
      this.formValueMap[ProductNameValueKey] as String?;
  String? get priceValue => this.formValueMap[PriceValueKey] as String?;
  String? get basicUnitValue => this.formValueMap[BasicUnitValueKey] as String?;
  String? get quantityInStockValue =>
      this.formValueMap[QuantityInStockValueKey] as String?;

  bool get hasProductName =>
      this.formValueMap.containsKey(ProductNameValueKey) &&
      (productNameValue?.isNotEmpty ?? false);
  bool get hasPrice =>
      this.formValueMap.containsKey(PriceValueKey) &&
      (priceValue?.isNotEmpty ?? false);
  bool get hasBasicUnit =>
      this.formValueMap.containsKey(BasicUnitValueKey) &&
      (basicUnitValue?.isNotEmpty ?? false);
  bool get hasQuantityInStock =>
      this.formValueMap.containsKey(QuantityInStockValueKey) &&
      (quantityInStockValue?.isNotEmpty ?? false);

  bool get hasProductNameValidationMessage =>
      this.fieldsValidationMessages[ProductNameValueKey]?.isNotEmpty ?? false;
  bool get hasPriceValidationMessage =>
      this.fieldsValidationMessages[PriceValueKey]?.isNotEmpty ?? false;
  bool get hasBasicUnitValidationMessage =>
      this.fieldsValidationMessages[BasicUnitValueKey]?.isNotEmpty ?? false;
  bool get hasQuantityInStockValidationMessage =>
      this.fieldsValidationMessages[QuantityInStockValueKey]?.isNotEmpty ??
      false;

  String? get productNameValidationMessage =>
      this.fieldsValidationMessages[ProductNameValueKey];
  String? get priceValidationMessage =>
      this.fieldsValidationMessages[PriceValueKey];
  String? get basicUnitValidationMessage =>
      this.fieldsValidationMessages[BasicUnitValueKey];
  String? get quantityInStockValidationMessage =>
      this.fieldsValidationMessages[QuantityInStockValueKey];
}

extension Methods on FormViewModel {
  setProductNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ProductNameValueKey] = validationMessage;
  setPriceValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PriceValueKey] = validationMessage;
  setBasicUnitValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BasicUnitValueKey] = validationMessage;
  setQuantityInStockValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[QuantityInStockValueKey] =
          validationMessage;
}
