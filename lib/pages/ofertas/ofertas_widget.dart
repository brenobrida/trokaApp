import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_expanded_image_view.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'ofertas_model.dart';
export 'ofertas_model.dart';

class OfertasWidget extends StatefulWidget {
  const OfertasWidget({super.key});

  @override
  State<OfertasWidget> createState() => _OfertasWidgetState();
}

class _OfertasWidgetState extends State<OfertasWidget> {
  late OfertasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfertasModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ofertas'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('OFERTAS_PAGE_ofertas_ON_INIT_STATE');
      logFirebaseEvent('ofertas_update_app_state');
      setState(() {
        FFAppState().isFiltered = false;
      });
      logFirebaseEvent('ofertas_update_app_state');
      FFAppState().filterCity = '';
      FFAppState().filterUF = '';
      FFAppState().filterObjectCategory = '';
      FFAppState().filterObjectInterest = [];
      FFAppState().filterAnyCategoryInterest = false;
      FFAppState().filterObjectCondition = [];
      FFAppState().filterChoice = '';
      logFirebaseEvent('ofertas_update_app_state');
      setState(() {
        FFAppState().btnRecebidas = true;
        FFAppState().btnEnviadas = false;
        FFAppState().btnEfetuadas = false;
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF6F6FB),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'OFERTAS_PAGE_Container_8zmdb7kg_ON_TAP');
                        logFirebaseEvent('Container_update_app_state');
                        setState(() {
                          FFAppState().btnRecebidas = false;
                          FFAppState().btnEnviadas = true;
                          FFAppState().btnEfetuadas = false;
                        });
                      },
                      child: Material(
                        color: Colors.transparent,
                        elevation: FFAppState().btnEnviadas ? 3.0 : 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: SafeArea(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            decoration: BoxDecoration(
                              color: FFAppState().btnEnviadas
                                  ? Color(0xFFFC4456)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                              border: Border.all(
                                color: Color(0x00FC4456),
                                width: 0.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Enviadas',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: FFAppState().btnEnviadas
                                              ? Colors.white
                                              : Color(0xFFFF4456),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'OFERTAS_PAGE_Container_v2slm40p_ON_TAP');
                        logFirebaseEvent('Container_update_app_state');
                        setState(() {
                          FFAppState().btnRecebidas = true;
                          FFAppState().btnEnviadas = false;
                          FFAppState().btnEfetuadas = false;
                        });
                      },
                      child: Material(
                        color: Colors.transparent,
                        elevation: FFAppState().btnRecebidas ? 3.0 : 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: SafeArea(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            decoration: BoxDecoration(
                              color: FFAppState().btnRecebidas
                                  ? Color(0xFFFC4456)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                              border: Border.all(
                                color: Color(0x00FC4456),
                                width: 1.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Recebidas',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: FFAppState().btnRecebidas
                                              ? Colors.white
                                              : Color(0xFFFF4456),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'OFERTAS_PAGE_Container_xkcnixoa_ON_TAP');
                        logFirebaseEvent('Container_update_app_state');
                        setState(() {
                          FFAppState().btnRecebidas = false;
                          FFAppState().btnEnviadas = false;
                          FFAppState().btnEfetuadas = true;
                        });
                      },
                      child: Material(
                        color: Colors.transparent,
                        elevation: FFAppState().btnEfetuadas ? 3.0 : 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: SafeArea(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            decoration: BoxDecoration(
                              color: FFAppState().btnEfetuadas
                                  ? Color(0xFFFC4456)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                              border: Border.all(
                                color: Color(0x00FC4456),
                                width: 0.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Efetuadas',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: FFAppState().btnEfetuadas
                                              ? Colors.white
                                              : Color(0xFFFF4456),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (FFAppState().btnRecebidas)
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                    child: StreamBuilder<List<OffersRecord>>(
                      stream: queryOffersRecord(
                        queryBuilder: (offersRecord) => offersRecord
                            .where(
                              'uidReceivedOffer',
                              isEqualTo: currentUserUid,
                            )
                            .orderBy('offerDateTime', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 200.0, 0.0, 0.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    trokaTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        List<OffersRecord> listViewOffersRecordList =
                            snapshot.data!;
                        if (listViewOffersRecordList.isEmpty) {
                          return EmptySearchTextWidget();
                        }
                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            10.0,
                            0,
                            10.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: listViewOffersRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewOffersRecord =
                                listViewOffersRecordList[listViewIndex];
                            return StreamBuilder<List<TrokaRecord>>(
                              stream: queryTrokaRecord(
                                queryBuilder: (trokaRecord) =>
                                    trokaRecord.where(
                                  'uid',
                                  isEqualTo: listViewOffersRecord.uidWhoOfferd,
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
                                List<TrokaRecord> containerTrokaRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final containerTrokaRecord =
                                    containerTrokaRecordList.isNotEmpty
                                        ? containerTrokaRecordList.first
                                        : null;
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onLongPress: () async {
                                    logFirebaseEvent(
                                        'OFERTAS_Container_be5smack_ON_LONG_PRESS');
                                    logFirebaseEvent('Container_alert_dialog');
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Atenção'),
                                                  content: Text(
                                                      'Tem certeza que deseja recusar a oferta?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Não'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text('Sim'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      logFirebaseEvent(
                                          'Container_backend_call');
                                      await listViewOffersRecord.reference
                                          .delete();
                                    }
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.5,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.26,
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 10.0, 10.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'OFERTAS_PAGE_Container_xbrx6se3_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Container_update_app_state');
                                                  FFAppState()
                                                          .objectIdSelected =
                                                      listViewOffersRecord
                                                          .objectOfferId;
                                                  logFirebaseEvent(
                                                      'Container_backend_call');

                                                  await listViewOffersRecord
                                                      .reference
                                                      .update(
                                                          createOffersRecordData(
                                                    offerViewed: true,
                                                  ));
                                                  logFirebaseEvent(
                                                      'Container_navigate_to');

                                                  context
                                                      .pushNamed('objectPage');
                                                },
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 0.0,
                                                  shape: RoundedRectangleBorder(
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
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
                                                                  'OFERTAS_PAGE_Image_yjyw22ip_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Image_expand_image');
                                                              await Navigator
                                                                  .push(
                                                                context,
                                                                PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      trokaExpandedImageView(
                                                                    image: Image
                                                                        .network(
                                                                      listViewOffersRecord
                                                                          .objectOfferPhoto,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                    allowRotation:
                                                                        false,
                                                                    tag: listViewOffersRecord
                                                                        .objectOfferPhoto,
                                                                    useHeroAnimation:
                                                                        true,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Hero(
                                                              tag: listViewOffersRecord
                                                                  .objectOfferPhoto,
                                                              transitionOnUserGestures:
                                                                  true,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  listViewOffersRecord
                                                                      .objectOfferPhoto,
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
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
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          1.0,
                                                                          0.0,
                                                                          0.0,
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        listViewOffersRecord
                                                                            .objectOfferTitle,
                                                                        maxLines:
                                                                            2,
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
                                                                        minFontSize:
                                                                            14.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            1.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  listViewOffersRecord
                                                                      .objectOfferCategory,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  style: trokaTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Fira Sans',
                                                                        color: Colors
                                                                            .black,
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
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            1.0,
                                                                            2.0,
                                                                            0.0,
                                                                            2.0),
                                                                child: Text(
                                                                  listViewOffersRecord
                                                                      .objectOfferConditions,
                                                                  style: trokaTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Fira Sans',
                                                                        color: Color(
                                                                            0xFFB6B6B6),
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
                                                                      color: Color(
                                                                          0xFFFC4456),
                                                                      size:
                                                                          12.0,
                                                                    ),
                                                                    Text(
                                                                      listViewOffersRecord
                                                                          .objectOfferCidade,
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Color(0xFFB6B6B6),
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      ', ',
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Color(0xFFB6B6B6),
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                    AutoSizeText(
                                                                      listViewOffersRecord
                                                                          .objectOfferBairro,
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Color(0xFFB6B6B6),
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
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
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (listViewOffersRecord
                                                      .objectOfferTitle !=
                                                  null &&
                                              listViewOffersRecord
                                                      .objectOfferTitle !=
                                                  '')
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/logo.svg',
                                                      width: 20.0,
                                                      height: 20.0,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: GradientText(
                                                      'troka por: ',
                                                      style: trokaTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Fira Sans',
                                                            color: Color(
                                                                0xFFFC4456),
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                      colors: [
                                                        Color(0xFFFF5F2B),
                                                        Color(0xFFFF5976)
                                                      ],
                                                      gradientDirection:
                                                          GradientDirection.ltr,
                                                      gradientType:
                                                          GradientType.linear,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      listViewOffersRecord
                                                          .objectInterestTitle,
                                                      maxLines: 2,
                                                      style: trokaTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Fira Sans',
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (listViewOffersRecord
                                                  .offerAccepted ==
                                              false)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          logFirebaseEvent(
                                                              'OFERTAS_PAGE_ACEITAR_BTN_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          await listViewOffersRecord
                                                              .reference
                                                              .update({
                                                            ...createOffersRecordData(
                                                              offerAccepted:
                                                                  true,
                                                              lastMessage: '',
                                                              lastMessageOwner:
                                                                  '',
                                                            ),
                                                            ...mapToFirestore(
                                                              {
                                                                'messageTime':
                                                                    FieldValue
                                                                        .serverTimestamp(),
                                                              },
                                                            ),
                                                          });
                                                        },
                                                        text: 'Aceitar',
                                                        icon: Icon(
                                                          Icons.check_sharp,
                                                          size: 20.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xC72ECC71),
                                                          textStyle: trokaTheme
                                                              .of(context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Fira Sans',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          logFirebaseEvent(
                                                              'OFERTAS_PAGE_RECUSAR_BTN_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Button_backend_call');
                                                          await listViewOffersRecord
                                                              .reference
                                                              .delete();
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          await currentUserReference!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'offers': FieldValue
                                                                    .arrayRemove([
                                                                  listViewOffersRecord
                                                                      .offerId
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          await containerTrokaRecord!
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'offers': FieldValue
                                                                    .arrayRemove([
                                                                  listViewOffersRecord
                                                                      .offerId
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                        },
                                                        text: 'Recusar',
                                                        icon: Icon(
                                                          Icons.close_sharp,
                                                          size: 20.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xC7FF2323),
                                                          textStyle: trokaTheme
                                                              .of(context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Fira Sans',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (listViewOffersRecord
                                                  .offerAccepted ==
                                              true)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_sharp,
                                                    color: Color(0xFF2ECC71),
                                                    size: 24.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Oferta aceita!',
                                                      style: trokaTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Fira Sans',
                                                            color: Color(
                                                                0xFF2ECC71),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'OFERTAS_PAGE_ABRIR_CHAT_BTN_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Button_navigate_to');

                                                            context.pushNamed(
                                                              'chat',
                                                              queryParameters: {
                                                                'offerId':
                                                                    serializeParam(
                                                                  listViewOffersRecord
                                                                      .offerId,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'objectImage':
                                                                    serializeParam(
                                                                  listViewOffersRecord
                                                                      .objectOfferPhoto,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'objectTitle':
                                                                    serializeParam(
                                                                  listViewOffersRecord
                                                                      .objectOfferTitle,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'objectId':
                                                                    serializeParam(
                                                                  listViewOffersRecord
                                                                      .objectOfferId,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          text: 'Abrir chat',
                                                          icon: Icon(
                                                            Icons.chat_outlined,
                                                            color: Color(
                                                                0xFFFC4456),
                                                            size: 20.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.35,
                                                            height: 40.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: Colors.white,
                                                            textStyle:
                                                                trokaTheme
                                                                    .of(context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Fira Sans',
                                                                      color: Color(
                                                                          0xFFFC4456),
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
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
                        );
                      },
                    ),
                  ),
                ),
              if (FFAppState().btnEnviadas)
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                    child: StreamBuilder<List<OffersRecord>>(
                      stream: queryOffersRecord(
                        queryBuilder: (offersRecord) => offersRecord
                            .where(
                              'uidWhoOfferd',
                              isEqualTo: currentUserUid,
                            )
                            .where(
                              'offerAccepted',
                              isEqualTo: false,
                            )
                            .orderBy('offerDateTime', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 200.0, 0.0, 0.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    trokaTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        List<OffersRecord> listViewOffersRecordList =
                            snapshot.data!;
                        if (listViewOffersRecordList.isEmpty) {
                          return EmptySearchTextWidget();
                        }
                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            10.0,
                            0,
                            10.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: listViewOffersRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewOffersRecord =
                                listViewOffersRecordList[listViewIndex];
                            return StreamBuilder<List<TrokaRecord>>(
                              stream: queryTrokaRecord(
                                queryBuilder: (trokaRecord) =>
                                    trokaRecord.where(
                                  'uid',
                                  isEqualTo:
                                      listViewOffersRecord.uidReceivedOffer,
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
                                List<TrokaRecord> containerTrokaRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final containerTrokaRecord =
                                    containerTrokaRecordList.isNotEmpty
                                        ? containerTrokaRecordList.first
                                        : null;
                                return Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.5,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.26,
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
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'OFERTAS_PAGE_Container_sgdhp75s_ON_TAP');
                                                logFirebaseEvent(
                                                    'Container_update_app_state');
                                                FFAppState().objectIdSelected =
                                                    listViewOffersRecord
                                                        .objectInterestId;
                                                logFirebaseEvent(
                                                    'Container_navigate_to');

                                                context.pushNamed(
                                                  'objectPage',
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .bottomToTop,
                                                    ),
                                                  },
                                                );
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.13,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color: Color(0x00FFFFFF),
                                                      width: 0.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
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
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                            child:
                                                                Image.network(
                                                              listViewOffersRecord
                                                                  .objectInterestPhoto,
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
                                                              height: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
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
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              1.0,
                                                                              0.0,
                                                                              0.0,
                                                                              15.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            listViewOffersRecord.objectInterestTitle,
                                                                            maxLines:
                                                                                2,
                                                                            style: trokaTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Fira Sans',
                                                                                  color: Colors.black,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                            minFontSize:
                                                                                14.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          1.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    listViewOffersRecord
                                                                        .objectInteresCategory,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
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
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          1.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    listViewOffersRecord
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
                                                                      color: Color(
                                                                          0xFFFC4456),
                                                                      size:
                                                                          12.0,
                                                                    ),
                                                                    Text(
                                                                      listViewOffersRecord
                                                                          .objectInterestCidade,
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
                                                                    Text(
                                                                      ', ',
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
                                                                    AutoSizeText(
                                                                      listViewOffersRecord
                                                                          .objectInterestBairro,
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
                                                                      minFontSize:
                                                                          8.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (listViewOffersRecord
                                                    .objectOfferTitle !=
                                                null &&
                                            listViewOffersRecord
                                                    .objectOfferTitle !=
                                                '')
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/logo.svg',
                                                    width: 20.0,
                                                    height: 20.0,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: GradientText(
                                                    'troka por: ',
                                                    style: trokaTheme
                                                        .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Fira Sans',
                                                          color:
                                                              Color(0xFFFC4456),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                    colors: [
                                                      Color(0xFFFF5F2B),
                                                      Color(0xFFFF5976)
                                                    ],
                                                    gradientDirection:
                                                        GradientDirection.ltr,
                                                    gradientType:
                                                        GradientType.linear,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    listViewOffersRecord
                                                        .objectOfferTitle,
                                                    maxLines: 2,
                                                    style: trokaTheme
                                                        .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Fira Sans',
                                                          color: Colors.black,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: StreamBuilder<
                                                      List<UserObjectsRecord>>(
                                                    stream:
                                                        queryUserObjectsRecord(
                                                      queryBuilder:
                                                          (userObjectsRecord) =>
                                                              userObjectsRecord
                                                                  .where(
                                                        'objectId',
                                                        isEqualTo:
                                                            listViewOffersRecord
                                                                .objectOfferId,
                                                      ),
                                                      singleRecord: true,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 20.0,
                                                            height: 20.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                Color(
                                                                    0xFFFC4456),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<UserObjectsRecord>
                                                          buttonUserObjectsRecordList =
                                                          snapshot.data!;
                                                      // Return an empty Container when the item does not exist.
                                                      if (snapshot
                                                          .data!.isEmpty) {
                                                        return Container();
                                                      }
                                                      final buttonUserObjectsRecord =
                                                          buttonUserObjectsRecordList
                                                                  .isNotEmpty
                                                              ? buttonUserObjectsRecordList
                                                                  .first
                                                              : null;
                                                      return FFButtonWidget(
                                                        onPressed: () async {
                                                          logFirebaseEvent(
                                                              'OFERTAS_PAGE_DESISTIR_BTN_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Button_backend_call');
                                                          await listViewOffersRecord
                                                              .reference
                                                              .delete();
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          await buttonUserObjectsRecord!
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'offeredSugestionsObjectsId':
                                                                    FieldValue
                                                                        .arrayRemove([
                                                                  listViewOffersRecord
                                                                      .objectInterestId
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          await currentUserReference!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'offers': FieldValue
                                                                    .arrayRemove([
                                                                  listViewOffersRecord
                                                                      .offerId
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          await containerTrokaRecord!
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'offers': FieldValue
                                                                    .arrayRemove([
                                                                  listViewOffersRecord
                                                                      .offerId
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                        },
                                                        text: 'Desistir',
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.35,
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFFE9E9E9),
                                                          textStyle: trokaTheme
                                                              .of(context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Fira Sans',
                                                                color: Color(
                                                                    0xFF999999),
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child: Text(
                                                            dateTimeFormat(
                                                              'dd/MM/y HH:mm',
                                                              listViewOffersRecord
                                                                  .offerDateTime!,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            style: trokaTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Fira Sans',
                                                                  color: Color(
                                                                      0xFFB6B6B6),
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: listViewOffersRecord
                                                                    .offerViewed
                                                                ? Color(
                                                                    0xFF0082FF)
                                                                : Color(
                                                                    0xFFE9E9E9),
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              if (FFAppState().btnEfetuadas)
                Flexible(
                  child: AuthUserStreamWidget(
                    builder: (context) => StreamBuilder<List<OffersRecord>>(
                      stream: queryOffersRecord(
                        queryBuilder: (offersRecord) => offersRecord
                            .where(
                              'offerAccepted',
                              isEqualTo: true,
                            )
                            .whereIn('offerId',
                                (currentUserDocument?.offers?.toList() ?? []))
                            .orderBy('messageTime', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 200.0, 0.0, 0.0),
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    trokaTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        List<OffersRecord> listViewOffersRecordList =
                            snapshot.data!;
                        if (listViewOffersRecordList.isEmpty) {
                          return EmptySearchTextWidget();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            10.0,
                            0,
                            10.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: listViewOffersRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewOffersRecord =
                                listViewOffersRecordList[listViewIndex];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 1.0),
                                  child: StreamBuilder<List<TrokaRecord>>(
                                    stream: queryTrokaRecord(
                                      queryBuilder: (trokaRecord) =>
                                          trokaRecord.where(
                                        'uid',
                                        isEqualTo: listViewOffersRecord
                                                    .uidWhoOfferd ==
                                                currentUserUid
                                            ? listViewOffersRecord
                                                .uidReceivedOffer
                                            : listViewOffersRecord.uidWhoOfferd,
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
                                      List<TrokaRecord>
                                          containerTrokaRecordList =
                                          snapshot.data!;
                                      // Return an empty Container when the item does not exist.
                                      if (snapshot.data!.isEmpty) {
                                        return Container();
                                      }
                                      final containerTrokaRecord =
                                          containerTrokaRecordList.isNotEmpty
                                              ? containerTrokaRecordList.first
                                              : null;
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'OFERTAS_PAGE_Container_8cknjq1t_ON_TAP');
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed(
                                            'chat',
                                            queryParameters: {
                                              'offerId': serializeParam(
                                                listViewOffersRecord.offerId,
                                                ParamType.String,
                                              ),
                                              'objectImage': serializeParam(
                                                listViewOffersRecord
                                                            .uidWhoOfferd ==
                                                        currentUserUid
                                                    ? listViewOffersRecord
                                                        .objectInterestPhoto
                                                    : listViewOffersRecord
                                                        .objectOfferPhoto,
                                                ParamType.String,
                                              ),
                                              'objectTitle': serializeParam(
                                                listViewOffersRecord
                                                            .uidWhoOfferd ==
                                                        currentUserUid
                                                    ? listViewOffersRecord
                                                        .objectInterestTitle
                                                    : listViewOffersRecord
                                                        .objectOfferTitle,
                                                ParamType.String,
                                              ),
                                              'objectId': serializeParam(
                                                listViewOffersRecord
                                                            .uidWhoOfferd ==
                                                        currentUserUid
                                                    ? listViewOffersRecord
                                                        .objectInterestId
                                                    : listViewOffersRecord
                                                        .objectOfferId,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .rightToLeft,
                                              ),
                                            },
                                          );
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.1,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF6F6FB),
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
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              border: Border.all(
                                                color: Color(0x00B6B6B6),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(50.0),
                                                      bottomRight:
                                                          Radius.circular(50.0),
                                                      topLeft:
                                                          Radius.circular(50.0),
                                                      topRight:
                                                          Radius.circular(50.0),
                                                    ),
                                                    child: Image.network(
                                                      () {
                                                        if ((listViewOffersRecord
                                                                    .uidWhoOfferd ==
                                                                currentUserUid) &&
                                                            (listViewOffersRecord
                                                                    .offerCategory !=
                                                                'doação')) {
                                                          return listViewOffersRecord
                                                              .objectInterestPhoto;
                                                        } else if (listViewOffersRecord
                                                                .offerCategory ==
                                                            'doação') {
                                                          return listViewOffersRecord
                                                              .objectInterestPhoto;
                                                        } else {
                                                          return listViewOffersRecord
                                                              .objectOfferPhoto;
                                                        }
                                                      }(),
                                                      width: 60.0,
                                                      height: 60.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    7.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              () {
                                                                if (listViewOffersRecord
                                                                        .uidWhoOfferd ==
                                                                    currentUserUid) {
                                                                  return listViewOffersRecord
                                                                      .objectInterestTitle;
                                                                } else if (listViewOffersRecord
                                                                        .offerCategory ==
                                                                    'doação') {
                                                                  return listViewOffersRecord
                                                                      .objectInterestTitle;
                                                                } else {
                                                                  return listViewOffersRecord
                                                                      .objectOfferTitle;
                                                                }
                                                              }(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: trokaTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Fira Sans',
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            Flexible(
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                if (listViewOffersRecord.lastMessage == null || listViewOffersRecord.lastMessage == '')
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Nenhuma mensagem enviada ainda. Mande uma mensagem agora e combine como vai efetuar a troka!',
                                                                                      maxLines: 3,
                                                                                      style: trokaTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Fira Sans',
                                                                                            color: Color(0xFFB6B6B6),
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                if (listViewOffersRecord.lastMessage != null && listViewOffersRecord.lastMessage != '')
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      listViewOffersRecord.lastMessageOwner == currentUserUid ? 'Você' : containerTrokaRecord?.nickname,
                                                                                      '0',
                                                                                    ),
                                                                                    style: trokaTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Fira Sans',
                                                                                          color: Color(0xFFB6B6B6),
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                if (listViewOffersRecord.lastMessage != null && listViewOffersRecord.lastMessage != '')
                                                                                  Text(
                                                                                    ': ',
                                                                                    style: trokaTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Fira Sans',
                                                                                          color: Color(0xFFB6B6B6),
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                        ),
                                                                                  ),
                                                                                if (listViewOffersRecord.lastMessage != null && listViewOffersRecord.lastMessage != '')
                                                                                  Expanded(
                                                                                    child: AutoSizeText(
                                                                                      listViewOffersRecord.lastMessage.maybeHandleOverflow(
                                                                                        maxChars: 70,
                                                                                        replacement: '…',
                                                                                      ),
                                                                                      textAlign: TextAlign.start,
                                                                                      maxLines: 3,
                                                                                      style: trokaTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Fira Sans',
                                                                                            color: Color(0xFFB6B6B6),
                                                                                            fontSize: 14.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                      minFontSize: 12.0,
                                                                                    ),
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
                                                            if (listViewOffersRecord
                                                                        .lastMessage !=
                                                                    null &&
                                                                listViewOffersRecord
                                                                        .lastMessage !=
                                                                    '')
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            dateTimeFormat(
                                                                              'relative',
                                                                              listViewOffersRecord.messageTime,
                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                            ),
                                                                            '0',
                                                                          ),
                                                                          style: trokaTheme
                                                                              .of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Fira Sans',
                                                                                color: Color(0xFFB6B6B6),
                                                                                fontSize: 10.0,
                                                                                letterSpacing: 0.0,
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  indent: 90.0,
                                  endIndent: 20.0,
                                  color: Color(0xFFDDDDDD),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
