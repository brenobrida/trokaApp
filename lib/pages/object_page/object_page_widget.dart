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
import 'object_page_model.dart';
export 'object_page_model.dart';

class ObjectPageWidget extends StatefulWidget {
  const ObjectPageWidget({super.key});

  @override
  State<ObjectPageWidget> createState() => _ObjectPageWidgetState();
}

class _ObjectPageWidgetState extends State<ObjectPageWidget> {
  late ObjectPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ObjectPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'objectPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('OBJECT_objectPage_ON_INIT_STATE');
      logFirebaseEvent('objectPage_custom_action');
      _model.offerMadeResult = await actions.offerMade(
        currentUserUid,
        FFAppState().objectIdSelected,
      );
      logFirebaseEvent('objectPage_update_page_state');
      setState(() {
        _model.offerMade = _model.offerMadeResult!;
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<UserObjectsRecord>>(
      stream: queryUserObjectsRecord(
        queryBuilder: (userObjectsRecord) => userObjectsRecord.where(
          'objectId',
          isEqualTo: FFAppState().objectIdSelected,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFC4456),
                  ),
                ),
              ),
            ),
          );
        }
        List<UserObjectsRecord> objectPageUserObjectsRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final objectPageUserObjectsRecord =
            objectPageUserObjectsRecordList.isNotEmpty
                ? objectPageUserObjectsRecordList.first
                : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 40.0),
                                    child: PageView(
                                      controller: _model.pageViewController ??=
                                          PageController(initialPage: 0),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'OBJECT_PAGE_PAGE_Image_2i7ukh94_ON_TAP');
                                            logFirebaseEvent(
                                                'Image_expand_image');
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: trokaExpandedImageView(
                                                  image: Image.network(
                                                    objectPageUserObjectsRecord!
                                                        .photo1,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  allowRotation: false,
                                                  tag:
                                                      objectPageUserObjectsRecord!
                                                          .photo1,
                                                  useHeroAnimation: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: objectPageUserObjectsRecord!
                                                .photo1,
                                            transitionOnUserGestures: true,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.network(
                                                objectPageUserObjectsRecord!
                                                    .photo1,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.5,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: (objectPageUserObjectsRecord
                                                          ?.photo2 !=
                                                      null &&
                                                  objectPageUserObjectsRecord
                                                          ?.photo2 !=
                                                      '') &&
                                              (objectPageUserObjectsRecord
                                                      ?.photo2 !=
                                                  'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25'),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'OBJECT_PAGE_PAGE_Image_aepbqqbm_ON_TAP');
                                              logFirebaseEvent(
                                                  'Image_expand_image');
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: trokaExpandedImageView(
                                                    image: Image.network(
                                                      objectPageUserObjectsRecord!
                                                          .photo2,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    allowRotation: false,
                                                    tag:
                                                        objectPageUserObjectsRecord!
                                                            .photo2,
                                                    useHeroAnimation: true,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: objectPageUserObjectsRecord!
                                                  .photo2,
                                              transitionOnUserGestures: true,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: Image.network(
                                                  objectPageUserObjectsRecord!
                                                      .photo2,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.5,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'OBJECT_PAGE_PAGE_Image_onjsskjy_ON_TAP');
                                            logFirebaseEvent(
                                                'Image_expand_image');
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: trokaExpandedImageView(
                                                  image: Image.network(
                                                    objectPageUserObjectsRecord!
                                                        .photo3,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  allowRotation: false,
                                                  tag:
                                                      objectPageUserObjectsRecord!
                                                          .photo3,
                                                  useHeroAnimation: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: objectPageUserObjectsRecord!
                                                .photo3,
                                            transitionOnUserGestures: true,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.network(
                                                objectPageUserObjectsRecord!
                                                    .photo3,
                                                width: 100.0,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.5,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'OBJECT_PAGE_PAGE_Image_w0hfqf7l_ON_TAP');
                                            logFirebaseEvent(
                                                'Image_expand_image');
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: trokaExpandedImageView(
                                                  image: Image.network(
                                                    objectPageUserObjectsRecord!
                                                        .photo4,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  allowRotation: false,
                                                  tag:
                                                      objectPageUserObjectsRecord!
                                                          .photo4,
                                                  useHeroAnimation: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: objectPageUserObjectsRecord!
                                                .photo4,
                                            transitionOnUserGestures: true,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.network(
                                                objectPageUserObjectsRecord!
                                                    .photo4,
                                                width: 100.0,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.5,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'OBJECT_PAGE_PAGE_Image_eyloz66o_ON_TAP');
                                            logFirebaseEvent(
                                                'Image_expand_image');
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: trokaExpandedImageView(
                                                  image: Image.network(
                                                    objectPageUserObjectsRecord!
                                                        .photo5,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  allowRotation: false,
                                                  tag:
                                                      objectPageUserObjectsRecord!
                                                          .photo5,
                                                  useHeroAnimation: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: objectPageUserObjectsRecord!
                                                .photo5,
                                            transitionOnUserGestures: true,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.network(
                                                objectPageUserObjectsRecord!
                                                    .photo5,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.5,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'OBJECT_PAGE_PAGE_Image_84lhs09m_ON_TAP');
                                            logFirebaseEvent(
                                                'Image_expand_image');
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: trokaExpandedImageView(
                                                  image: Image.network(
                                                    objectPageUserObjectsRecord!
                                                        .photo0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  allowRotation: false,
                                                  tag:
                                                      objectPageUserObjectsRecord!
                                                          .photo0,
                                                  useHeroAnimation: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: objectPageUserObjectsRecord!
                                                .photo0,
                                            transitionOnUserGestures: true,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.network(
                                                objectPageUserObjectsRecord!
                                                    .photo0,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.5,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 0.0, 16.0),
                                      child: smooth_page_indicator
                                          .SmoothPageIndicator(
                                        controller:
                                            _model.pageViewController ??=
                                                PageController(initialPage: 0),
                                        count: 6,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) async {
                                          await _model.pageViewController!
                                              .animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        effect: smooth_page_indicator
                                            .ExpandingDotsEffect(
                                          expansionFactor: 3.0,
                                          spacing: 6.0,
                                          radius: 24.0,
                                          dotWidth: 8.0,
                                          dotHeight: 6.0,
                                          dotColor: Color(0xFFB6B6B6),
                                          activeDotColor: Color(0xFFFF5868),
                                          paintStyle: PaintingStyle.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.04),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).height * 0.05,
                                      0.0,
                                    ),
                                    25.0,
                                    0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'OBJECT_Container_7cjjle6w_ON_TAP');
                                        logFirebaseEvent(
                                            'Container_navigate_to');

                                        context.pushNamed(
                                          'meusObjetos',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType
                                                  .topToBottom,
                                            ),
                                          },
                                        );

                                        logFirebaseEvent(
                                            'Container_update_app_state');
                                        FFAppState().listOfInterests = [];
                                        logFirebaseEvent(
                                            'Container_update_app_state');
                                        FFAppState().objectInterestUid = '';
                                        FFAppState().objectInterestPhoto = '';
                                        FFAppState().objectInterestTitle = '';
                                        FFAppState().objectInterestCategory =
                                            '';
                                        FFAppState().objectInterestConditions =
                                            '';
                                        FFAppState().objectInterestCidade = '';
                                        FFAppState().objectInterestBairro = '';
                                        FFAppState().objectInterestId = '';
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6.0, 0.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'OBJECT_PAGE_PAGE_Icon_0cxyt6ko_ON_TAP');
                                                if (objectPageUserObjectsRecord
                                                        ?.uid ==
                                                    currentUserUid) {
                                                  logFirebaseEvent(
                                                      'Icon_navigate_to');

                                                  context.pushNamed(
                                                    'meusObjetos',
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .topToBottom,
                                                      ),
                                                    },
                                                  );
                                                } else {
                                                  logFirebaseEvent(
                                                      'Icon_navigate_back');
                                                  context.safePop();
                                                }

                                                logFirebaseEvent(
                                                    'Icon_update_app_state');
                                                FFAppState().listOfInterests =
                                                    [];
                                                logFirebaseEvent(
                                                    'Icon_update_app_state');
                                                FFAppState().objectInterestUid =
                                                    '';
                                                FFAppState()
                                                    .objectInterestPhoto = '';
                                                FFAppState()
                                                    .objectInterestTitle = '';
                                                FFAppState()
                                                    .objectInterestCategory = '';
                                                FFAppState()
                                                    .objectInterestConditions = '';
                                                FFAppState()
                                                    .objectInterestCidade = '';
                                                FFAppState()
                                                    .objectInterestBairro = '';
                                                FFAppState().objectInterestId =
                                                    '';
                                              },
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.black,
                                                size: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Builder(
                                          builder: (context) => Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 2.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'OBJECT_PAGE_PAGE__BTN_ON_TAP');
                                                logFirebaseEvent(
                                                    'Button_share');
                                                await Share.share(
                                                  'troka://troka.com${GoRouterState.of(context).uri.toString()}',
                                                  sharePositionOrigin:
                                                      getWidgetBoundingBox(
                                                          context),
                                                );
                                              },
                                              text: '',
                                              icon: Icon(
                                                Icons.ios_share,
                                                color: Colors.black,
                                                size: 20.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: 40.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            8.0, 0.0, 0.0, 3.0),
                                                color: Colors.white,
                                                textStyle: trokaTheme
                                                    .of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Fira Sans',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                                elevation: 1.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              showLoadingIndicator: false,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (objectPageUserObjectsRecord?.uid !=
                                        currentUserUid)
                                      Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 1.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 2.0, 0.0, 0.0),
                                            child: ToggleIcon(
                                              onPressed: () async {
                                                setState(
                                                  () => FFAppState()
                                                          .userFavoriteObjetcs
                                                          .contains(
                                                              objectPageUserObjectsRecord
                                                                  ?.objectId)
                                                      ? FFAppState()
                                                          .removeFromUserFavoriteObjetcs(
                                                              objectPageUserObjectsRecord!
                                                                  .objectId)
                                                      : FFAppState()
                                                          .addToUserFavoriteObjetcs(
                                                              objectPageUserObjectsRecord!
                                                                  .objectId),
                                                );
                                                logFirebaseEvent(
                                                    'OBJECT_ToggleIcon_cemz6ze4_ON_TOGGLE');
                                                if ((currentUserDocument
                                                            ?.favoriteObjects
                                                            ?.toList() ??
                                                        [])
                                                    .contains(
                                                        objectPageUserObjectsRecord
                                                            ?.objectId)) {
                                                  logFirebaseEvent(
                                                      'ToggleIcon_backend_call');

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'favoriteObjects':
                                                            FieldValue
                                                                .arrayRemove([
                                                          objectPageUserObjectsRecord
                                                              ?.objectId
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                } else {
                                                  logFirebaseEvent(
                                                      'ToggleIcon_backend_call');

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'favoriteObjects':
                                                            FieldValue
                                                                .arrayUnion([
                                                          objectPageUserObjectsRecord
                                                              ?.objectId
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                }
                                              },
                                              value: FFAppState()
                                                  .userFavoriteObjetcs
                                                  .contains(
                                                      objectPageUserObjectsRecord
                                                          ?.objectId),
                                              onIcon: Icon(
                                                Icons.favorite_rounded,
                                                color: Color(0xFFFC4456),
                                                size: 25.0,
                                              ),
                                              offIcon: Icon(
                                                Icons.favorite_border_rounded,
                                                color: Colors.black,
                                                size: 25.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 25.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                objectPageUserObjectsRecord?.title,
                                'erro',
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 20.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                objectPageUserObjectsRecord?.objectCategory,
                                'erro',
                              ),
                              textAlign: TextAlign.start,
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 5.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                objectPageUserObjectsRecord?.objectConditions,
                                'erro',
                              ),
                              textAlign: TextAlign.start,
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Color(0xFFB6B6B6),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              21.0, 5.0, 0.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Color(0xFFFC4456),
                                size: 20.0,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, -1.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    objectPageUserObjectsRecord?.cidade,
                                    'err',
                                  ),
                                  style: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Color(0xFFB6B6B6),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              Text(
                                ', ',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFFB6B6B6),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  objectPageUserObjectsRecord?.bairro,
                                  'tt',
                                ),
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFFB6B6B6),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          indent: 25.0,
                          endIndent: 25.0,
                          color: Color(0xFFB6B6B6),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 25.0, 0.0),
                            child: StreamBuilder<List<TrokaRecord>>(
                              stream: queryTrokaRecord(
                                queryBuilder: (trokaRecord) =>
                                    trokaRecord.where(
                                  'uid',
                                  isEqualTo: objectPageUserObjectsRecord?.uid,
                                ),
                                singleRecord: true,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFC4456),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<TrokaRecord> rowTrokaRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final rowTrokaRecord =
                                    rowTrokaRecordList.isNotEmpty
                                        ? rowTrokaRecordList.first
                                        : null;
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width: double.infinity,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              child: Image.network(
                                                rowTrokaRecord!.photoUrl,
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        6.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    rowTrokaRecord?.nickname,
                                                    'erro',
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                  style: trokaTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Fira Sans',
                                                        color: Colors.black,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat(
                                          'relative',
                                          rowTrokaRecord?.createdTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        'error',
                                      ),
                                      textAlign: TextAlign.justify,
                                      style: trokaTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Fira Sans',
                                            color: Color(0xFFB6B6B6),
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          3.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'usando o troka',
                                        textAlign: TextAlign.justify,
                                        style: trokaTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Fira Sans',
                                              color: Color(0xFFB6B6B6),
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          indent: 25.0,
                          endIndent: 25.0,
                          color: Color(0xFFB6B6B6),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 10.0, 0.0, 0.0),
                            child: Text(
                              'Descrição: ',
                              textAlign: TextAlign.start,
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 5.0, 25.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                objectPageUserObjectsRecord?.description,
                                'err',
                              ),
                              textAlign: TextAlign.start,
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (objectPageUserObjectsRecord
                                      ?.negotiationType ==
                                  'troka')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25.0, 5.0, 0.0, 5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        child: SvgPicture.asset(
                                          'assets/images/logo.svg',
                                          width: 25.0,
                                          height: 25.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: GradientText(
                                          'troka',
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFFC4456),
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          colors: [
                                            Color(0xFFFF5F2B),
                                            Color(0xFFFF5976)
                                          ],
                                          gradientDirection:
                                              GradientDirection.ltr,
                                          gradientType: GradientType.linear,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'por: ',
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFB6B6B6),
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      if (objectPageUserObjectsRecord
                                              ?.anyCategory ==
                                          true)
                                        Text(
                                          'Qualquer objeto!',
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              if (objectPageUserObjectsRecord
                                      ?.negotiationType ==
                                  'doação')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25.0, 5.0, 0.0, 5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        child: Image.asset(
                                          'assets/images/heart.png',
                                          width: 20.0,
                                          height: 20.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Doação',
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFFC4456),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if ((objectPageUserObjectsRecord?.anyCategory ==
                                false) &&
                            (objectPageUserObjectsRecord?.negotiationType ==
                                'troka'))
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 5.0, 25.0, 20.0),
                              child: Builder(
                                builder: (context) {
                                  final categories = objectPageUserObjectsRecord
                                          ?.objectCategoryInterest
                                          ?.toList() ??
                                      [];
                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: categories.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 2.0),
                                    itemBuilder: (context, categoriesIndex) {
                                      final categoriesItem =
                                          categories[categoriesIndex];
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '- ',
                                            style: trokaTheme
                                                .of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Fira Sans',
                                                  color: Colors.black,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            categoriesItem,
                                            textAlign: TextAlign.start,
                                            maxLines: 8,
                                            style: trokaTheme
                                                .of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Fira Sans',
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0.0,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              -1.0,
                            ),
                          )
                        ],
                        border: Border.all(
                          color: Color(0xFFB6B6B6),
                          width: 0.0,
                        ),
                      ),
                      child: StreamBuilder<List<TrokaRecord>>(
                        stream: queryTrokaRecord(
                          queryBuilder: (trokaRecord) => trokaRecord.where(
                            'uid',
                            isEqualTo: objectPageUserObjectsRecord?.uid,
                          ),
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFC4456),
                                  ),
                                ),
                              ),
                            );
                          }
                          List<TrokaRecord> stackTrokaRecordList =
                              snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final stackTrokaRecord =
                              stackTrokaRecordList.isNotEmpty
                                  ? stackTrokaRecordList.first
                                  : null;
                          return Stack(
                            children: [
                              if (_model.offerMade == true)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25.0, 20.0, 0.0, 20.0),
                                    child: Text(
                                      'Oferta já realizada para este anúncio',
                                      style: trokaTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Fira Sans',
                                            color: Color(0xFFFC4456),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              if ((objectPageUserObjectsRecord
                                          ?.negotiationType ==
                                      'doação') &&
                                  (objectPageUserObjectsRecord?.uid !=
                                      currentUserUid) &&
                                  (_model.offerMade == false))
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'OBJECT_ACEITAR_DOAÇÃO_BTN_ON_TAP');
                                      logFirebaseEvent(
                                          'Button_update_page_state');
                                      _model.donationOfferId =
                                          random_data.randomString(
                                        8,
                                        8,
                                        true,
                                        true,
                                        true,
                                      );
                                      logFirebaseEvent('Button_backend_call');

                                      await OffersRecord.collection.doc().set({
                                        ...createOffersRecordData(
                                          offerDateTime: getCurrentTimestamp,
                                          offerId: _model.donationOfferId,
                                          uidReceivedOffer:
                                              FFAppState().objectInterestUid,
                                          objectInterestPhoto:
                                              FFAppState().objectInterestPhoto,
                                          objectInterestTitle:
                                              FFAppState().objectInterestTitle,
                                          objectInteresCategory: FFAppState()
                                              .objectInterestCategory,
                                          objectInterestConditions: FFAppState()
                                              .objectInterestConditions,
                                          objectInterestId:
                                              FFAppState().objectInterestId,
                                          objectInterestCidade:
                                              FFAppState().objectInterestCidade,
                                          objectInterestBairro:
                                              FFAppState().objectInterestBairro,
                                          uidWhoOfferd: currentUserUid,
                                          offerAccepted: true,
                                          offerCategory: 'doação',
                                          lastMessage: '',
                                          lastMessageOwner: '',
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'messageTime':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      logFirebaseEvent('Button_backend_call');

                                      await stackTrokaRecord!.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'offers': FieldValue.arrayUnion(
                                                [_model.donationOfferId]),
                                          },
                                        ),
                                      });
                                      logFirebaseEvent('Button_backend_call');

                                      await currentUserReference!.update({
                                        ...mapToFirestore(
                                          {
                                            'offers': FieldValue.arrayUnion(
                                                [_model.donationOfferId]),
                                          },
                                        ),
                                      });
                                      logFirebaseEvent('Button_navigate_to');

                                      context.pushNamed(
                                        'chat',
                                        queryParameters: {
                                          'offerId': serializeParam(
                                            _model.donationOfferId,
                                            ParamType.String,
                                          ),
                                          'objectImage': serializeParam(
                                            objectPageUserObjectsRecord?.photo1,
                                            ParamType.String,
                                          ),
                                          'objectTitle': serializeParam(
                                            objectPageUserObjectsRecord?.title,
                                            ParamType.String,
                                          ),
                                          'objectId': serializeParam(
                                            objectPageUserObjectsRecord
                                                ?.objectId,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );

                                      logFirebaseEvent(
                                          'Button_update_page_state');
                                      _model.donationOfferId = '';
                                      logFirebaseEvent(
                                          'Button_update_app_state');
                                      FFAppState().objectInterestUid = '';
                                      FFAppState().objectInterestPhoto = '';
                                      FFAppState().objectInterestTitle = '';
                                      FFAppState().objectInterestCategory = '';
                                      FFAppState().objectInterestConditions =
                                          '';
                                      FFAppState().objectInterestCidade = '';
                                      FFAppState().objectInterestBairro = '';
                                      FFAppState().objectInterestId = '';
                                      logFirebaseEvent('Button_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Doação aceita!',
                                            style: GoogleFonts.getFont(
                                              'Fira Sans',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 3000),
                                          backgroundColor: Colors.white,
                                        ),
                                      );
                                    },
                                    text: 'Aceitar doação',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.36,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.06,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFFFC4456),
                                      textStyle: GoogleFonts.getFont(
                                        'Fira Sans',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    showLoadingIndicator: false,
                                  ),
                                ),
                              if ((objectPageUserObjectsRecord
                                          ?.negotiationType ==
                                      'troka') &&
                                  (objectPageUserObjectsRecord?.uid !=
                                      currentUserUid) &&
                                  (_model.offerMade == false))
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Builder(
                                    builder: (context) => FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'OBJECT_OFERECER_TROKA_BTN_ON_TAP');
                                        logFirebaseEvent(
                                            'Button_update_app_state');
                                        FFAppState().listOfInterests =
                                            objectPageUserObjectsRecord!
                                                .objectCategoryInterest
                                                .toList()
                                                .cast<String>();
                                        if (objectPageUserObjectsRecord!
                                            .anyCategory) {
                                          logFirebaseEvent(
                                              'Button_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ObjectOfferWidget(
                                                    objectUid:
                                                        objectPageUserObjectsRecord!
                                                            .uid,
                                                    objectCategoriesInterest:
                                                        objectPageUserObjectsRecord!
                                                            .objectCategoryInterest,
                                                    podeTrokar: true,
                                                    anyCategory:
                                                        objectPageUserObjectsRecord!
                                                            .anyCategory,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        } else {
                                          logFirebaseEvent(
                                              'Button_custom_action');
                                          _model.podeTrokar = await actions
                                              .checkCategoryInterest(
                                            objectPageUserObjectsRecord!
                                                .objectCategoryInterest
                                                .toList(),
                                            currentUserUid,
                                          );
                                          if (_model.podeTrokar!) {
                                            logFirebaseEvent(
                                                'Button_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: GestureDetector(
                                                    onTap: () => _model
                                                            .unfocusNode
                                                            .canRequestFocus
                                                        ? FocusScope.of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode)
                                                        : FocusScope.of(context)
                                                            .unfocus(),
                                                    child: ObjectOfferWidget(
                                                      objectUid:
                                                          objectPageUserObjectsRecord!
                                                              .uid,
                                                      objectCategoriesInterest:
                                                          objectPageUserObjectsRecord!
                                                              .objectCategoryInterest,
                                                      podeTrokar: true,
                                                      anyCategory:
                                                          objectPageUserObjectsRecord!
                                                              .anyCategory,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => setState(() {}));
                                          } else {
                                            logFirebaseEvent(
                                                'Button_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: GestureDetector(
                                                    onTap: () => _model
                                                            .unfocusNode
                                                            .canRequestFocus
                                                        ? FocusScope.of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode)
                                                        : FocusScope.of(context)
                                                            .unfocus(),
                                                    child: ObjectOfferWidget(
                                                      objectUid:
                                                          objectPageUserObjectsRecord!
                                                              .uid,
                                                      objectCategoriesInterest:
                                                          objectPageUserObjectsRecord!
                                                              .objectCategoryInterest,
                                                      podeTrokar: false,
                                                      anyCategory:
                                                          objectPageUserObjectsRecord!
                                                              .anyCategory,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => setState(() {}));
                                          }
                                        }

                                        setState(() {});
                                      },
                                      text: 'Oferecer troka',
                                      options: FFButtonOptions(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.36,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.06,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Color(0xFFFC4456),
                                        textStyle: GoogleFonts.getFont(
                                          'Fira Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      showLoadingIndicator: false,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 25.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (objectPageUserObjectsRecord?.uid ==
                                        currentUserUid)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'OBJECT_PAGE_PAGE_EDITAR_BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_update_app_state');
                                            FFAppState().objectIdSelected =
                                                objectPageUserObjectsRecord!
                                                    .objectId;
                                            logFirebaseEvent(
                                                'Button_update_app_state');
                                            setState(() {
                                              FFAppState().photo0 =
                                                  objectPageUserObjectsRecord!
                                                      .photo0;
                                              FFAppState().photo1 =
                                                  objectPageUserObjectsRecord!
                                                      .photo1;
                                              FFAppState().photo2 =
                                                  objectPageUserObjectsRecord!
                                                      .photo2;
                                              FFAppState().photo3 =
                                                  objectPageUserObjectsRecord!
                                                      .photo3;
                                              FFAppState().photo4 =
                                                  objectPageUserObjectsRecord!
                                                      .photo4;
                                              FFAppState().photo5 =
                                                  objectPageUserObjectsRecord!
                                                      .photo5;
                                            });
                                            logFirebaseEvent(
                                                'Button_navigate_to');

                                            context.pushNamed('editar');
                                          },
                                          text: 'Editar',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.36,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.06,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFFC4456),
                                            textStyle: GoogleFonts.getFont(
                                              'Fira Sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          showLoadingIndicator: false,
                                        ),
                                      ),
                                    if (objectPageUserObjectsRecord?.uid ==
                                        currentUserUid)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'OBJECT_SUGESTÕES_DE_TROKA_BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_update_app_state');
                                            FFAppState().objectIdSelected =
                                                objectPageUserObjectsRecord!
                                                    .objectId;
                                            FFAppState()
                                                    .objectCategorySelected =
                                                objectPageUserObjectsRecord!
                                                    .objectCategory;
                                            FFAppState()
                                                    .objectCategoryInterests =
                                                objectPageUserObjectsRecord!
                                                    .objectCategoryInterest
                                                    .toList()
                                                    .cast<String>();
                                            FFAppState()
                                                    .objectAnyCategorySelected =
                                                objectPageUserObjectsRecord!
                                                    .anyCategory;
                                            logFirebaseEvent(
                                                'Button_navigate_to');

                                            context
                                                .pushNamed('systemSugestions');
                                          },
                                          text: 'Sugestões de troka',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.4,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.06,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFFC4456),
                                            textStyle: GoogleFonts.getFont(
                                              'Fira Sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          showLoadingIndicator: false,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
