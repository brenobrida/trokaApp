import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/altera_foto_widget.dart';
import '/troka/troka_checkbox_group.dart';
import '/troka/troka_choice_chips.dart';
import '/troka/troka_drop_down.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/form_field_controller.dart';
import '/troka/upload_data.dart';
import '/troka/random_data_util.dart' as random_data;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'editar_model.dart';
export 'editar_model.dart';

class EditarWidget extends StatefulWidget {
  const EditarWidget({super.key});

  @override
  State<EditarWidget> createState() => _EditarWidgetState();
}

class _EditarWidgetState extends State<EditarWidget> {
  late EditarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditarModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'editar'});

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldFocusNode3 ??= FocusNode();

    _model.objIdTextController ??= TextEditingController(
        text: random_data.randomString(
      8,
      8,
      true,
      true,
      true,
    ));
    _model.objIdFocusNode ??= FocusNode();
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
        queryBuilder: (userObjectsRecord) => userObjectsRecord.where(
          'objectId',
          isEqualTo: FFAppState().objectIdSelected,
        ),
        singleRecord: true,
      ),
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
        List<UserObjectsRecord> editarUserObjectsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final editarUserObjectsRecord = editarUserObjectsRecordList.isNotEmpty
            ? editarUserObjectsRecordList.first
            : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                  'Editar',
                  style: trokaTheme.of(context).headlineMedium.override(
                        fontFamily: 'Fira Sans',
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                actions: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('EDITAR_PAGE_Icon_t8n9x0jn_ON_TAP');
                        logFirebaseEvent('Icon_alert_dialog');
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Excluir objeto'),
                                  content:
                                      Text('Tem certeza que deseja excluir?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: Text('Cancelar'),
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
                          logFirebaseEvent('Icon_backend_call');
                          await editarUserObjectsRecord!.reference.delete();
                        } else {
                          return;
                        }

                        logFirebaseEvent('Icon_navigate_to');

                        context.pushNamed('meusObjetos');
                      },
                      child: Icon(
                        Icons.delete_outlined,
                        color: Color(0xFFFC4456),
                        size: 34.0,
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
                toolbarHeight: MediaQuery.sizeOf(context).height * 0.08,
                elevation: 2.0,
              ),
            ),
            body: SafeArea(
              top: true,
              child: Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
                          child: SwitchListTile.adaptive(
                            value: _model.switchListTileValue1 ??=
                                editarUserObjectsRecord!.available,
                            onChanged: (newValue) async {
                              setState(() =>
                                  _model.switchListTileValue1 = newValue!);
                            },
                            title: Text(
                              'Anúncio ativo',
                              style: trokaTheme.of(context).titleLarge.override(
                                    fontFamily: 'Fira Sans',
                                    color: Color(0xFF5D5D5D),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            tileColor: Colors.white,
                            activeColor: Color(0xFF2ECC71),
                            activeTrackColor: Color(0x872ECC71),
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 0.0, 0.0),
                            child: Text(
                              'Selecione o tipo de negociação:',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Color(0xFF5D5D5D),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 0.0, 0.0),
                            child: trokaChoiceChips(
                              options: [
                                ChipData('troka', Icons.cached),
                                ChipData('doação', Icons.favorite)
                              ],
                              onChanged: (val) => setState(() =>
                                  _model.choiceChipsValue = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: Color(0xFFFC4456),
                                textStyle:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                iconColor: Colors.white,
                                iconSize: 20.0,
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: Colors.white,
                                textStyle:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFFB6B6B6),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                iconColor: Color(0xFFB6B6B6),
                                iconSize: 20.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              chipSpacing: 20.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              initialized: _model.choiceChipsValue != null,
                              alignment: WrapAlignment.center,
                              controller: _model.choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                [editarUserObjectsRecord!.negotiationType],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 28.0, 15.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child: TextFormField(
                              controller: _model.textController1 ??=
                                  TextEditingController(
                                text: editarUserObjectsRecord?.title,
                              ),
                              focusNode: _model.textFieldFocusNode1,
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Título*',
                                labelStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          letterSpacing: 0.0,
                                        ),
                                alignLabelWithHint: false,
                                hintStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                errorStyle: GoogleFonts.getFont(
                                  'Fira Sans',
                                  color: Color(0xFFFF0000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.start,
                              maxLength: 30,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              validator: _model.textController1Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 8.0, 15.0, 0.0),
                          child: trokaDropDown<String>(
                            controller: _model.dropDownValueController1 ??=
                                FormFieldController<String>(
                              _model.dropDownValue1 ??=
                                  editarUserObjectsRecord?.objectCategory,
                            ),
                            options: [
                              'Celulares e Telefones',
                              'Câmeras e Acessórios',
                              'Games',
                              'Computadores e Acessórios',
                              'Eletrônicos, Áudio e Vídeo',
                              'Televisores',
                              'Imóveis',
                              'Veículos e Acessórios',
                              'Móveis',
                              'Eletrodomésticos',
                              'Esportes e Fitness',
                              'Ferramentas',
                              'Beleza e Cuidado Pessoal',
                              'Brinquedos',
                              'Produtos Sustentáveis',
                              'Música e acessórios',
                              'Bebidas e Comidas',
                              'Roupas e Acessórios',
                              'Enfeites e Decoração da Casa',
                              'Joias e Relógios',
                              'Máquinas e Equipamentos',
                              'Livros, Revistas e Comics',
                              'Materiais de Construção'
                            ],
                            onChanged: (val) =>
                                setState(() => _model.dropDownValue1 = val),
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            textStyle:
                                trokaTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Fira Sans',
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF5D5D5D),
                              size: 24.0,
                            ),
                            fillColor: Colors.white,
                            elevation: 1.0,
                            borderColor: Colors.white,
                            borderWidth: 0.3,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isOverButton: true,
                            isSearchable: false,
                            isMultiSelect: false,
                            labelText: 'Selecione a categoria do seu objeto*',
                            labelTextStyle: GoogleFonts.getFont(
                              'Fira Sans',
                              color: Color(0xFF5D5D5D),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 28.0, 8.0, 0.0),
                          child: trokaDropDown<String>(
                            controller: _model.dropDownValueController2 ??=
                                FormFieldController<String>(
                              _model.dropDownValue2 ??=
                                  editarUserObjectsRecord?.objectConditions,
                            ),
                            options: [
                              'Novo',
                              'Usado',
                              'Recondicionado',
                              'Com defeito'
                            ],
                            onChanged: (val) =>
                                setState(() => _model.dropDownValue2 = val),
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            textStyle:
                                trokaTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Fira Sans',
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF5D5D5D),
                              size: 24.0,
                            ),
                            fillColor: Colors.white,
                            elevation: 1.0,
                            borderColor: Colors.white,
                            borderWidth: 0.3,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                15.0, 4.0, 15.0, 4.0),
                            hidesUnderline: true,
                            isOverButton: true,
                            isSearchable: false,
                            isMultiSelect: false,
                            labelText: 'Condição*',
                            labelTextStyle: GoogleFonts.getFont(
                              'Fira Sans',
                              color: Color(0xFF5D5D5D),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 28.0, 15.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child: TextFormField(
                              controller: _model.textController2 ??=
                                  TextEditingController(
                                text: editarUserObjectsRecord?.description,
                              ),
                              focusNode: _model.textFieldFocusNode2,
                              autofocus: false,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Descrição*',
                                labelStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          letterSpacing: 0.0,
                                        ),
                                alignLabelWithHint: true,
                                hintStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              maxLength: 600,
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 20.0, 15.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child: TextFormField(
                              controller: _model.textController3 ??=
                                  TextEditingController(
                                text: editarUserObjectsRecord?.cep,
                              ),
                              focusNode: _model.textFieldFocusNode3,
                              autofocus: false,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Localização (CEP)*',
                                labelStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          letterSpacing: 0.0,
                                        ),
                                alignLabelWithHint: false,
                                hintStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                errorStyle: GoogleFonts.getFont(
                                  'Fira Sans',
                                  color: Color(0xFFFF0000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.start,
                              maxLength: 9,
                              keyboardType: TextInputType.number,
                              validator: _model.textController3Validator
                                  .asValidator(context),
                              inputFormatters: [_model.textFieldMask3],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Fotos*',
                              style: trokaTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Fira Sans',
                                    color: Color(0xFF5D5D5D),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 2.0, 0.0, 0.0),
                                child: Text(
                                  'Adicione 1 ou até 6 fotos',
                                  style: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Color(0xFF5D5D5D),
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 180.0,
                            child: CarouselSlider(
                              items: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EDITAR_PAGE_Image_6ebfw0p8_ON_TAP');
                                    if (!((FFAppState().photo0 ==
                                            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25') ||
                                        (FFAppState().photo0 == null ||
                                            FFAppState().photo0 == ''))) {
                                      logFirebaseEvent('Image_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 80.0,
                                                child: AlteraFotoWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (FFAppState().alteraFoto == 'exclui') {
                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        setState(() {
                                          FFAppState().photo0 =
                                              'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
                                        });
                                        logFirebaseEvent(
                                            'Image_clear_uploaded_data');
                                        setState(() {
                                          _model.isDataUploading1 = false;
                                          _model.uploadedLocalFile1 =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl1 = '';
                                        });

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().alteraFoto = '';
                                        return;
                                      } else if (FFAppState().alteraFoto ==
                                          'altera') {
                                      } else {
                                        return;
                                      }
                                    }
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 2160.00,
                                      maxHeight: 3840.00,
                                      imageQuality: 70,
                                      allowPhoto: true,
                                      textColor: Colors.black,
                                      pickerFontFamily: 'Fira Sans',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading1 = true);
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
                                        _model.isDataUploading1 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile1 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl1 =
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

                                    logFirebaseEvent('Image_update_app_state');
                                    setState(() {
                                      FFAppState().photo0 =
                                          _model.uploadedFileUrl1;
                                    });
                                    logFirebaseEvent('Image_update_app_state');
                                    FFAppState().alteraFoto = '';
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().photo0,
                                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25',
                                      ),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EDITAR_PAGE_Image_7mkidz8e_ON_TAP');
                                    if (!((FFAppState().photo1 ==
                                            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/fotocapa.png?alt=media&token=92a864b8-6df4-4f8a-a837-4837187d8e3f') ||
                                        (FFAppState().photo1 == null ||
                                            FFAppState().photo1 == ''))) {
                                      logFirebaseEvent('Image_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.15,
                                                child: AlteraFotoWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (FFAppState().alteraFoto == 'exclui') {
                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        setState(() {
                                          FFAppState().photo1 =
                                              'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/fotocapa.png?alt=media&token=92a864b8-6df4-4f8a-a837-4837187d8e3f';
                                        });
                                        logFirebaseEvent(
                                            'Image_clear_uploaded_data');
                                        setState(() {
                                          _model.isDataUploading2 = false;
                                          _model.uploadedLocalFile2 =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl2 = '';
                                        });

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().alteraFoto = '';
                                        return;
                                      } else if (FFAppState().alteraFoto ==
                                          'altera') {
                                      } else {
                                        return;
                                      }
                                    }
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 2160.00,
                                      maxHeight: 3840.00,
                                      imageQuality: 70,
                                      allowPhoto: true,
                                      textColor: Colors.black,
                                      pickerFontFamily: 'Fira Sans',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading2 = true);
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
                                        _model.isDataUploading2 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile2 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl2 =
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

                                    logFirebaseEvent('Image_update_app_state');
                                    setState(() {
                                      FFAppState().photo1 =
                                          _model.uploadedFileUrl2;
                                    });
                                    logFirebaseEvent('Image_update_app_state');
                                    FFAppState().alteraFoto = '';
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().photo1,
                                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/fotocapa.png?alt=media&token=92a864b8-6df4-4f8a-a837-4837187d8e3f',
                                      ),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EDITAR_PAGE_Image_u938puzp_ON_TAP');
                                    if (!((FFAppState().photo2 ==
                                            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25') ||
                                        (FFAppState().photo2 == null ||
                                            FFAppState().photo2 == ''))) {
                                      logFirebaseEvent('Image_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 80.0,
                                                child: AlteraFotoWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (FFAppState().alteraFoto == 'exclui') {
                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        setState(() {
                                          FFAppState().photo2 =
                                              'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
                                        });
                                        logFirebaseEvent(
                                            'Image_clear_uploaded_data');
                                        setState(() {
                                          _model.isDataUploading3 = false;
                                          _model.uploadedLocalFile3 =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl3 = '';
                                        });

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().alteraFoto = '';
                                        return;
                                      } else if (FFAppState().alteraFoto ==
                                          'altera') {
                                      } else {
                                        return;
                                      }
                                    }
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 2160.00,
                                      maxHeight: 3840.00,
                                      imageQuality: 70,
                                      allowPhoto: true,
                                      textColor: Colors.black,
                                      pickerFontFamily: 'Fira Sans',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading3 = true);
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
                                        _model.isDataUploading3 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile3 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl3 =
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

                                    logFirebaseEvent('Image_update_app_state');
                                    setState(() {
                                      FFAppState().photo2 =
                                          _model.uploadedFileUrl3;
                                    });
                                    logFirebaseEvent('Image_update_app_state');
                                    FFAppState().alteraFoto = '';
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().photo2,
                                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25',
                                      ),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EDITAR_PAGE_Image_3q9dsreu_ON_TAP');
                                    if (!((FFAppState().photo3 ==
                                            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25') ||
                                        (FFAppState().photo3 == null ||
                                            FFAppState().photo3 == ''))) {
                                      logFirebaseEvent('Image_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 80.0,
                                                child: AlteraFotoWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (FFAppState().alteraFoto == 'exclui') {
                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        setState(() {
                                          FFAppState().photo3 =
                                              'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
                                        });
                                        logFirebaseEvent(
                                            'Image_clear_uploaded_data');
                                        setState(() {
                                          _model.isDataUploading4 = false;
                                          _model.uploadedLocalFile4 =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl4 = '';
                                        });

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().alteraFoto = '';
                                        return;
                                      } else if (FFAppState().alteraFoto ==
                                          'altera') {
                                      } else {
                                        return;
                                      }
                                    }
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 2160.00,
                                      maxHeight: 3840.00,
                                      imageQuality: 70,
                                      allowPhoto: true,
                                      textColor: Colors.black,
                                      pickerFontFamily: 'Fira Sans',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading4 = true);
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
                                        _model.isDataUploading4 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile4 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl4 =
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

                                    logFirebaseEvent('Image_update_app_state');
                                    setState(() {
                                      FFAppState().photo3 =
                                          _model.uploadedFileUrl4;
                                    });
                                    logFirebaseEvent('Image_update_app_state');
                                    FFAppState().alteraFoto = '';
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().photo3,
                                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25',
                                      ),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EDITAR_PAGE_Image_aecuznsd_ON_TAP');
                                    if (!((FFAppState().photo4 ==
                                            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25') ||
                                        (FFAppState().photo4 == null ||
                                            FFAppState().photo4 == ''))) {
                                      logFirebaseEvent('Image_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 80.0,
                                                child: AlteraFotoWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (FFAppState().alteraFoto == 'exclui') {
                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        setState(() {
                                          FFAppState().photo4 =
                                              'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
                                        });
                                        logFirebaseEvent(
                                            'Image_clear_uploaded_data');
                                        setState(() {
                                          _model.isDataUploading5 = false;
                                          _model.uploadedLocalFile5 =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl5 = '';
                                        });

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().alteraFoto = '';
                                        return;
                                      } else if (FFAppState().alteraFoto ==
                                          'altera') {
                                      } else {
                                        return;
                                      }
                                    }
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 2160.00,
                                      maxHeight: 3840.00,
                                      imageQuality: 70,
                                      allowPhoto: true,
                                      textColor: Colors.black,
                                      pickerFontFamily: 'Fira Sans',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading5 = true);
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
                                        _model.isDataUploading5 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile5 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl5 =
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

                                    logFirebaseEvent('Image_update_app_state');
                                    setState(() {
                                      FFAppState().photo4 =
                                          _model.uploadedFileUrl5;
                                    });
                                    logFirebaseEvent('Image_update_app_state');
                                    FFAppState().alteraFoto = '';
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().photo4,
                                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25',
                                      ),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'EDITAR_PAGE_Image_u2xgmcqv_ON_TAP');
                                    if (!((FFAppState().photo5 ==
                                            'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25') ||
                                        (FFAppState().photo5 == null ||
                                            FFAppState().photo5 == ''))) {
                                      logFirebaseEvent('Image_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height: 80.0,
                                                child: AlteraFotoWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      if (FFAppState().alteraFoto == 'exclui') {
                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        setState(() {
                                          FFAppState().photo5 =
                                              'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
                                        });
                                        logFirebaseEvent(
                                            'Image_clear_uploaded_data');
                                        setState(() {
                                          _model.isDataUploading6 = false;
                                          _model.uploadedLocalFile6 =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl6 = '';
                                        });

                                        logFirebaseEvent(
                                            'Image_update_app_state');
                                        FFAppState().alteraFoto = '';
                                        return;
                                      } else if (FFAppState().alteraFoto ==
                                          'altera') {
                                      } else {
                                        return;
                                      }
                                    }
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 2160.00,
                                      maxHeight: 3840.00,
                                      imageQuality: 70,
                                      allowPhoto: true,
                                      textColor: Colors.black,
                                      pickerFontFamily: 'Fira Sans',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading6 = true);
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
                                        _model.isDataUploading6 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile6 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl6 =
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

                                    logFirebaseEvent('Image_update_app_state');
                                    setState(() {
                                      FFAppState().photo5 =
                                          _model.uploadedFileUrl6;
                                    });
                                    logFirebaseEvent('Image_update_app_state');
                                    FFAppState().alteraFoto = '';
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().photo5,
                                        'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25',
                                      ),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                              carouselController: _model.carouselController ??=
                                  CarouselController(),
                              options: CarouselOptions(
                                initialPage: 1,
                                viewportFraction: 0.5,
                                disableCenter: true,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.25,
                                enableInfiniteScroll: true,
                                scrollDirection: Axis.horizontal,
                                autoPlay: false,
                                onPageChanged: (index, _) =>
                                    _model.carouselCurrentIndex = index,
                              ),
                            ),
                          ),
                        ),
                        if (_model.choiceChipsValue == 'troka')
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Objetos que aceita em troka*',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                        if (_model.choiceChipsValue == 'troka')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 8.0, 15.0, 0.0),
                            child: SwitchListTile.adaptive(
                              value: _model.switchListTileValue2 ??=
                                  editarUserObjectsRecord!.anyCategory,
                              onChanged: (newValue) async {
                                setState(() =>
                                    _model.switchListTileValue2 = newValue!);
                              },
                              title: Text(
                                'Aceito qualquer objeto',
                                style:
                                    trokaTheme.of(context).titleLarge.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                        ),
                              ),
                              tileColor: Colors.white,
                              activeColor: Color(0xFFFC4456),
                              activeTrackColor: Color(0xBEFF5976),
                              dense: false,
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        if ((_model.choiceChipsValue == 'troka') &&
                            (_model.switchListTileValue2 == false))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 0.0),
                            child: trokaCheckboxGroup(
                              options: [
                                'Celulares e Telefones',
                                'Câmeras e Acessórios',
                                'Games',
                                'Computadores e Acessórios',
                                'Eletrônicos, Áudio e Vídeo',
                                'Televisores',
                                'Imóveis',
                                'Veículos e Acessórios',
                                'Móveis',
                                'Eletrodomésticos',
                                'Esportes e Fitness',
                                'Ferramentas',
                                'Beleza e Cuidado Pessoal',
                                'Brinquedos',
                                'Produtos Sustentáveis',
                                'Música e acessórios',
                                'Bebidas e Comidas',
                                'Roupas e Acessórios',
                                'Enfeites e Decoração da Casa',
                                'Joias e Relógios',
                                'Máquinas e Equipamentos',
                                'Livros, Revistas e Comics',
                                'Materiais de Construção'
                              ],
                              onChanged: (val) => setState(
                                  () => _model.checkboxGroupValues = val),
                              controller:
                                  _model.checkboxGroupValueController ??=
                                      FormFieldController<List<String>>(
                                editarUserObjectsRecord?.objectCategoryInterest,
                              ),
                              activeColor: Color(0xFFFC4456),
                              checkColor: Colors.white,
                              checkboxBorderColor: Color(0xFF5D5D5D),
                              textStyle:
                                  trokaTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                              unselectedTextStyle:
                                  trokaTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                              checkboxBorderRadius: BorderRadius.circular(4.0),
                              initialized: _model.checkboxGroupValues != null,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent('EDITAR_PAGE_SALVAR_BTN_ON_TAP');
                              var _shouldSetState = false;
                              if ((_model.choiceChipsValue == null ||
                                      _model.choiceChipsValue == '') ||
                                  (_model.textController1.text == null ||
                                      _model.textController1.text == '') ||
                                  (_model.dropDownValue1 == null ||
                                      _model.dropDownValue1 == '') ||
                                  (_model.dropDownValue2 == null ||
                                      _model.dropDownValue2 == '') ||
                                  (_model.textController2.text == null ||
                                      _model.textController2.text == '') ||
                                  (_model.textController3.text == null ||
                                      _model.textController3.text == '')) {
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
                                if (_shouldSetState) setState(() {});
                                return;
                              } else {
                                if (_model.choiceChipsValue == 'doação') {
                                  logFirebaseEvent('Button_backend_call');
                                  _model.localizationConsult1 =
                                      await CepCall.call(
                                    cep: _model.textController3.text,
                                  );
                                  _shouldSetState = true;
                                  logFirebaseEvent('Button_backend_call');

                                  await editarUserObjectsRecord!.reference
                                      .update(createUserObjectsRecordData(
                                    negotiationType: _model.choiceChipsValue,
                                    title: _model.textController1.text,
                                    objectCategory: _model.dropDownValue1,
                                    objectConditions: _model.dropDownValue2,
                                    description: _model.textController2.text,
                                    cep: _model.textController3.text,
                                    objectId: _model.objIdTextController.text,
                                    uid: currentUserUid,
                                    photo0: FFAppState().photo0,
                                    photo1: editarUserObjectsRecord?.photo1,
                                    photo2: editarUserObjectsRecord?.photo2,
                                    photo3: editarUserObjectsRecord?.photo3,
                                    photo4: editarUserObjectsRecord?.photo4,
                                    photo5: editarUserObjectsRecord?.photo5,
                                    cidade: getJsonField(
                                      (_model.localizationConsult1?.jsonBody ??
                                          ''),
                                      r'''$.localidade''',
                                    ).toString(),
                                    bairro: getJsonField(
                                      (_model.localizationConsult1?.jsonBody ??
                                          ''),
                                      r'''$.bairro''',
                                    ).toString(),
                                    dateAndTime: getCurrentTimestamp,
                                    available: _model.switchListTileValue1,
                                  ));
                                } else if (_model.switchListTileValue2!) {
                                  logFirebaseEvent('Button_backend_call');
                                  _model.localizationConsul2 =
                                      await CepCall.call(
                                    cep: _model.textController3.text,
                                  );
                                  _shouldSetState = true;
                                  logFirebaseEvent('Button_backend_call');

                                  await editarUserObjectsRecord!.reference
                                      .update(createUserObjectsRecordData(
                                    negotiationType: _model.choiceChipsValue,
                                    title: _model.textController1.text,
                                    objectCategory: _model.dropDownValue1,
                                    objectConditions: _model.dropDownValue2,
                                    description: _model.textController2.text,
                                    cep: _model.textController3.text,
                                    objectId: _model.objIdTextController.text,
                                    uid: currentUserUid,
                                    photo0: FFAppState().photo0,
                                    photo1: editarUserObjectsRecord?.photo1,
                                    photo2: editarUserObjectsRecord?.photo2,
                                    photo3: editarUserObjectsRecord?.photo3,
                                    photo4: editarUserObjectsRecord?.photo4,
                                    photo5: editarUserObjectsRecord?.photo5,
                                    cidade: getJsonField(
                                      (_model.localizationConsul2?.jsonBody ??
                                          ''),
                                      r'''$.localidade''',
                                    ).toString(),
                                    bairro: getJsonField(
                                      (_model.localizationConsul2?.jsonBody ??
                                          ''),
                                      r'''$.bairro''',
                                    ).toString(),
                                    dateAndTime: getCurrentTimestamp,
                                    anyCategory: _model.switchListTileValue2,
                                    available: _model.switchListTileValue1,
                                  ));
                                } else {
                                  if (_model.checkboxGroupValues != null &&
                                      (_model.checkboxGroupValues)!
                                          .isNotEmpty) {
                                    logFirebaseEvent('Button_backend_call');
                                    _model.localizationConsul3 =
                                        await CepCall.call(
                                      cep: _model.textController3.text,
                                    );
                                    _shouldSetState = true;
                                    logFirebaseEvent('Button_backend_call');

                                    await editarUserObjectsRecord!.reference
                                        .update({
                                      ...createUserObjectsRecordData(
                                        negotiationType:
                                            _model.choiceChipsValue,
                                        title: _model.textController1.text,
                                        objectCategory: _model.dropDownValue1,
                                        objectConditions: _model.dropDownValue2,
                                        description:
                                            _model.textController2.text,
                                        cep: _model.textController3.text,
                                        objectId:
                                            _model.objIdTextController.text,
                                        uid: currentUserUid,
                                        photo0: FFAppState().photo0,
                                        photo1: editarUserObjectsRecord?.photo1,
                                        photo2: editarUserObjectsRecord?.photo2,
                                        photo3: editarUserObjectsRecord?.photo3,
                                        photo4: editarUserObjectsRecord?.photo4,
                                        photo5: editarUserObjectsRecord?.photo5,
                                        cidade: getJsonField(
                                          (_model.localizationConsul3
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.localidade''',
                                        ).toString(),
                                        bairro: getJsonField(
                                          (_model.localizationConsul3
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.bairro''',
                                        ).toString(),
                                        dateAndTime: getCurrentTimestamp,
                                        anyCategory:
                                            _model.switchListTileValue2,
                                        available: _model.switchListTileValue1,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'objectCategoryInterest':
                                              _model.checkboxGroupValues,
                                        },
                                      ),
                                    });
                                  } else {
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
                                    if (_shouldSetState) setState(() {});
                                    return;
                                  }
                                }

                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Objeto editado!',
                                      style: GoogleFonts.getFont(
                                        'Fira Sans',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 2800),
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              }

                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('meusObjetos');

                              if (_shouldSetState) setState(() {});
                            },
                            text: 'Salvar',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.36,
                              height: MediaQuery.sizeOf(context).height * 0.06,
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
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child: TextFormField(
                              controller: _model.objIdTextController,
                              focusNode: _model.objIdFocusNode,
                              autofocus: false,
                              textCapitalization: TextCapitalization.none,
                              readOnly: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          letterSpacing: 0.0,
                                        ),
                                alignLabelWithHint: false,
                                hintStyle:
                                    trokaTheme.of(context).labelMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF0000),
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Color(0x00FFFFFF),
                              ),
                              style: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Colors.transparent,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.multiline,
                              validator: _model.objIdTextControllerValidator
                                  .asValidator(context),
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
        );
      },
    );
  }
}
