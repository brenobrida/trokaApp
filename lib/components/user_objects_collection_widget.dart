import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'user_objects_collection_model.dart';
export 'user_objects_collection_model.dart';

class UserObjectsCollectionWidget extends StatefulWidget {
  const UserObjectsCollectionWidget({
    super.key,
    this.parameter1,
    this.parameter2,
    this.parameter3,
    this.parameter4,
    this.parameter5,
    this.parameter6,
    this.parameter7,
  });

  final String? parameter1;
  final String? parameter2;
  final String? parameter3;
  final String? parameter4;
  final String? parameter5;
  final String? parameter6;
  final List<UserObjectsRecord>? parameter7;

  @override
  State<UserObjectsCollectionWidget> createState() =>
      _UserObjectsCollectionWidgetState();
}

class _UserObjectsCollectionWidgetState
    extends State<UserObjectsCollectionWidget> {
  late UserObjectsCollectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserObjectsCollectionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserObjectsRecord>>(
      stream: _model.userObjectsCollection(
        requestFn: () => queryUserObjectsRecord(
          queryBuilder: (userObjectsRecord) => userObjectsRecord
              .where(
                'uid',
                isEqualTo: currentUserUid,
              )
              .orderBy('title'),
        ),
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
        List<UserObjectsRecord> listViewUserObjectsRecordList = snapshot.data!;
        if (listViewUserObjectsRecordList.isEmpty) {
          return EmptySearchTextWidget();
        }
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'USER_OBJECTS_COLLECTION_Container_dx53k1');
                      logFirebaseEvent('Container_update_app_state');
                      FFAppState().objectIdSelected =
                          listViewUserObjectsRecord.objectId;
                      logFirebaseEvent('Container_update_app_state');
                      setState(() {
                        FFAppState().photo0 = listViewUserObjectsRecord.photo0;
                        FFAppState().photo1 = listViewUserObjectsRecord.photo1;
                        FFAppState().photo2 = listViewUserObjectsRecord.photo2;
                        FFAppState().photo3 = listViewUserObjectsRecord.photo3;
                        FFAppState().photo4 = listViewUserObjectsRecord.photo4;
                        FFAppState().photo5 = listViewUserObjectsRecord.photo5;
                      });
                      logFirebaseEvent('Container_navigate_to');

                      context.pushNamed('objectPage');
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    listViewUserObjectsRecord.photo1,
                                    width: 170.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/error_image.png',
                                      width: 170.0,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, -1.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: AutoSizeText(
                                                  listViewUserObjectsRecord
                                                      .title,
                                                  maxLines: 2,
                                                  style: trokaTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Fira Sans',
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  minFontSize: 14.0,
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
                                                  'USER_OBJECTS_COLLECTION_Icon_obdyvxeq_ON');
                                              logFirebaseEvent(
                                                  'Icon_update_app_state');
                                              FFAppState().objectIdSelected =
                                                  listViewUserObjectsRecord
                                                      .objectId;
                                              logFirebaseEvent(
                                                  'Icon_update_app_state');
                                              setState(() {
                                                FFAppState().photo0 =
                                                    listViewUserObjectsRecord
                                                        .photo0;
                                                FFAppState().photo1 =
                                                    listViewUserObjectsRecord
                                                        .photo1;
                                                FFAppState().photo2 =
                                                    listViewUserObjectsRecord
                                                        .photo2;
                                                FFAppState().photo3 =
                                                    listViewUserObjectsRecord
                                                        .photo3;
                                                FFAppState().photo4 =
                                                    listViewUserObjectsRecord
                                                        .photo4;
                                                FFAppState().photo5 =
                                                    listViewUserObjectsRecord
                                                        .photo5;
                                              });
                                              logFirebaseEvent(
                                                  'Icon_navigate_to');

                                              context.pushNamed('editar');
                                            },
                                            child: Icon(
                                              Icons.edit_square,
                                              color: Color(0xFFFC4456),
                                              size: 25.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, -1.0),
                                      child: AutoSizeText(
                                        listViewUserObjectsRecord
                                            .objectCategory,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: trokaTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Fira Sans',
                                              color: Colors.black,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        minFontSize: 12.0,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          listViewUserObjectsRecord
                                              .objectConditions,
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFB6B6B6),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          listViewUserObjectsRecord.cidade,
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFB6B6B6),
                                                fontSize: 12.0,
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
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Text(
                                          listViewUserObjectsRecord.bairro,
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFB6B6B6),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                    if (listViewUserObjectsRecord
                                            .negotiationType ==
                                        'troka')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: SvgPicture.asset(
                                                'assets/images/logo.svg',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: GradientText(
                                                'troka',
                                                style: trokaTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Fira Sans',
                                                      color: Color(0xFFFC4456),
                                                      fontSize: 12.0,
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
                                          ],
                                        ),
                                      ),
                                    if (listViewUserObjectsRecord
                                            .negotiationType ==
                                        'doação')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/heart.png',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Doação',
                                                style: trokaTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Fira Sans',
                                                      color: Color(0xFFFC4456),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Align(
                                      alignment: AlignmentDirectional(1.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            dateTimeFormat(
                                              'relative',
                                              listViewUserObjectsRecord
                                                  .dateAndTime,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            'error',
                                          ),
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Color(0xFFB6B6B6),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
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
                ),
                Divider(
                  thickness: 0.5,
                  color: Color(0xFFDDDDDD),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
