import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/random_data_util.dart' as random_data;
import 'object_offer_widget.dart' show ObjectOfferWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ObjectOfferModel extends trokaModel<ObjectOfferWidget> {
  ///  Local state fields for this component.

  String offerId = '0';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
