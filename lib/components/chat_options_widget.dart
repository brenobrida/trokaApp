import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_options_model.dart';
export 'chat_options_model.dart';

class ChatOptionsWidget extends StatefulWidget {
  const ChatOptionsWidget({
    super.key,
    required this.objectId,
    required this.offer,
    required this.uidOtherUser,
    required this.offerId,
  });

  final String? objectId;
  final OffersRecord? offer;
  final String? uidOtherUser;
  final String? offerId;

  @override
  State<ChatOptionsWidget> createState() => _ChatOptionsWidgetState();
}

class _ChatOptionsWidgetState extends State<ChatOptionsWidget> {
  late ChatOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatOptionsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TrokaRecord>>(
      stream: queryTrokaRecord(
        queryBuilder: (trokaRecord) => trokaRecord.where(
          'uid',
          isEqualTo: widget.uidOtherUser,
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
            Expanded(
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'CHAT_OPTIONS_Container_rcjdinss_ON_TAP');
                        logFirebaseEvent('Container_update_app_state');
                        setState(() {
                          FFAppState().objectIdSelected = widget.objectId!;
                        });
                        logFirebaseEvent('Container_navigate_to');

                        context.pushNamed('objectPage');
                      },
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0x005D5D5D),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.image_search,
                                color: Color(0xFF5D5D5D),
                                size: 30.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Ver objeto',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      indent: 20.0,
                      endIndent: 20.0,
                      color: Color(0xFFDDDDDD),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'CHAT_OPTIONS_Container_i3lx4pr9_ON_TAP');
                        logFirebaseEvent('Container_alert_dialog');
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Atenção'),
                                  content: Text(
                                      'Tem certeza que deseja cancelar a negociação?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: Text('Não'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: Text('Sim'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          logFirebaseEvent('Container_backend_call');
                          await widget.offer!.reference.delete();
                          logFirebaseEvent('Container_backend_call');

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'offers':
                                    FieldValue.arrayRemove([widget.offerId]),
                              },
                            ),
                          });
                          logFirebaseEvent('Container_backend_call');

                          await columnTrokaRecord!.reference.update({
                            ...mapToFirestore(
                              {
                                'offers':
                                    FieldValue.arrayRemove([widget.offerId]),
                              },
                            ),
                          });
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed('ofertas');
                        } else {
                          logFirebaseEvent('Container_navigate_back');
                          context.safePop();
                        }
                      },
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0x005D5D5D),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.cancel_rounded,
                                color: Color(0xFFFC4456),
                                size: 30.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Cancelar negociação',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFFFC4456),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
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
          ],
        );
      },
    );
  }
}
