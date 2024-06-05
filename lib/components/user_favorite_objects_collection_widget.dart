import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_toggle_icon.dart';
import '/troka/troka_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'user_favorite_objects_collection_model.dart';
export 'user_favorite_objects_collection_model.dart';

class UserFavoriteObjectsCollectionWidget extends StatefulWidget {
  const UserFavoriteObjectsCollectionWidget({
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
  State<UserFavoriteObjectsCollectionWidget> createState() =>
      _UserFavoriteObjectsCollectionWidgetState();
}

class _UserFavoriteObjectsCollectionWidgetState
    extends State<UserFavoriteObjectsCollectionWidget> {
  late UserFavoriteObjectsCollectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserFavoriteObjectsCollectionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<UserObjectsRecord>>(
        stream: queryUserObjectsRecord(
          queryBuilder: (userObjectsRecord) => userObjectsRecord.whereIn(
              'objectId',
              (currentUserDocument?.favoriteObjects?.toList() ?? []) != ''
                  ? (currentUserDocument?.favoriteObjects?.toList() ?? [])
                  : null),
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
          List<UserObjectsRecord> listViewUserObjectsRecordList =
              snapshot.data!;
          if (listViewUserObjectsRecordList.isEmpty) {
            return Center(
              child: EmptySearchTextWidget(),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: listViewUserObjectsRecordList.length,
            itemBuilder: (context, listViewIndex) {
              final listViewUserObjectsRecord =
                  listViewUserObjectsRecordList[listViewIndex];
              return Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 5.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'USER_FAVORITE_OBJECTS_COLLECTION_Contain');
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
                  },
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(0.0),
                                    ),
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
                                      0.0, 5.0, 10.0, 5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: AutoSizeText(
                                          listViewUserObjectsRecord.title,
                                          maxLines: 1,
                                          style: trokaTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Fira Sans',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          minFontSize: 14.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
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
                                                fontWeight: FontWeight.w500,
                                              ),
                                          minFontSize: 12.0,
                                        ),
                                      ),
                                      Padding(
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
                                                color: Color(0xFF5D5D5D),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              listViewUserObjectsRecord.cidade,
                                              style: trokaTheme
                                                  .of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Fira Sans',
                                                    color: Color(0xFF5D5D5D),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Text(
                                              ', ',
                                              style: trokaTheme
                                                  .of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Fira Sans',
                                                    color: Color(0xFF5D5D5D),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Text(
                                              listViewUserObjectsRecord.bairro,
                                              style: trokaTheme
                                                  .of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Fira Sans',
                                                    color: Color(0xFF5D5D5D),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (listViewUserObjectsRecord
                                              .negotiationType ==
                                          'troka')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 5.0),
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
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: GradientText(
                                                  'troka',
                                                  style: trokaTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Fira Sans',
                                                        color:
                                                            Color(0xFFFC4456),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 5.0),
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
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Doação',
                                                  style: trokaTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Fira Sans',
                                                        color:
                                                            Color(0xFFFC4456),
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
                                      Padding(
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
                                                color: Color(0xFF5D5D5D),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            child: ToggleIcon(
                              onPressed: () async {
                                setState(
                                  () => FFAppState()
                                          .userFavoriteObjetcs
                                          .contains(listViewUserObjectsRecord
                                              .objectId)
                                      ? FFAppState()
                                          .removeFromUserFavoriteObjetcs(
                                              listViewUserObjectsRecord
                                                  .objectId)
                                      : FFAppState().addToUserFavoriteObjetcs(
                                          listViewUserObjectsRecord.objectId),
                                );
                                logFirebaseEvent(
                                    'USER_FAVORITE_OBJECTS_COLLECTION_ToggleI');
                                logFirebaseEvent('ToggleIcon_backend_call');

                                await currentUserReference!.update({
                                  ...mapToFirestore(
                                    {
                                      'favoriteObjects': FieldValue.arrayRemove(
                                          [listViewUserObjectsRecord.objectId]),
                                    },
                                  ),
                                });
                                logFirebaseEvent('ToggleIcon_update_app_state');
                                setState(() {
                                  FFAppState().removeFromUserFavoriteObjetcs(
                                      listViewUserObjectsRecord.objectId);
                                });
                              },
                              value: FFAppState()
                                  .userFavoriteObjetcs
                                  .contains(listViewUserObjectsRecord.objectId),
                              onIcon: Icon(
                                Icons.favorite_rounded,
                                color: Color(0xFFFC4456),
                                size: 25.0,
                              ),
                              offIcon: Icon(
                                Icons.favorite_border_rounded,
                                color: Color(0xFFB6B6B6),
                                size: 25.0,
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
          );
        },
      ),
    );
  }
}
