import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/troka/troka_animations.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'login'});
    animationsMap.addAll({
      'imageOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1290.0.ms,
            begin: 0.0,
            end: 2.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 5.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
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
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Stack(
              alignment: AlignmentDirectional(0.0, 0.0),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: GradientText(
                                  'tr',
                                  textAlign: TextAlign.justify,
                                  style: trokaTheme
                                      .of(context)
                                      .displayLarge
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        fontSize: 130.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                  colors: [
                                    Color(0xFFFF5F2B),
                                    Color(0xFFFF5F2B)
                                  ],
                                  gradientDirection: GradientDirection.ltr,
                                  gradientType: GradientType.linear,
                                ),
                              ),
                              Flexible(
                                child: SvgPicture.asset(
                                  'assets/images/logo.svg',
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.fill,
                                  alignment: Alignment(0.0, 0.0),
                                ).animateOnPageLoad(animationsMap[
                                    'imageOnPageLoadAnimation1']!),
                              ),
                              GradientText(
                                'ka',
                                textAlign: TextAlign.justify,
                                style: trokaTheme
                                    .of(context)
                                    .displayLarge
                                    .override(
                                      fontFamily: 'Fira Sans',
                                      fontSize: 130.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                colors: [Color(0xFFFC4456), Color(0xFFFC4456)],
                                gradientDirection: GradientDirection.ltr,
                                gradientType: GradientType.linear,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Seja bem vindo!',
                      textAlign: TextAlign.center,
                      style: trokaTheme.of(context).bodyMedium.override(
                            fontFamily: 'Fira Sans',
                            color: Colors.black,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Aqui você ',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            TextSpan(
                              text: 'troka',
                              style: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Color(0xFFFC4456),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: ' e não paga nada.',
                              style: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                          style: trokaTheme.of(context).bodyMedium.override(
                                fontFamily: 'Fira Sans',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                        child: Container(
                          width: 363.0,
                          height: 96.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Entre com a sua rede social',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 15.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'LOGIN_PAGE_Image_o2y6gchb_ON_TAP');
                                        currentUserLocationValue =
                                            await getCurrentUserLocation(
                                                defaultLocation:
                                                    LatLng(0.0, 0.0));
                                        var _shouldSetState = false;
                                        logFirebaseEvent('Image_auth');
                                        GoRouter.of(context).prepareAuthEvent();
                                        final user = await authManager
                                            .signInWithGoogle(context);
                                        if (user == null) {
                                          return;
                                        }
                                        if (valueOrDefault<bool>(
                                                currentUserDocument?.firstAcess,
                                                false) ==
                                            null) {
                                          logFirebaseEvent(
                                              'Image_backend_call');

                                          await currentUserReference!.update({
                                            ...createTrokaRecordData(
                                              firstAcess: false,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'offers': FieldValue.arrayUnion(
                                                    [' ']),
                                              },
                                            ),
                                          });
                                          logFirebaseEvent('Image_navigate_to');

                                          context.goNamedAuth(
                                            'conta',
                                            context.mounted,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );

                                          logFirebaseEvent(
                                              'Image_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Primeiro acesso'),
                                                content: Text(
                                                    'Preencha seus dados para começar a trokar!'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          logFirebaseEvent('Image_navigate_to');

                                          context.pushNamedAuth(
                                              'explorar', context.mounted);
                                        }

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().lat = functions
                                            .getLat(currentUserLocationValue)!;
                                        FFAppState().lng = functions
                                            .getLng(currentUserLocationValue)!;
                                        FFAppState().filterCity = '';
                                        FFAppState().filterUF = '';
                                        FFAppState().filterObjectCategory = '';
                                        FFAppState().filterObjectInterest = [];
                                        FFAppState().filterAnyCategoryInterest =
                                            false;
                                        FFAppState().filterObjectCondition = [];
                                        FFAppState().filterChoice = '';
                                        logFirebaseEvent('Image_backend_call');
                                        _model.apiCidadeLoc =
                                            await BuscaCidadeViaLocCall.call(
                                          lat: FFAppState().lat,
                                          lon: FFAppState().lng,
                                        );
                                        _shouldSetState = true;
                                        if ((_model.apiCidadeLoc?.succeeded ??
                                            true)) {
                                          logFirebaseEvent(
                                              'Image_update_app_state');
                                          FFAppState().update(() {
                                            FFAppState().cidadeViaLoc =
                                                getJsonField(
                                              (_model.apiCidadeLoc?.jsonBody ??
                                                  ''),
                                              r'''$.address.city''',
                                            ).toString();
                                          });
                                          logFirebaseEvent(
                                              'Image_backend_call');
                                          _model.apiResultx2v =
                                              await BuscaCidadeCall.call();
                                          _shouldSetState = true;
                                        } else {
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }

                                        if (_shouldSetState) setState(() {});
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/google.png',
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                        .animateOnPageLoad(animationsMap[
                                            'imageOnPageLoadAnimation2']!)
                                        .animateOnActionTrigger(
                                          animationsMap[
                                              'imageOnActionTriggerAnimation']!,
                                        ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'LOGIN_PAGE_Image_3gtb6dul_ON_TAP');
                                        logFirebaseEvent('Image_auth');
                                        GoRouter.of(context).prepareAuthEvent();
                                        final user = await authManager
                                            .signInWithFacebook(context);
                                        if (user == null) {
                                          return;
                                        }
                                        logFirebaseEvent('Image_navigate_to');

                                        context.pushNamedAuth(
                                            'explorar', context.mounted);
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/facebook.png',
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation3']!),
                                  ].divide(SizedBox(width: 40.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
