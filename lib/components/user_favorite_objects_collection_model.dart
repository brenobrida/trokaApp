import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_toggle_icon.dart';
import '/troka/troka_util.dart';
import 'user_favorite_objects_collection_widget.dart'
    show UserFavoriteObjectsCollectionWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class UserFavoriteObjectsCollectionModel
    extends trokaModel<UserFavoriteObjectsCollectionWidget> {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
