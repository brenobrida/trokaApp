import '/auth/firebase_auth/auth_util.dart';
import '/components/user_favorite_objects_collection_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'favoritos_widget.dart' show FavoritosWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritosModel extends trokaModel<FavoritosWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for userFavoriteObjectsCollection component.
  late UserFavoriteObjectsCollectionModel userFavoriteObjectsCollectionModel;

  @override
  void initState(BuildContext context) {
    userFavoriteObjectsCollectionModel =
        createModel(context, () => UserFavoriteObjectsCollectionModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    userFavoriteObjectsCollectionModel.dispose();
  }
}
