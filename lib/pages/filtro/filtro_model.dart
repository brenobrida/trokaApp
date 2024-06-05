import '/backend/api_requests/api_calls.dart';
import '/troka/troka_checkbox_group.dart';
import '/troka/troka_choice_chips.dart';
import '/troka/troka_drop_down.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/form_field_controller.dart';
import 'filtro_widget.dart' show FiltroWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FiltroModel extends trokaModel<FiltroWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // Stores action output result for [Backend Call - API (buscaCidade)] action in DropDown widget.
  ApiCallResponse? apiResultx2v;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for ObjectConditions widget.
  List<String>? objectConditionsValues;
  FormFieldController<List<String>>? objectConditionsValueController;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for ObjectCategoriesInterest widget.
  List<String>? objectCategoriesInterestValues;
  FormFieldController<List<String>>? objectCategoriesInterestValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
