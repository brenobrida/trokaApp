import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'altera_foto_model.dart';
export 'altera_foto_model.dart';

class AlteraFotoWidget extends StatefulWidget {
  const AlteraFotoWidget({super.key});

  @override
  State<AlteraFotoWidget> createState() => _AlteraFotoWidgetState();
}

class _AlteraFotoWidgetState extends State<AlteraFotoWidget> {
  late AlteraFotoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlteraFotoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0x005D5D5D),
                width: 1.0,
              ),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ALTERA_FOTO_COMP_Row_smxmk9de_ON_TAP');
                logFirebaseEvent('Row_update_app_state');
                FFAppState().alteraFoto = 'altera';
                logFirebaseEvent('Row_close_dialog,_drawer,_etc');
                Navigator.pop(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.image_search,
                      color: Color(0xFF5D5D5D),
                      size: 30.0,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Alterar',
                      style: trokaTheme.of(context).bodyMedium.override(
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
        ),
        Flexible(
          flex: 1,
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0x005D5D5D),
              ),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ALTERA_FOTO_COMP_Row_w76tko9o_ON_TAP');
                logFirebaseEvent('Row_update_app_state');
                setState(() {
                  FFAppState().alteraFoto = 'exclui';
                });
                logFirebaseEvent('Row_close_dialog,_drawer,_etc');
                Navigator.pop(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.delete_outlined,
                      color: Color(0xFFFC4456),
                      size: 30.0,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Excluir',
                      style: trokaTheme.of(context).bodyMedium.override(
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
        ),
      ],
    );
  }
}
