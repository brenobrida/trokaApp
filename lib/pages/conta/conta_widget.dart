import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'conta_model.dart';
export 'conta_model.dart';

class ContaWidget extends StatefulWidget {
  const ContaWidget({super.key});

  @override
  State<ContaWidget> createState() => _ContaWidgetState();
}

class _ContaWidgetState extends State<ContaWidget> {
  late ContaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContaModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'conta'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CONTA_PAGE_conta_ON_INIT_STATE');
      logFirebaseEvent('conta_update_app_state');
      setState(() {
        FFAppState().isFiltered = false;
      });
      logFirebaseEvent('conta_update_app_state');
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
            automaticallyImplyLeading: false,
            title: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Text(
                'Minha Conta',
                style: trokaTheme.of(context).headlineMedium.override(
                      fontFamily: 'Fira Sans',
                      color: Colors.black,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
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
            stream: _model.userInfo(
              requestFn: () => queryTrokaRecord(
                queryBuilder: (trokaRecord) => trokaRecord.where(
                  'uid',
                  isEqualTo: currentUserUid,
                ),
                singleRecord: true,
              ),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: MediaQuery.sizeOf(context).width * 0.3,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      valueOrDefault<String>(
                        columnTrokaRecord?.photoUrl,
                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/profile.png?alt=media&token=192c0f8c-d8d7-4b16-86f1-8c1f47d4e8dc',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(80.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '*CPF:',
                          style: trokaTheme.of(context).bodyMedium.override(
                                fontFamily: 'Fira Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              columnTrokaRecord?.cpf,
                              'Preencha...',
                            ),
                            style: trokaTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Fira Sans',
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '*Apelido:',
                          style: trokaTheme.of(context).bodyMedium.override(
                                fontFamily: 'Fira Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              columnTrokaRecord?.nickname,
                              'Preencha...',
                            ),
                            style: trokaTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Fira Sans',
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '*Celular:',
                          style: trokaTheme.of(context).bodyMedium.override(
                                fontFamily: 'Fira Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              columnTrokaRecord?.phoneNumber,
                              'Preencha...',
                            ),
                            style: trokaTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Fira Sans',
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent('CONTA_PAGE_EDITAR_BTN_ON_TAP');
                            logFirebaseEvent('Button_navigate_to');

                            context.pushNamed('updateUserInfo');

                            logFirebaseEvent('Button_update_app_state');
                            setState(() {
                              FFAppState().alteraFoto = '';
                            });
                          },
                          text: 'Editar',
                          options: FFButtonOptions(
                            height: 40.0,
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
                      ].divide(SizedBox(width: 20.0)),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent('CONTA_PAGE_Text_yl0pyqjk_ON_TAP');
                          logFirebaseEvent('Text_navigate_to');

                          context.pushNamedAuth('login', context.mounted);

                          logFirebaseEvent('Text_auth');
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();
                        },
                        child: Text(
                          'Sair da conta',
                          textAlign: TextAlign.start,
                          style: trokaTheme.of(context).bodyMedium.override(
                                fontFamily: 'Fira Sans',
                                color: Color(0xFFB6B6B6),
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'CONTA_PAGE_Container_hw23i7if_ON_TAP');
                        logFirebaseEvent('Container_navigate_to');

                        context.pushNamed(
                          'meusObjetos',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                            ),
                          },
                        );
                      },
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.sizeOf(context).width * 1.0,
                            minHeight: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFFDDDDDD),
                              width: 0.5,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Meus objetos',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Color(0xFFFC4456),
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
