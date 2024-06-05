import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/chat_options_widget.dart';
import '/troka/troka_expanded_image_view.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/upload_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    required this.offerId,
    required this.objectImage,
    required this.objectTitle,
    required this.objectId,
  });

  final String? offerId;
  final String? objectImage;
  final String? objectTitle;
  final String? objectId;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'chat'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OffersRecord>>(
      stream: queryOffersRecord(
        queryBuilder: (offersRecord) => offersRecord.where(
          'offerId',
          isEqualTo: widget.offerId,
        ),
        singleRecord: true,
      )..listen((snapshot) async {
          List<OffersRecord> chatOffersRecordList = snapshot;
          final chatOffersRecord = chatOffersRecordList.isNotEmpty
              ? chatOffersRecordList.first
              : null;
          if (_model.chatPreviousSnapshot != null &&
              !const ListEquality(OffersRecordDocumentEquality())
                  .equals(chatOffersRecordList, _model.chatPreviousSnapshot)) {
            logFirebaseEvent('CHAT_PAGE_chat_ON_DATA_CHANGE');
            if (!(currentUserDocument?.offers?.toList() ?? [])
                .contains(widget.offerId)) {
              logFirebaseEvent('chat_navigate_to');

              context.pushNamed('ofertas');

              logFirebaseEvent('chat_show_snack_bar');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Negociação cancelada pelo outro usuário...',
                    style: TextStyle(
                      color: Color(0xFFFC4456),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  duration: Duration(milliseconds: 3000),
                  backgroundColor: Colors.white,
                ),
              );
            }

            setState(() {});
          }
          _model.chatPreviousSnapshot = snapshot;
        }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF6F6FB),
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
        List<OffersRecord> chatOffersRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final chatOffersRecord =
            chatOffersRecordList.isNotEmpty ? chatOffersRecordList.first : null;
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
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CHAT_PAGE_Icon_kjc88w9i_ON_TAP');
                              logFirebaseEvent('Icon_navigate_back');
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.black,
                              size: 25.0,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'CHAT_PAGE_Row_s5bx3zik_ON_TAP');
                                      logFirebaseEvent('Row_update_app_state');
                                      FFAppState().objectIdSelected =
                                          widget.objectId!;
                                      logFirebaseEvent('Row_navigate_to');

                                      context.pushNamed('objectPage');
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.15,
                                            height: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.15,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              widget.objectImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: AutoSizeText(
                                              valueOrDefault<String>(
                                                widget.objectTitle,
                                                'erro',
                                              ),
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
                                              minFontSize: 12.0,
                                            ),
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
                        Builder(
                          builder: (context) => Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 20.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'CHAT_PAGE_Icon_k70eohca_ON_TAP');
                                logFirebaseEvent('Icon_alert_dialog');
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(0.0, -1.0)
                                          .resolve(Directionality.of(context)),
                                      child: GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.15,
                                          width: double.infinity,
                                          child: ChatOptionsWidget(
                                            objectId: widget.objectId!,
                                            offer: chatOffersRecord!,
                                            uidOtherUser: currentUserUid ==
                                                    chatOffersRecord
                                                        ?.uidWhoOfferd
                                                ? chatOffersRecord!
                                                    .uidReceivedOffer
                                                : chatOffersRecord!
                                                    .uidWhoOfferd,
                                            offerId: widget.offerId!,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              },
                              child: FaIcon(
                                FontAwesomeIcons.bars,
                                color: Colors.black,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: StreamBuilder<List<ChatMessagesRecord>>(
                      stream: queryChatMessagesRecord(
                        queryBuilder: (chatMessagesRecord) => chatMessagesRecord
                            .where(
                              'offerId',
                              isEqualTo: widget.offerId,
                            )
                            .orderBy('dateTime'),
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
                                  trokaTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<ChatMessagesRecord>
                            listViewChatMessagesRecordList = snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewChatMessagesRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewChatMessagesRecord =
                                listViewChatMessagesRecordList[listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if ((listViewChatMessagesRecord.uid !=
                                          currentUserUid) &&
                                      (listViewChatMessagesRecord
                                                  .imageMessage ==
                                              null ||
                                          listViewChatMessagesRecord
                                                  .imageMessage ==
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            height: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              listViewChatMessagesRecord
                                                  .userImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(16.0),
                                                  bottomRight:
                                                      Radius.circular(16.0),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                ),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.8,
                                                  constraints: BoxConstraints(
                                                    minWidth: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.8,
                                                    minHeight:
                                                        MediaQuery.sizeOf(
                                                                    context)
                                                                .height *
                                                            0.06,
                                                    maxWidth: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.8,
                                                    maxHeight:
                                                        MediaQuery.sizeOf(
                                                                    context)
                                                                .height *
                                                            0.5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(16.0),
                                                      bottomRight:
                                                          Radius.circular(16.0),
                                                      topLeft:
                                                          Radius.circular(0.0),
                                                      topRight:
                                                          Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 5.0,
                                                                10.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          listViewChatMessagesRecord
                                                              .userNickname,
                                                          style: trokaTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Fira Sans',
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            listViewChatMessagesRecord
                                                                .message,
                                                            maxLines: 20,
                                                            style: trokaTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Fira Sans',
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                          child: Text(
                                                            dateTimeFormat(
                                                              'relative',
                                                              listViewChatMessagesRecord
                                                                  .dateTime!,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
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
                                  if ((listViewChatMessagesRecord.uid ==
                                          currentUserUid) &&
                                      (listViewChatMessagesRecord
                                                  .imageMessage ==
                                              null ||
                                          listViewChatMessagesRecord
                                                  .imageMessage ==
                                              ''))
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 20.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(16.0),
                                                bottomRight:
                                                    Radius.circular(16.0),
                                                topLeft: Radius.circular(16.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.8,
                                                constraints: BoxConstraints(
                                                  minWidth:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.8,
                                                  minHeight:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.06,
                                                  maxWidth:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.8,
                                                  maxHeight:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xA6FC4456),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(16.0),
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(0.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 5.0, 10.0, 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            listViewChatMessagesRecord
                                                                .message,
                                                            maxLines: 20,
                                                            style: trokaTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Fira Sans',
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, 1.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            'relative',
                                                            listViewChatMessagesRecord
                                                                .dateTime!,
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
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
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
                                  if ((listViewChatMessagesRecord.uid !=
                                          currentUserUid) &&
                                      (listViewChatMessagesRecord
                                                  .imageMessage !=
                                              null &&
                                          listViewChatMessagesRecord
                                                  .imageMessage !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            height: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              listViewChatMessagesRecord
                                                  .userImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(16.0),
                                                  bottomRight:
                                                      Radius.circular(16.0),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                ),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.8,
                                                  constraints: BoxConstraints(
                                                    minWidth: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.8,
                                                    minHeight:
                                                        MediaQuery.sizeOf(
                                                                    context)
                                                                .height *
                                                            0.06,
                                                    maxWidth: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.8,
                                                    maxHeight:
                                                        MediaQuery.sizeOf(
                                                                    context)
                                                                .height *
                                                            0.5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(16.0),
                                                      bottomRight:
                                                          Radius.circular(16.0),
                                                      topLeft:
                                                          Radius.circular(0.0),
                                                      topRight:
                                                          Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'CHAT_PAGE_Image_2baurnx4_ON_TAP');
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
                                                                    listViewChatMessagesRecord
                                                                        .imageMessage,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Image
                                                                            .asset(
                                                                      'assets/images/error_image.png',
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                  allowRotation:
                                                                      false,
                                                                  tag: listViewChatMessagesRecord
                                                                      .imageMessage,
                                                                  useHeroAnimation:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Hero(
                                                            tag: listViewChatMessagesRecord
                                                                .imageMessage,
                                                            transitionOnUserGestures:
                                                                true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                listViewChatMessagesRecord
                                                                    .imageMessage,
                                                                width: double
                                                                    .infinity,
                                                                height: 200.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                  'assets/images/error_image.png',
                                                                  width: double
                                                                      .infinity,
                                                                  height: 200.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              dateTimeFormat(
                                                                'relative',
                                                                listViewChatMessagesRecord
                                                                    .dateTime!,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.end,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  if ((listViewChatMessagesRecord.uid ==
                                          currentUserUid) &&
                                      (listViewChatMessagesRecord
                                                  .imageMessage !=
                                              null &&
                                          listViewChatMessagesRecord
                                                  .imageMessage !=
                                              ''))
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 20.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(16.0),
                                                bottomRight:
                                                    Radius.circular(16.0),
                                                topLeft: Radius.circular(16.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.8,
                                                constraints: BoxConstraints(
                                                  minWidth:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.8,
                                                  minHeight:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.06,
                                                  maxWidth:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.8,
                                                  maxHeight:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xA6FC4456),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(16.0),
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(0.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 10.0,
                                                          10.0, 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
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
                                                              'CHAT_PAGE_Image_h797fn99_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Image_expand_image');
                                                          await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  trokaExpandedImageView(
                                                                image: Image
                                                                    .network(
                                                                  listViewChatMessagesRecord
                                                                      .imageMessage,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Image
                                                                          .asset(
                                                                    'assets/images/error_image.png',
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                allowRotation:
                                                                    false,
                                                                tag: listViewChatMessagesRecord
                                                                    .imageMessage,
                                                                useHeroAnimation:
                                                                    true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag:
                                                              listViewChatMessagesRecord
                                                                  .imageMessage,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              listViewChatMessagesRecord
                                                                  .imageMessage,
                                                              width: double
                                                                  .infinity,
                                                              height: 200.0,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context,
                                                                      error,
                                                                      stackTrace) =>
                                                                  Image.asset(
                                                                'assets/images/error_image.png',
                                                                width: double
                                                                    .infinity,
                                                                height: 200.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, 1.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      5.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            dateTimeFormat(
                                                              'relative',
                                                              listViewChatMessagesRecord
                                                                  .dateTime!,
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
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
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
                                        ),
                                      ],
                                    ),
                                ].divide(SizedBox(height: 10.0)),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.09,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.0),
                        border: Border.all(
                          color: Color(0xFFDDDDDD),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController',
                                  Duration(milliseconds: 0),
                                  () => setState(() {}),
                                ),
                                autofocus: false,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: trokaTheme
                                      .of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintStyle: trokaTheme
                                      .of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDDDDDD),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDDDDDD),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: trokaTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: trokaTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                maxLines: 20,
                                minLines: 1,
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                          if (_model.textController.text == '')
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'CHAT_PAGE_Icon_ib0z7uhd_ON_TAP');
                                  logFirebaseEvent(
                                      'Icon_upload_media_to_firebase');
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    maxWidth: 2160.00,
                                    maxHeight: 3840.00,
                                    imageQuality: 70,
                                    allowPhoto: true,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    pickerFontFamily: 'Fira Sans',
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    var downloadUrls = <String>[];
                                    try {
                                      showUploadMessage(
                                        context,
                                        'Uploading file...',
                                        showLoading: true,
                                      );
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                                blurHash: m.blurHash,
                                              ))
                                          .toList();

                                      downloadUrls = (await Future.wait(
                                        selectedMedia.map(
                                          (m) async => await uploadData(
                                              m.storagePath, m.bytes),
                                        ),
                                      ))
                                          .where((u) => u != null)
                                          .map((u) => u!)
                                          .toList();
                                    } finally {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      _model.isDataUploading = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                            selectedMedia.length &&
                                        downloadUrls.length ==
                                            selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile =
                                            selectedUploadedFiles.first;
                                        _model.uploadedFileUrl =
                                            downloadUrls.first;
                                      });
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      setState(() {});
                                      showUploadMessage(
                                          context, 'Failed to upload data');
                                      return;
                                    }
                                  }

                                  if (_model.uploadedFileUrl != null &&
                                      _model.uploadedFileUrl != '') {
                                    logFirebaseEvent('Icon_backend_call');

                                    await ChatMessagesRecord.collection
                                        .doc()
                                        .set({
                                      ...createChatMessagesRecordData(
                                        offerId: widget.offerId,
                                        uid: currentUserUid,
                                        userImage: currentUserPhoto,
                                        userNickname: valueOrDefault(
                                            currentUserDocument?.nickname, ''),
                                        imageMessage: _model.uploadedFileUrl,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'dateTime':
                                              FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    return;
                                  } else {
                                    return;
                                  }
                                },
                                child: Icon(
                                  Icons.photo_camera,
                                  color: Color(0xFFB6B6B6),
                                  size: 35.0,
                                ),
                              ),
                            ),
                          if (_model.textController.text != null &&
                              _model.textController.text != '')
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'CHAT_PAGE_Icon_5c2aj820_ON_TAP');
                                  logFirebaseEvent('Icon_backend_call');

                                  await ChatMessagesRecord.collection
                                      .doc()
                                      .set({
                                    ...createChatMessagesRecordData(
                                      offerId: widget.offerId,
                                      message: _model.textController.text,
                                      uid: currentUserUid,
                                      userImage: currentUserPhoto,
                                      userNickname: valueOrDefault(
                                          currentUserDocument?.nickname, ''),
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'dateTime':
                                            FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  logFirebaseEvent('Icon_backend_call');

                                  await chatOffersRecord!.reference.update({
                                    ...createOffersRecordData(
                                      lastMessage: _model.textController.text,
                                      lastMessageOwner: currentUserUid,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'messageTime':
                                            FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  logFirebaseEvent('Icon_reset_form_fields');
                                  setState(() {
                                    _model.textController?.clear();
                                  });
                                },
                                child: Icon(
                                  Icons.send_rounded,
                                  color: Color(0xFFFC4456),
                                  size: 35.0,
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
        );
      },
    );
  }
}
