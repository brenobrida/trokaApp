import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/random_data_util.dart' as random_data;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'object_offer_model.dart';
export 'object_offer_model.dart';

class ObjectOfferWidget extends StatefulWidget {
  const ObjectOfferWidget({
    super.key,
    required this.objectUid,
    required this.objectCategoriesInterest,
    required this.podeTrokar,
    required this.anyCategory,
  });

  final String? objectUid;
  final List<String>? objectCategoriesInterest;
  final bool? podeTrokar;
  final bool? anyCategory;

  @override
  State<ObjectOfferWidget> createState() => _ObjectOfferWidgetState();
}

class _ObjectOfferWidgetState extends State<ObjectOfferWidget> {
  late ObjectOfferModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ObjectOfferModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('OBJECT_OFFER_COMP_Stack_wwu7c309_ON_TAP');
        logFirebaseEvent('Stack_navigate_back');
        context.safePop();
      },
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!widget.podeTrokar!)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 25.0, 25.0, 10.0),
                            child: Text(
                              'Você não possui nenhum objeto das categorias aceitas em troka:',
                              textAlign: TextAlign.center,
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (widget.podeTrokar ?? true)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.podeTrokar ?? true)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 25.0, 25.0, 10.0),
                              child: Text(
                                'Selecione um objeto para oferecer:',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if ((widget.podeTrokar == true) &&
                      (widget.anyCategory == false))
                    Flexible(
                      child: StreamBuilder<List<UserObjectsRecord>>(
                        stream: queryUserObjectsRecord(
                          queryBuilder: (userObjectsRecord) => userObjectsRecord
                              .whereIn('objectCategory',
                                  widget.objectCategoriesInterest)
                              .where(
                                'uid',
                                isEqualTo: currentUserUid,
                              )
                              .orderBy('title'),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: SpinKitSquareCircle(
                                  color: trokaTheme.of(context).primary,
                                  size: 40.0,
                                ),
                              ),
                            );
                          }
                          List<UserObjectsRecord>
                              listViewUserObjectsRecordList = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewUserObjectsRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewUserObjectsRecord =
                                  listViewUserObjectsRecordList[listViewIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  StreamBuilder<List<TrokaRecord>>(
                                    stream: queryTrokaRecord(
                                      queryBuilder: (trokaRecord) =>
                                          trokaRecord.where(
                                        'uid',
                                        isEqualTo: widget.objectUid,
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
                                              'OBJECT_OFFER_Container_vz54t9b1_ON_TAP');
                                          logFirebaseEvent(
                                              'Container_update_component_state');
                                          _model.offerId =
                                              random_data.randomString(
                                            8,
                                            8,
                                            true,
                                            true,
                                            true,
                                          );
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          await OffersRecord.collection
                                              .doc()
                                              .set(createOffersRecordData(
                                                offerDateTime:
                                                    getCurrentTimestamp,
                                                uidWhoOfferd: currentUserUid,
                                                objectOfferId:
                                                    listViewUserObjectsRecord
                                                        .objectId,
                                                objectOfferTitle:
                                                    listViewUserObjectsRecord
                                                        .title,
                                                objectOfferCategory:
                                                    listViewUserObjectsRecord
                                                        .objectCategory,
                                                objectOfferConditions:
                                                    listViewUserObjectsRecord
                                                        .objectConditions,
                                                objectOfferCidade:
                                                    listViewUserObjectsRecord
                                                        .cidade,
                                                objectOfferBairro:
                                                    listViewUserObjectsRecord
                                                        .bairro,
                                                objectOfferPhoto:
                                                    listViewUserObjectsRecord
                                                        .photo1,
                                                offerId: _model.offerId,
                                                uidReceivedOffer: FFAppState()
                                                    .objectInterestUid,
                                                objectInterestPhoto:
                                                    FFAppState()
                                                        .objectInterestPhoto,
                                                objectInterestTitle:
                                                    FFAppState()
                                                        .objectInterestTitle,
                                                offerViewed: false,
                                                objectInteresCategory:
                                                    FFAppState()
                                                        .objectInterestCategory,
                                                objectInterestConditions:
                                                    FFAppState()
                                                        .objectInterestConditions,
                                                objectInterestId: FFAppState()
                                                    .objectInterestId,
                                                objectInterestCidade:
                                                    FFAppState()
                                                        .objectInterestCidade,
                                                objectInterestBairro:
                                                    FFAppState()
                                                        .objectInterestBairro,
                                                offerAccepted: false,
                                              ));
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          await containerTrokaRecord!.reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'offers': FieldValue.arrayUnion(
                                                    [_model.offerId]),
                                              },
                                            ),
                                          });
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          await currentUserReference!.update({
                                            ...mapToFirestore(
                                              {
                                                'offers': FieldValue.arrayUnion(
                                                    [_model.offerId]),
                                              },
                                            ),
                                          });
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed('explorar');

                                          logFirebaseEvent(
                                              'Container_update_component_state');
                                          _model.offerId = '0';
                                          logFirebaseEvent(
                                              'Container_update_app_state');
                                          FFAppState().objectInterestUid = '';
                                          FFAppState().objectInterestPhoto = '';
                                          FFAppState().objectInterestTitle = '';
                                          FFAppState().objectInterestCategory =
                                              '';
                                          FFAppState()
                                              .objectInterestConditions = '';
                                          FFAppState().objectInterestCidade =
                                              '';
                                          FFAppState().objectInterestBairro =
                                              '';
                                          FFAppState().objectInterestId = '';
                                          logFirebaseEvent(
                                              'Container_show_snack_bar');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Oferta realizada com sucesso!',
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
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.15,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        listViewUserObjectsRecord
                                                            .photo1,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.4,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                1.0,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                          'assets/images/error_image.png',
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  1.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  5.0,
                                                                  5.0),
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
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, -1.0),
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
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      listViewUserObjectsRecord
                                                                          .title,
                                                                      maxLines:
                                                                          2,
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                      minFontSize:
                                                                          14.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, -1.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child:
                                                                  AutoSizeText(
                                                                listViewUserObjectsRecord
                                                                    .objectCategory,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 2,
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
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                minFontSize:
                                                                    12.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.0, 1.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    'relative',
                                                                    listViewUserObjectsRecord
                                                                        .dateAndTime,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  'error',
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
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
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
                                      );
                                    },
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    indent: 10.0,
                                    endIndent: 10.0,
                                    color: Color(0xFFDDDDDD),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  if (widget.anyCategory == true)
                    Flexible(
                      child: StreamBuilder<List<UserObjectsRecord>>(
                        stream: queryUserObjectsRecord(
                          queryBuilder: (userObjectsRecord) => userObjectsRecord
                              .where(
                                'uid',
                                isEqualTo: currentUserUid,
                              )
                              .orderBy('title'),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: SpinKitSquareCircle(
                                  color: trokaTheme.of(context).primary,
                                  size: 40.0,
                                ),
                              ),
                            );
                          }
                          List<UserObjectsRecord>
                              listViewUserObjectsRecordList = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewUserObjectsRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewUserObjectsRecord =
                                  listViewUserObjectsRecordList[listViewIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  StreamBuilder<List<TrokaRecord>>(
                                    stream: queryTrokaRecord(
                                      queryBuilder: (trokaRecord) =>
                                          trokaRecord.where(
                                        'uid',
                                        isEqualTo: widget.objectUid,
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
                                              'OBJECT_OFFER_Container_szrtsqa1_ON_TAP');
                                          logFirebaseEvent(
                                              'Container_update_component_state');
                                          _model.offerId =
                                              random_data.randomString(
                                            8,
                                            8,
                                            true,
                                            true,
                                            true,
                                          );
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          await OffersRecord.collection
                                              .doc()
                                              .set(createOffersRecordData(
                                                offerDateTime:
                                                    getCurrentTimestamp,
                                                uidWhoOfferd: currentUserUid,
                                                objectOfferId:
                                                    listViewUserObjectsRecord
                                                        .objectId,
                                                objectOfferTitle:
                                                    listViewUserObjectsRecord
                                                        .title,
                                                objectOfferCategory:
                                                    listViewUserObjectsRecord
                                                        .objectCategory,
                                                objectOfferConditions:
                                                    listViewUserObjectsRecord
                                                        .objectConditions,
                                                objectOfferCidade:
                                                    listViewUserObjectsRecord
                                                        .cidade,
                                                objectOfferBairro:
                                                    listViewUserObjectsRecord
                                                        .bairro,
                                                objectOfferPhoto:
                                                    listViewUserObjectsRecord
                                                        .photo1,
                                                offerId: _model.offerId,
                                                uidReceivedOffer: FFAppState()
                                                    .objectInterestUid,
                                                objectInterestPhoto:
                                                    FFAppState()
                                                        .objectInterestPhoto,
                                                objectInterestTitle:
                                                    FFAppState()
                                                        .objectInterestTitle,
                                                offerViewed: false,
                                                objectInteresCategory:
                                                    FFAppState()
                                                        .objectInterestCategory,
                                                objectInterestConditions:
                                                    FFAppState()
                                                        .objectInterestConditions,
                                                objectInterestId: FFAppState()
                                                    .objectInterestId,
                                                objectInterestCidade:
                                                    FFAppState()
                                                        .objectInterestCidade,
                                                objectInterestBairro:
                                                    FFAppState()
                                                        .objectInterestBairro,
                                                offerAccepted: false,
                                              ));
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          await containerTrokaRecord!.reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'offers': FieldValue.arrayUnion(
                                                    [_model.offerId]),
                                              },
                                            ),
                                          });
                                          logFirebaseEvent(
                                              'Container_backend_call');

                                          await currentUserReference!.update({
                                            ...mapToFirestore(
                                              {
                                                'offers': FieldValue.arrayUnion(
                                                    [_model.offerId]),
                                              },
                                            ),
                                          });
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed('explorar');

                                          logFirebaseEvent(
                                              'Container_update_component_state');
                                          _model.offerId = '0';
                                          logFirebaseEvent(
                                              'Container_update_app_state');
                                          FFAppState().objectInterestUid = '';
                                          FFAppState().objectInterestPhoto = '';
                                          FFAppState().objectInterestTitle = '';
                                          FFAppState().objectInterestCategory =
                                              '';
                                          FFAppState()
                                              .objectInterestConditions = '';
                                          FFAppState().objectInterestCidade =
                                              '';
                                          FFAppState().objectInterestBairro =
                                              '';
                                          FFAppState().objectInterestId = '';
                                          logFirebaseEvent(
                                              'Container_show_snack_bar');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Oferta realizada com sucesso!',
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
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.15,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        listViewUserObjectsRecord
                                                            .photo1,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.4,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                1.0,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                          'assets/images/error_image.png',
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  1.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  5.0,
                                                                  5.0),
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
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, -1.0),
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
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      listViewUserObjectsRecord
                                                                          .title,
                                                                      maxLines:
                                                                          2,
                                                                      style: trokaTheme
                                                                          .of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Fira Sans',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                      minFontSize:
                                                                          14.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, -1.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child:
                                                                  AutoSizeText(
                                                                listViewUserObjectsRecord
                                                                    .objectCategory,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 2,
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
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                minFontSize:
                                                                    12.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.0, 1.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    'relative',
                                                                    listViewUserObjectsRecord
                                                                        .dateAndTime,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  'error',
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
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
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
                                      );
                                    },
                                  ),
                                  if (widget.podeTrokar ?? true)
                                    Divider(
                                      thickness: 0.5,
                                      indent: 10.0,
                                      endIndent: 10.0,
                                      color: Color(0xFFDDDDDD),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  if (!widget.podeTrokar!)
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final categories =
                              widget.objectCategoriesInterest!.toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: categories.length,
                            itemBuilder: (context, categoriesIndex) {
                              final categoriesItem =
                                  categories[categoriesIndex];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '- ',
                                    style: trokaTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Text(
                                    categoriesItem,
                                    textAlign: TextAlign.start,
                                    style: trokaTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 14.0,
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
                  if (!widget.podeTrokar!)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 50.0, 0.0, 0.0),
                              child: Text(
                                'Cadastre agora mesmo!',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!widget.podeTrokar!)
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'OBJECT_OFFER_COMP_INSERIR_BTN_ON_TAP');
                            logFirebaseEvent('Button_navigate_to');

                            context.pushNamed('inserir');
                          },
                          text: 'Inserir',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFFC4456),
                            textStyle:
                                trokaTheme.of(context).titleSmall.override(
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
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
