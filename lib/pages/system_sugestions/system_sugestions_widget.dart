import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_expanded_image_view.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/custom_functions.dart' as functions;
import '/troka/random_data_util.dart' as random_data;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'system_sugestions_model.dart';
export 'system_sugestions_model.dart';

class SystemSugestionsWidget extends StatefulWidget {
  const SystemSugestionsWidget({super.key});

  @override
  State<SystemSugestionsWidget> createState() => _SystemSugestionsWidgetState();
}

class _SystemSugestionsWidgetState extends State<SystemSugestionsWidget> {
  late SystemSugestionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SystemSugestionsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'systemSugestions'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SYSTEM_SUGESTIONS_systemSugestions_ON_IN');
      logFirebaseEvent('systemSugestions_update_page_state');
      setState(() {
        _model.objectIdSelected = FFAppState().objectIdSelected;
      });
      logFirebaseEvent('systemSugestions_update_app_state');
      setState(() {
        FFAppState().isFiltered = false;
      });
      logFirebaseEvent('systemSugestions_update_app_state');
      FFAppState().filterCity = '';
      FFAppState().filterUF = '';
      FFAppState().filterObjectCategory = '';
      FFAppState().filterObjectInterest = [];
      FFAppState().filterAnyCategoryInterest = false;
      FFAppState().filterObjectCondition = [];
      FFAppState().filterChoice = '';
      logFirebaseEvent('systemSugestions_update_app_state');
      setState(() {
        FFAppState().btnRecebidas = true;
        FFAppState().btnEnviadas = false;
        FFAppState().btnEfetuadas = false;
      });
      if (functions.findSugestion(
          FFAppState().objectCategorySelected,
          FFAppState().objectCategoryInterests.toList(),
          FFAppState().objectAnyCategorySelected,
          currentUserUid,
          FFAppState().objectIdSelected)) {
        return;
      }

      return;
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
          isEqualTo: _model.objectIdSelected,
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
        List<UserObjectsRecord> systemSugestionsUserObjectsRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final systemSugestionsUserObjectsRecord =
            systemSugestionsUserObjectsRecordList.isNotEmpty
                ? systemSugestionsUserObjectsRecordList.first
                : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.sizeOf(context).height * 0.08),
              child: AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('SYSTEM_SUGESTIONS_PAGE__BTN_ON_TAP');
                      logFirebaseEvent('Button_update_app_state');
                      FFAppState().objectIdSelected = _model.objectIdSelected;
                      logFirebaseEvent('Button_navigate_to');

                      context.pushNamed('objectPage');

                      logFirebaseEvent('Button_update_app_state');
                      FFAppState().objectCategorySelected = '';
                      FFAppState().objectCategoryInterests = [];
                      FFAppState().objectAnyCategorySelected = false;
                    },
                    text: '',
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 25.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: double.infinity,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0x00FC4456),
                      textStyle: trokaTheme.of(context).titleSmall.override(
                            fontFamily: 'Fira Sans',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    showLoadingIndicator: false,
                  ),
                ),
                title: Text(
                  'Sugestões de trokas',
                  style: trokaTheme.of(context).headlineMedium.override(
                        fontFamily: 'Fira Sans',
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                actions: [],
                centerTitle: true,
                toolbarHeight: MediaQuery.sizeOf(context).height * 0.08,
                elevation: 2.0,
              ),
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: StreamBuilder<List<SystemSugestionsRecord>>(
                      stream: querySystemSugestionsRecord(
                        queryBuilder: (systemSugestionsRecord) =>
                            systemSugestionsRecord
                                .where(
                                  'objectId',
                                  isEqualTo: _model.objectIdSelected,
                                )
                                .whereNotIn(
                                    'objectInterestId',
                                    systemSugestionsUserObjectsRecord
                                        ?.offeredSugestionsObjectsId),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFFFC4456),
                                ),
                              ),
                            ),
                          );
                        }
                        List<SystemSugestionsRecord>
                            listViewSystemSugestionsRecordList = snapshot.data!;
                        if (listViewSystemSugestionsRecordList.isEmpty) {
                          return Center(
                            child: EmptySearchTextWidget(),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewSystemSugestionsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewSystemSugestionsRecord =
                                listViewSystemSugestionsRecordList[
                                    listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 10.0, 25.0, 10.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.22,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 12.0,
                                        color: Color(0x09767676),
                                        offset: Offset(
                                          0.0,
                                          0.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'SYSTEM_SUGESTIONS_Container_d500xjjf_ON_');
                                                    logFirebaseEvent(
                                                        'Container_update_app_state');
                                                    FFAppState()
                                                            .objectIdSelected =
                                                        listViewSystemSugestionsRecord
                                                            .objectInterestId;
                                                    logFirebaseEvent(
                                                        'Container_navigate_to');

                                                    context.pushNamed(
                                                        'objectPage');
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 0.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 12.0,
                                                            color: Color(
                                                                0x09767676),
                                                            offset: Offset(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0x00DDDDDD),
                                                          width: 0.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        9.0,
                                                                        0.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'SYSTEM_SUGESTIONS_Image_obzb9an6_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Image_expand_image');
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        trokaExpandedImageView(
                                                                      image: Image
                                                                          .network(
                                                                        listViewSystemSugestionsRecord
                                                                            .objectInterestPhoto,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      allowRotation:
                                                                          false,
                                                                      tag: listViewSystemSugestionsRecord
                                                                          .objectInterestPhoto,
                                                                      useHeroAnimation:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag: listViewSystemSugestionsRecord
                                                                    .objectInterestPhoto,
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            8.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0.0),
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    listViewSystemSugestionsRecord
                                                                        .objectInterestPhoto,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.35,
                                                                    height: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Flexible(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, -1.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 10.0),
                                                                              child: AutoSizeText(
                                                                                listViewSystemSugestionsRecord.objectInterestTitle,
                                                                                maxLines: 2,
                                                                                style: trokaTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Fira Sans',
                                                                                      color: Colors.black,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                minFontSize: 14.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            1.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      listViewSystemSugestionsRecord
                                                                          .objectInterestCategory,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          1,
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                      minFontSize:
                                                                          12.0,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            1.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      listViewSystemSugestionsRecord
                                                                          .objectInterestConditions,
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Color(0xFFB6B6B6),
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .location_pin,
                                                                          color:
                                                                              Color(0xFFFC4456),
                                                                          size:
                                                                              12.0,
                                                                        ),
                                                                        Text(
                                                                          listViewSystemSugestionsRecord
                                                                              .objectInterestCidade,
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
                                                                        Text(
                                                                          ', ',
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
                                                                        AutoSizeText(
                                                                          listViewSystemSugestionsRecord
                                                                              .objectInterestBairro,
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
                                                                          minFontSize:
                                                                              8.0,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'SYSTEM_SUGESTIONS_OFERECER_TROKA_BTN_ON_');
                                                    logFirebaseEvent(
                                                        'Button_backend_call');

                                                    await OffersRecord
                                                        .collection
                                                        .doc()
                                                        .set({
                                                      ...createOffersRecordData(
                                                        uidWhoOfferd:
                                                            currentUserUid,
                                                        uidReceivedOffer:
                                                            listViewSystemSugestionsRecord
                                                                .uidObjectInterest,
                                                        objectOfferTitle:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.title,
                                                        objectOfferCategory:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.objectCategory,
                                                        objectOfferId:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.objectId,
                                                        objectOfferConditions:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.objectConditions,
                                                        objectOfferCidade:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.cidade,
                                                        objectOfferBairro:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.bairro,
                                                        objectOfferPhoto:
                                                            systemSugestionsUserObjectsRecord
                                                                ?.photo1,
                                                        objectInterestPhoto:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestPhoto,
                                                        objectInterestTitle:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestTitle,
                                                        offerViewed: false,
                                                        offerId: random_data
                                                            .randomString(
                                                          8,
                                                          8,
                                                          true,
                                                          true,
                                                          true,
                                                        ),
                                                        objectInteresCategory:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestCategory,
                                                        objectInterestConditions:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestConditions,
                                                        objectInterestId:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestId,
                                                        objectInterestCidade:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestCidade,
                                                        objectInterestBairro:
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestBairro,
                                                        offerAccepted: false,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'offerDateTime':
                                                              FieldValue
                                                                  .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    logFirebaseEvent(
                                                        'Button_backend_call');

                                                    await systemSugestionsUserObjectsRecord!
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'offeredSugestionsObjectsId':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            listViewSystemSugestionsRecord
                                                                .objectInterestId
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    logFirebaseEvent(
                                                        'Button_backend_call');
                                                    await listViewSystemSugestionsRecord
                                                        .reference
                                                        .delete();
                                                  },
                                                  text: 'Oferecer troka',
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 40.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Color(0xC72ECC71),
                                                    textStyle: trokaTheme
                                                        .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Fira Sans',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
