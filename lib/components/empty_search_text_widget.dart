import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_search_text_model.dart';
export 'empty_search_text_model.dart';

class EmptySearchTextWidget extends StatefulWidget {
  const EmptySearchTextWidget({super.key});

  @override
  State<EmptySearchTextWidget> createState() => _EmptySearchTextWidgetState();
}

class _EmptySearchTextWidgetState extends State<EmptySearchTextWidget> {
  late EmptySearchTextModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptySearchTextModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        'Não encontramos nada por aqui...',
        style: trokaTheme.of(context).bodyMedium.override(
              fontFamily: 'Fira Sans',
              color: Color(0xFFB6B6B6),
              fontSize: 16.0,
              letterSpacing: 0.0,
            ),
      ),
    );
  }
}
