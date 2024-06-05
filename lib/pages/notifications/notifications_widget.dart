import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notifications_model.dart';
export 'notifications_model.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'notifications'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NOTIFICATIONS_notifications_ON_INIT_STAT');
      logFirebaseEvent('notifications_update_app_state');
      setState(() {
        FFAppState().photo0 =
            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
        FFAppState().photo1 =
            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/fotocapa.png?alt=media&token=92a864b8-6df4-4f8a-a837-4837187d8e3f';
        FFAppState().photo2 =
            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
        FFAppState().photo3 =
            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
        FFAppState().photo4 =
            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
        FFAppState().photo5 =
            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
      });
      logFirebaseEvent('notifications_update_app_state');
      setState(() {
        FFAppState().isFiltered = false;
      });
      logFirebaseEvent('notifications_update_app_state');
      FFAppState().filterCity = '';
      FFAppState().filterUF = '';
      FFAppState().filterObjectCategory = '';
      FFAppState().filterObjectInterest = [];
      FFAppState().filterAnyCategoryInterest = false;
      FFAppState().filterObjectCondition = [];
      FFAppState().filterChoice = '';
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF6F6FB),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.08),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xFF5D5D5D)),
          automaticallyImplyLeading: true,
          title: Text(
            'Notificações',
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
        child: Stack(
          children: [
            StreamBuilder<List<NotificationsRecord>>(
              stream: queryNotificationsRecord(
                queryBuilder: (notificationsRecord) =>
                    notificationsRecord.where(
                  'uid',
                  isEqualTo: currentUserUid,
                ),
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
                List<NotificationsRecord> listViewNotificationsRecordList =
                    snapshot.data!;
                if (listViewNotificationsRecordList.isEmpty) {
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
                  itemCount: listViewNotificationsRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewNotificationsRecord =
                        listViewNotificationsRecordList[listViewIndex];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  listViewNotificationsRecord.objectImage,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (listViewNotificationsRecord.type ==
                                          'newOffer')
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Você recebeu uma nova oferta!',
                                              textAlign: TextAlign.start,
                                              style: trokaTheme
                                                  .of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Fira Sans',
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      if (listViewNotificationsRecord.type ==
                                          'offerStatus')
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Sua oferta no item ',
                                                      style: trokaTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Fira Sans',
                                                            color: Colors.black,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          listViewNotificationsRecord
                                                              .objectTitle,
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Fira Sans',
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: listViewNotificationsRecord
                                                              .offerAccepted
                                                          ? ' foi aceita!'
                                                          : ' foi recusada...',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Fira Sans',
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                  style: trokaTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Fira Sans',
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (listViewNotificationsRecord.type ==
                                          'newOffer')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'Clique para conferir',
                                            style: trokaTheme
                                                .of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Fira Sans',
                                                  color: Color(0xFFFC4456),
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
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Color(0xFFB6B6B6),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('NOTIFICATIONS_PAGE__BTN_ON_TAP');
                    logFirebaseEvent('Button_backend_call');

                    await currentUserReference!.update(createTrokaRecordData(
                      userNotifications: 0,
                    ));
                    logFirebaseEvent('Button_navigate_to');

                    context.pushNamed(
                      'explorar',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.leftToRight,
                        ),
                      },
                    );
                  },
                  text: '',
                  icon: Icon(
                    Icons.cancel,
                    color: Color(0xFFB6B6B6),
                    size: 50.0,
                  ),
                  options: FFButtonOptions(
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  showLoadingIndicator: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
