import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_expanded_image_view.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'ofertas_widget.dart' show OfertasWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class OfertasModel extends trokaModel<OfertasWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
