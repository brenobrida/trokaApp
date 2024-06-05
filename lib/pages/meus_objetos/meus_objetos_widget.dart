import '/components/user_objects_collection_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'meus_objetos_model.dart';
export 'meus_objetos_model.dart';

class MeusObjetosWidget extends StatefulWidget {
  const MeusObjetosWidget({super.key});

  @override
  State<MeusObjetosWidget> createState() => _MeusObjetosWidgetState();
}

class _MeusObjetosWidgetState extends State<MeusObjetosWidget> {
  late MeusObjetosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MeusObjetosModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'meusObjetos'});
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
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('MEUS_OBJETOS_PAGE__BTN_ON_TAP');
                  logFirebaseEvent('Button_navigate_to');

                  context.pushNamed('conta');
                },
                text: '',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 25.0,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: double.infinity,
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
                  borderRadius: BorderRadius.circular(8.0),
                ),
                showLoadingIndicator: false,
              ),
            ),
            title: Text(
              'Meus objetos',
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: wrapWithModel(
                    model: _model.userObjectsCollectionModel,
                    updateCallback: () => setState(() {}),
                    child: UserObjectsCollectionWidget(),
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
