import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/troka/troka_animations.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/custom_functions.dart' as functions;
import 'login_widget.dart' show LoginWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginModel extends trokaModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (buscaCidadeViaLoc)] action in Image widget.
  ApiCallResponse? apiCidadeLoc;
  // Stores action output result for [Backend Call - API (buscaCidade)] action in Image widget.
  ApiCallResponse? apiResultx2v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
