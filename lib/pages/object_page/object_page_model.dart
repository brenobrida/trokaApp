import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/object_offer_widget.dart';
import '/troka/troka_expanded_image_view.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_toggle_icon.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/troka/random_data_util.dart' as random_data;
import 'object_page_widget.dart' show ObjectPageWidget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ObjectPageModel extends trokaModel<ObjectPageWidget> {
  ///  Local state fields for this page.

  String? donationOfferId = '';

  bool offerMade = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - offerMade] action in objectPage widget.
  bool? offerMadeResult;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Custom Action - checkCategoryInterest] action in Button widget.
  bool? podeTrokar;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
