import '/troka/troka_animations.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'custom_snack_bar_denied_category_model.dart';
export 'custom_snack_bar_denied_category_model.dart';

class CustomSnackBarDeniedCategoryWidget extends StatefulWidget {
  const CustomSnackBarDeniedCategoryWidget({super.key});

  @override
  State<CustomSnackBarDeniedCategoryWidget> createState() =>
      _CustomSnackBarDeniedCategoryWidgetState();
}

class _CustomSnackBarDeniedCategoryWidgetState
    extends State<CustomSnackBarDeniedCategoryWidget>
    with TickerProviderStateMixin {
  late CustomSnackBarDeniedCategoryModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomSnackBarDeniedCategoryModel());

    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 180.0.ms,
            begin: Offset(0.0, 59.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1500.0.ms,
            duration: 280.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            'Categoria não aceita em troka!',
            style: trokaTheme.of(context).bodyMedium.override(
                  fontFamily: 'Fira Sans',
                  color: Color(0xFFFF0000),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ).animateOnActionTrigger(
        animationsMap['containerOnActionTriggerAnimation']!,
      ),
    );
  }
}
