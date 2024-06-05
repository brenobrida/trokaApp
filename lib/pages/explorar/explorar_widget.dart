import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_toggle_icon.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_search/text_search.dart';
import 'explorar_model.dart';
export 'explorar_model.dart';

class ExplorarWidget extends StatefulWidget {
  const ExplorarWidget({super.key});

  @override
  State<ExplorarWidget> createState() => _ExplorarWidgetState();
}

class _ExplorarWidgetState extends State<ExplorarWidget> {
  late ExplorarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExplorarModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'explorar'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EXPLORAR_PAGE_explorar_ON_INIT_STATE');
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      logFirebaseEvent('explorar_update_app_state');
      setState(() {
        FFAppState().userFavoriteObjetcs =
            (currentUserDocument?.favoriteObjects?.toList() ?? [])
                .toList()
                .cast<String>();
        FFAppState().listOfInterests = [];
      });
      logFirebaseEvent('explorar_update_app_state');
      FFAppState().objectInterestUid = '';
      FFAppState().objectInterestPhoto = '';
      FFAppState().objectInterestTitle = '';
      FFAppState().objectInterestCategory = '';
      FFAppState().objectInterestConditions = '';
      FFAppState().objectInterestCidade = '';
      FFAppState().objectInterestBairro = '';
      FFAppState().objectInterestId = '';
      logFirebaseEvent('explorar_update_app_state');
      setState(() {
        FFAppState().lat = functions.getLat(currentUserLocationValue)!;
        FFAppState().lng = functions.getLng(currentUserLocationValue)!;
      });
      logFirebaseEvent('explorar_backend_call');
      _model.apiCidadeLoc = await BuscaCidadeViaLocCall.call(
        lat: FFAppState().lat,
        lon: FFAppState().lng,
      );
      if ((_model.apiCidadeLoc?.succeeded ?? true)) {
        logFirebaseEvent('explorar_update_app_state');
        setState(() {
          FFAppState().cidadeViaLoc = getJsonField(
            (_model.apiCidadeLoc?.jsonBody ?? ''),
            r'''$.address.city''',
          ).toString().toString();
        });
        return;
      } else {
        return;
      }
    });

    _model.searchFieldTextController ??= TextEditingController();
    _model.searchFieldFocusNode ??= FocusNode();
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
        queryBuilder: (userObjectsRecord) => userObjectsRecord
            .where(
              'available',
              isEqualTo: true,
            )
            .orderBy('dateAndTime', descending: true),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFC4456),
                  ),
                ),
              ),
            ),
          );
        }
        List<UserObjectsRecord> explorarUserObjectsRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3.0,
                    child: SafeArea(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 0.0, 25.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 6,
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.65,
                                  child: TextFormField(
                                    controller:
                                        _model.searchFieldTextController,
                                    focusNode: _model.searchFieldFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.searchFieldTextController',
                                      Duration(milliseconds: 0),
                                      () async {
                                        logFirebaseEvent(
                                            'EXPLORAR_searchField_ON_TEXTFIELD_CHANGE');
                                        logFirebaseEvent(
                                            'searchField_simple_search');
                                        safeSetState(() {
                                          _model.simpleSearchResults =
                                              TextSearch(
                                            explorarUserObjectsRecordList
                                                .map(
                                                  (record) =>
                                                      TextSearchItem.fromTerms(
                                                          record, [
                                                    record.title!,
                                                    record.description!,
                                                    record.objectCategory!
                                                  ]),
                                                )
                                                .toList(),
                                          )
                                                  .search(_model
                                                      .searchFieldTextController
                                                      .text)
                                                  .map((r) => r.object)
                                                  .take(30)
                                                  .toList();
                                          ;
                                        });
                                      },
                                    ),
                                    autofocus: false,
                                    textCapitalization: TextCapitalization.none,
                                    textInputAction: TextInputAction.done,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
                                      hintText: 'Busque o que deseja trokar!',
                                      hintStyle: trokaTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Fira Sans',
                                            color: Color(0xFFB6B6B6),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00B6B6B6),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00FC4456),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(
                                        Icons.search_outlined,
                                        color: Colors.black,
                                        size: 30.0,
                                      ),
                                    ),
                                    style: trokaTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                        ),
                                    textAlign: TextAlign.start,
                                    maxLength: 30,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    buildCounter: (context,
                                            {required currentLength,
                                            required isFocused,
                                            maxLength}) =>
                                        null,
                                    validator: _model
                                        .searchFieldTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EXPLORAR_PAGE_Icon_imn0vrnz_ON_TAP');
                                    logFirebaseEvent('Icon_navigate_to');

                                    context.pushNamed('filtro');
                                  },
                                  child: Icon(
                                    Icons.filter_alt_outlined,
                                    color: FFAppState().isFiltered == true
                                        ? Color(0xFFFC4456)
                                        : Color(0xFFB0B0B0),
                                    size: 35.0,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: badges.Badge(
                                  badgeContent: Text(
                                    '1',
                                    style: trokaTheme
                                        .of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  showBadge: true,
                                  shape: badges.BadgeShape.circle,
                                  badgeColor: Color(0xFFFC4456),
                                  elevation: 4.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 8.0, 8.0, 8.0),
                                  position: badges.BadgePosition.topEnd(),
                                  animationType:
                                      badges.BadgeAnimationType.scale,
                                  toAnimate: true,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'EXPLORAR_PAGE_Icon_go3tf3gp_ON_TAP');
                                      logFirebaseEvent('Icon_navigate_to');

                                      context.pushNamed(
                                        'notifications',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.rightToLeft,
                                          ),
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.notifications_none_rounded,
                                      color: Color(0xFFB0B0B0),
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Builder(
                      builder: (context) {
                        final objects = (_model.searchFieldTextController.text != null &&
                                    _model.searchFieldTextController.text != ''
                                ? _model.simpleSearchResults
                                    .where((e) =>
                                        (currentUserUid != e.uid) &&
                                        (FFAppState().filterChoice != null && FFAppState().filterChoice != ''
                                            ? (e.negotiationType ==
                                                FFAppState().filterChoice)
                                            : true) &&
                                        (FFAppState().filterObjectCategory != null && FFAppState().filterObjectCategory != ''
                                            ? (e.objectCategory ==
                                                FFAppState()
                                                    .filterObjectCategory)
                                            : true) &&
                                        (FFAppState()
                                                .filterObjectInterest
                                                .isNotEmpty
                                            ? ((List<String> var1,
                                                    List<String>? var2) {
                                                return var1.any((item) =>
                                                    var2 != null &&
                                                    var2.contains(item));
                                              }(
                                                e.objectCategoryInterest
                                                    .toList(),
                                                FFAppState()
                                                    .filterObjectInterest
                                                    .toList()))
                                            : true) &&
                                        (FFAppState().filterObjectCondition.isNotEmpty
                                            ? (FFAppState()
                                                .filterObjectCondition
                                                .toList()
                                                .contains(e.objectConditions))
                                            : true) &&
                                        () {
                                          if ((FFAppState().filterCity ==
                                                      null ||
                                                  FFAppState().filterCity ==
                                                      '') &&
                                              (FFAppState().filterUF != null &&
                                                  FFAppState().filterUF !=
                                                      '')) {
                                            return (FFAppState()
                                                .citiesList
                                                .toList()
                                                .contains(e.cidade));
                                          } else if (FFAppState().filterUF ==
                                                  null ||
                                              FFAppState().filterUF == '') {
                                            return (e.cidade ==
                                                (FFAppState().filterCity !=
                                                            null &&
                                                        FFAppState()
                                                                .filterCity !=
                                                            ''
                                                    ? FFAppState().filterCity
                                                    : FFAppState()
                                                        .cidadeViaLoc));
                                          } else {
                                            return (e.cidade ==
                                                FFAppState().filterCity);
                                          }
                                        }())
                                    .toList()
                                : explorarUserObjectsRecordList
                                    .where((e) =>
                                        (currentUserUid != e.uid) &&
                                        (FFAppState().filterChoice != null &&
                                                FFAppState().filterChoice != ''
                                            ? (e.negotiationType ==
                                                FFAppState().filterChoice)
                                            : true) &&
                                        (FFAppState().filterObjectCategory != null &&
                                                FFAppState().filterObjectCategory != ''
                                            ? (e.objectCategory == FFAppState().filterObjectCategory)
                                            : true) &&
                                        (FFAppState().filterObjectInterest.isNotEmpty
                                            ? ((List<String> var1, List<String>? var2) {
                                                return var1.any((item) =>
                                                    var2 != null &&
                                                    var2.contains(item));
                                              }(e.objectCategoryInterest.toList(), FFAppState().filterObjectInterest.toList()))
                                            : true) &&
                                        (FFAppState().filterObjectCondition.isNotEmpty ? (FFAppState().filterObjectCondition.toList().contains(e.objectConditions)) : true) &&
                                        () {
                                          if ((FFAppState().filterCity ==
                                                      null ||
                                                  FFAppState().filterCity ==
                                                      '') &&
                                              (FFAppState().filterUF != null &&
                                                  FFAppState().filterUF !=
                                                      '')) {
                                            return (FFAppState()
                                                .citiesList
                                                .toList()
                                                .contains(e.cidade));
                                          } else if (FFAppState().filterUF ==
                                                  null ||
                                              FFAppState().filterUF == '') {
                                            return (e.cidade ==
                                                (FFAppState().filterCity !=
                                                            null &&
                                                        FFAppState()
                                                                .filterCity !=
                                                            ''
                                                    ? FFAppState().filterCity
                                                    : FFAppState()
                                                        .cidadeViaLoc));
                                          } else {
                                            return (e.cidade ==
                                                FFAppState().filterCity);
                                          }
                                        }())
                                    .toList())
                            .toList();
                        if (objects.isEmpty) {
                          return Center(
                            child: EmptySearchTextWidget(),
                          );
                        }
                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            10.0,
                            0,
                            25.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: objects.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.0),
                          itemBuilder: (context, objectsIndex) {
                            final objectsItem = objects[objectsIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 0.0, 25.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'EXPLORAR_PAGE_Container_v5o3j9tg_ON_TAP');
                                  logFirebaseEvent(
                                      'Container_update_app_state');
                                  FFAppState().objectIdSelected =
                                      objectsItem.objectId;
                                  logFirebaseEvent(
                                      'Container_update_app_state');
                                  FFAppState().photo0 = objectsItem.photo0;
                                  FFAppState().photo1 = objectsItem.photo1;
                                  FFAppState().photo2 = objectsItem.photo2;
                                  FFAppState().photo3 = objectsItem.photo3;
                                  FFAppState().photo4 = objectsItem.photo4;
                                  FFAppState().photo5 = objectsItem.photo5;
                                  logFirebaseEvent(
                                      'Container_update_app_state');
                                  FFAppState().objectInterestUid =
                                      objectsItem.uid;
                                  FFAppState().objectInterestPhoto =
                                      objectsItem.photo1;
                                  FFAppState().objectInterestTitle =
                                      objectsItem.title;
                                  FFAppState().objectInterestCategory =
                                      objectsItem.objectCategory;
                                  FFAppState().objectInterestConditions =
                                      objectsItem.objectConditions;
                                  FFAppState().objectInterestCidade =
                                      objectsItem.cidade;
                                  FFAppState().objectInterestBairro =
                                      objectsItem.bairro;
                                  FFAppState().objectInterestId =
                                      objectsItem.objectId;
                                  logFirebaseEvent('Container_navigate_to');

                                  context.pushNamed(
                                    'objectPage',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.bottomToTop,
                                      ),
                                    },
                                  );
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    constraints: BoxConstraints(
                                      minWidth: 100.0,
                                      minHeight:
                                          MediaQuery.sizeOf(context).height *
                                              0.3,
                                      maxWidth: 100.0,
                                      maxHeight:
                                          MediaQuery.sizeOf(context).height *
                                              0.4,
                                    ),
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
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                              child: Image.network(
                                                objectsItem.photo1,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.25,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  'assets/images/error_image.png',
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.25,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 5.0, 0.0),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 0.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                      ),
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  2.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: ToggleIcon(
                                                        onPressed: () async {
                                                          setState(
                                                            () => FFAppState()
                                                                    .userFavoriteObjetcs
                                                                    .contains(
                                                                        objectsItem
                                                                            .objectId)
                                                                ? FFAppState()
                                                                    .removeFromUserFavoriteObjetcs(
                                                                        objectsItem
                                                                            .objectId)
                                                                : FFAppState()
                                                                    .addToUserFavoriteObjetcs(
                                                                        objectsItem
                                                                            .objectId),
                                                          );
                                                          logFirebaseEvent(
                                                              'EXPLORAR_ToggleIcon_9v7koute_ON_TOGGLE');
                                                          if ((currentUserDocument
                                                                      ?.favoriteObjects
                                                                      ?.toList() ??
                                                                  [])
                                                              .contains(objectsItem
                                                                  .objectId)) {
                                                            logFirebaseEvent(
                                                                'ToggleIcon_backend_call');

                                                            await currentUserReference!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'favoriteObjects':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    objectsItem
                                                                        .objectId
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
                                                                    objectsItem
                                                                        .objectId
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                          }
                                                        },
                                                        value: FFAppState()
                                                            .userFavoriteObjetcs
                                                            .contains(
                                                                objectsItem
                                                                    .objectId),
                                                        onIcon: Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          color:
                                                              Color(0xFFFC4456),
                                                          size: 20.0,
                                                        ),
                                                        offIcon: Icon(
                                                          Icons
                                                              .favorite_border_rounded,
                                                          color: Colors.black,
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 10.0, 10.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: AutoSizeText(
                                                  objectsItem.title,
                                                  maxLines: 1,
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
                                                  minFontSize: 12.0,
                                                ),
                                              ),
                                              Text(
                                                ' | ',
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
                                              AutoSizeText(
                                                objectsItem.objectCategory,
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
                                                minFontSize: 8.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 5.0, 10.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                objectsItem.objectConditions,
                                                style: trokaTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Fira Sans',
                                                      color: Color(0xFFB6B6B6),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Icon(
                                                  Icons.location_pin,
                                                  color: Color(0xFFFC4456),
                                                  size: 12.0,
                                                ),
                                              ),
                                              Text(
                                                objectsItem.cidade,
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
                                              Text(
                                                ', ',
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
                                              Text(
                                                objectsItem.bairro,
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 2.0, 10.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              if (objectsItem.negotiationType ==
                                                  'troka')
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/logo.svg',
                                                          width: 15.0,
                                                          height: 15.0,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: GradientText(
                                                          'troka',
                                                          style: trokaTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Fira Sans',
                                                                color: Color(
                                                                    0xFFFC4456),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                          colors: [
                                                            Color(0xFFFF5F2B),
                                                            Color(0xFFFF5976)
                                                          ],
                                                          gradientDirection:
                                                              GradientDirection
                                                                  .ltr,
                                                          gradientType:
                                                              GradientType
                                                                  .linear,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (objectsItem.negotiationType ==
                                                  'doação')
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: Image.asset(
                                                          'assets/images/heart.png',
                                                          width: 15.0,
                                                          height: 15.0,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Doação',
                                                          style: trokaTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Fira Sans',
                                                                color: Color(
                                                                    0xFFFC4456),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat(
                                                    'relative',
                                                    objectsItem.dateAndTime,
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
                                                      fontFamily: 'Fira Sans',
                                                      color: Color(0xFFB6B6B6),
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
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
