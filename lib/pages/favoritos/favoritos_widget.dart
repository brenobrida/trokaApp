import '/auth/firebase_auth/auth_util.dart';
import '/components/user_favorite_objects_collection_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favoritos_model.dart';
export 'favoritos_model.dart';

class FavoritosWidget extends StatefulWidget {
  const FavoritosWidget({super.key});

  @override
  State<FavoritosWidget> createState() => _FavoritosWidgetState();
}

class _FavoritosWidgetState extends State<FavoritosWidget> {
  late FavoritosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavoritosModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'favoritos'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('FAVORITOS_PAGE_favoritos_ON_INIT_STATE');
      logFirebaseEvent('favoritos_update_app_state');
      setState(() {
        FFAppState().isFiltered = false;
      });
      logFirebaseEvent('favoritos_update_app_state');
      setState(() {
        FFAppState().userFavoriteObjetcs = [];
      });
      logFirebaseEvent('favoritos_update_app_state');
      setState(() {
        FFAppState().userFavoriteObjetcs =
            (currentUserDocument?.favoriteObjects?.toList() ?? [])
                .toList()
                .cast<String>();
      });
      logFirebaseEvent('favoritos_update_app_state');
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
                'Favoritos',
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
          child: Stack(
            children: [
              if (!(FFAppState().userFavoriteObjetcs.isNotEmpty))
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: Text(
                      'Não há favoritos por aqui...',
                      style: trokaTheme.of(context).bodyMedium.override(
                            fontFamily: 'Fira Sans',
                            color: Color(0xFFB6B6B6),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              if (FFAppState().userFavoriteObjetcs.isNotEmpty)
                wrapWithModel(
                  model: _model.userFavoriteObjectsCollectionModel,
                  updateCallback: () => setState(() {}),
                  updateOnChange: true,
                  child: UserFavoriteObjectsCollectionWidget(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
