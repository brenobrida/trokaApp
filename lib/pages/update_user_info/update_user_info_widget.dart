import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/upload_data.dart';
import '/troka/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'update_user_info_model.dart';
export 'update_user_info_model.dart';

class UpdateUserInfoWidget extends StatefulWidget {
  const UpdateUserInfoWidget({super.key});

  @override
  State<UpdateUserInfoWidget> createState() => _UpdateUserInfoWidgetState();
}

class _UpdateUserInfoWidgetState extends State<UpdateUserInfoWidget> {
  late UpdateUserInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateUserInfoModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'updateUserInfo'});

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldFocusNode3 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            iconTheme: IconThemeData(color: Color(0xFF5D5D5D)),
            automaticallyImplyLeading: true,
            title: Text(
              'Minha Conta',
              style: trokaTheme.of(context).bodyMedium.override(
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
          child: StreamBuilder<List<TrokaRecord>>(
            stream: queryTrokaRecord(
              queryBuilder: (trokaRecord) => trokaRecord.where(
                'uid',
                isEqualTo: currentUserUid,
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
              List<TrokaRecord> columnTrokaRecordList = snapshot.data!;
              // Return an empty Container when the item does not exist.
              if (snapshot.data!.isEmpty) {
                return Container();
              }
              final columnTrokaRecord = columnTrokaRecordList.isNotEmpty
                  ? columnTrokaRecordList.first
                  : null;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'UPDATE_USER_INFO_CircleImage_ffit4ews_ON');
                      logFirebaseEvent('CircleImage_upload_media_to_firebase');
                      final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                        context: context,
                        maxWidth: 2000.00,
                        maxHeight: 3000.00,
                        imageQuality: 70,
                        allowPhoto: true,
                        pickerFontFamily: 'Fira Sans',
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        setState(() => _model.isDataUploading = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        var downloadUrls = <String>[];
                        try {
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                  ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                              (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          _model.isDataUploading = false;
                        }
                        if (selectedUploadedFiles.length ==
                                selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          setState(() {
                            _model.uploadedLocalFile =
                                selectedUploadedFiles.first;
                            _model.uploadedFileUrl = downloadUrls.first;
                          });
                        } else {
                          setState(() {});
                          return;
                        }
                      }

                      logFirebaseEvent('CircleImage_backend_call');

                      await currentUserReference!.update(createTrokaRecordData(
                        photoUrl: _model.uploadedFileUrl,
                      ));
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: MediaQuery.sizeOf(context).width * 0.3,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: columnTrokaRecord!.photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: AuthUserStreamWidget(
                      builder: (context) => Text(
                        currentUserDisplayName,
                        style: trokaTheme.of(context).titleMedium.override(
                              fontFamily: 'Fira Sans',
                              color: Colors.black,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 400.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                55.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '*CPF:',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 10.0),
                              child: Container(
                                width: 104.0,
                                child: TextFormField(
                                  controller: _model.textController1 ??=
                                      TextEditingController(
                                    text: columnTrokaRecord?.cpf,
                                  ),
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: true,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintStyle: trokaTheme
                                        .of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          lineHeight: 6.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF0000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF0000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                  ),
                                  style: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                  textAlign: TextAlign.start,
                                  maxLength: 14,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType: TextInputType.number,
                                  validator: _model.textController1Validator
                                      .asValidator(context),
                                  inputFormatters: [_model.textFieldMask1],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 400.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '*Apelido:',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 10.0),
                              child: Container(
                                width: 130.0,
                                child: TextFormField(
                                  controller: _model.textController2 ??=
                                      TextEditingController(
                                    text: columnTrokaRecord?.nickname,
                                  ),
                                  focusNode: _model.textFieldFocusNode2,
                                  autofocus: true,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintStyle: trokaTheme
                                        .of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          lineHeight: 6.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF0000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF0000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                  ),
                                  style: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                  textAlign: TextAlign.start,
                                  maxLength: 15,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  validator: _model.textController2Validator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 400.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                28.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '*Celular:',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 10.0),
                              child: Container(
                                width: 120.0,
                                child: TextFormField(
                                  controller: _model.textController3 ??=
                                      TextEditingController(
                                    text: columnTrokaRecord?.phoneNumber,
                                  ),
                                  focusNode: _model.textFieldFocusNode3,
                                  autofocus: true,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintStyle: trokaTheme
                                        .of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          lineHeight: 6.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF0000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF0000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                  ),
                                  style: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                  textAlign: TextAlign.start,
                                  maxLength: 15,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType: TextInputType.number,
                                  validator: _model.textController3Validator
                                      .asValidator(context),
                                  inputFormatters: [_model.textFieldMask3],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'UPDATE_USER_INFO_PAGE_SALVAR_BTN_ON_TAP');
                        if ((_model.textController1.text == null ||
                                    _model.textController1.text == '') ||
                                (_model.textController2.text == null ||
                                    _model.textController2.text == '') ||
                                (_model.textController3.text == null ||
                                    _model.textController3.text == '')
                            ? true
                            : false) {
                          logFirebaseEvent('Button_show_snack_bar');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Preencha todos os campos!',
                                style: GoogleFonts.getFont(
                                  'Fira Sans',
                                  color: Color(0xFFFF0000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: Duration(milliseconds: 2800),
                              backgroundColor: Colors.white,
                            ),
                          );
                          return;
                        } else if (functions
                                .checkCPF(_model.textController1.text) ==
                            false) {
                          logFirebaseEvent('Button_show_snack_bar');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'CPF inválido, preencha corretamente!',
                                style: GoogleFonts.getFont(
                                  'Fira Sans',
                                  color: Color(0xFFFF0000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: Duration(milliseconds: 2800),
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else {
                          logFirebaseEvent('Button_backend_call');

                          await currentUserReference!
                              .update(createTrokaRecordData(
                            cpf: _model.textController1.text,
                            nickname: _model.textController2.text,
                            phoneNumber: _model.textController3.text,
                          ));
                          logFirebaseEvent('Button_show_snack_bar');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Salvo!',
                                style: GoogleFonts.getFont(
                                  'Fira Sans',
                                  color: Color(0xFFFC4456),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: Duration(milliseconds: 2800),
                              backgroundColor: Colors.white,
                            ),
                          );
                          logFirebaseEvent('Button_navigate_to');

                          context.pushNamed('conta');
                        }
                      },
                      text: 'Salvar',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFFFC4456),
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
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 25.0))
                    .addToStart(SizedBox(height: 25.0)),
              );
            },
          ),
        ),
      ),
    );
  }
}
