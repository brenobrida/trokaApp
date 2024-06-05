import '/components/user_objects_collection_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'meus_objetos_widget.dart' show MeusObjetosWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MeusObjetosModel extends trokaModel<MeusObjetosWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for userObjectsCollection component.
  late UserObjectsCollectionModel userObjectsCollectionModel;

  @override
  void initState(BuildContext context) {
    userObjectsCollectionModel =
        createModel(context, () => UserObjectsCollectionModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    userObjectsCollectionModel.dispose();
  }
}
