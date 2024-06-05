import '/backend/api_requests/api_calls.dart';
import '/troka/troka_checkbox_group.dart';
import '/troka/troka_choice_chips.dart';
import '/troka/troka_drop_down.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filtro_model.dart';
export 'filtro_model.dart';

class FiltroWidget extends StatefulWidget {
  const FiltroWidget({super.key});

  @override
  State<FiltroWidget> createState() => _FiltroWidgetState();
}

class _FiltroWidgetState extends State<FiltroWidget> {
  late FiltroModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FiltroModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'filtro'});
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
        backgroundColor: Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.sizeOf(context).height * 0.08),
          child: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xFF5D5D5D)),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('FILTRO_PAGE_CANCELAR_BTN_ON_TAP');
                    logFirebaseEvent('Button_navigate_back');
                    context.safePop();
                  },
                  text: 'Cancelar',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.white,
                    textStyle: trokaTheme.of(context).titleSmall.override(
                          fontFamily: 'Fira Sans',
                          color: Color(0xFFFC4456),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Text(
                  'Filtros',
                  style: trokaTheme.of(context).headlineMedium.override(
                        fontFamily: 'Fira Sans',
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('FILTRO_PAGE_LIMPAR_BTN_ON_TAP');
                    logFirebaseEvent('Button_update_app_state');
                    FFAppState().filterUF = '';
                    FFAppState().filterCity = '';
                    FFAppState().filterObjectCategory = '';
                    FFAppState().filterObjectInterest = [];
                    FFAppState().filterAnyCategoryInterest = false;
                    FFAppState().filterObjectCondition = [];
                    FFAppState().filterChoice = '';
                    FFAppState().isFiltered = false;
                    logFirebaseEvent('Button_navigate_to');

                    context.pushNamed(
                      'explorar',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.topToBottom,
                        ),
                      },
                    );
                  },
                  text: 'Limpar  ',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.white,
                    textStyle: trokaTheme.of(context).titleSmall.override(
                          fontFamily: 'Fira Sans',
                          color: Color(0xFFFC4456),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: MediaQuery.sizeOf(context).height * 0.08,
            elevation: 1.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 28.0, 0.0, 0.0),
                              child: Text(
                                'Localização',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 16.0,
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
                                  15.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Selecione o estado:',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 8.0, 15.0, 0.0),
                            child: trokaDropDown<String>(
                              controller: _model.dropDownValueController1 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue1 ??= FFAppState().filterUF,
                              ),
                              options: [
                                'AC',
                                'AL',
                                'AP',
                                'AM',
                                'BA',
                                'CE',
                                'DF',
                                'ES',
                                'GO',
                                'MA',
                                'MT',
                                'MS',
                                'MG',
                                'PA',
                                'PB',
                                'PR',
                                'PE',
                                'PI',
                                'RJ',
                                'RN',
                                'RS',
                                'RO',
                                'RR',
                                'SC',
                                'SP',
                                'SE',
                                'TO'
                              ],
                              onChanged: (val) async {
                                setState(() => _model.dropDownValue1 = val);
                                logFirebaseEvent(
                                    'FILTRO_DropDown_u8myqdlh_ON_FORM_WIDGET_');
                                var _shouldSetState = false;
                                logFirebaseEvent('DropDown_backend_call');
                                _model.apiResultx2v =
                                    await BuscaCidadeCall.call(
                                  uf: _model.dropDownValue1,
                                );
                                _shouldSetState = true;
                                if ((_model.apiResultx2v?.succeeded ?? true)) {
                                  logFirebaseEvent('DropDown_update_app_state');
                                  setState(() {
                                    FFAppState().citiesList = (getJsonField(
                                      (_model.apiResultx2v?.jsonBody ?? ''),
                                      r'''$[:].nome''',
                                      true,
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList()!
                                        .toList()
                                        .cast<String>();
                                  });
                                } else {
                                  if (_shouldSetState) setState(() {});
                                  return;
                                }

                                if (_shouldSetState) setState(() {});
                              },
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
                              labelText: '',
                              labelTextStyle: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Color(0xFF5D5D5D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Selecione a cidade:',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 8.0, 15.0, 0.0),
                            child: trokaDropDown<String>(
                              controller: _model.dropDownValueController2 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue2 ??=
                                    FFAppState().filterCity,
                              ),
                              options: FFAppState().citiesList,
                              onChanged: (val) =>
                                  setState(() => _model.dropDownValue2 = val),
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.08,
                              searchHintTextStyle:
                                  trokaTheme.of(context).labelMedium.override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                              searchTextStyle:
                                  trokaTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                              textStyle:
                                  trokaTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                              searchHintText: 'Pesquise sua cidade...',
                              searchCursorColor: Colors.black,
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
                              isSearchable: true,
                              isMultiSelect: false,
                              labelText: 'Selecione a cidade',
                              labelTextStyle: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Color(0xFF5D5D5D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Encontrar objetos para:',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 12.0,
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
                                  ChipData('troka', Icons.cached_rounded),
                                  ChipData('doação', Icons.favorite_rounded)
                                ],
                                onChanged: (val) => setState(() =>
                                    _model.choiceChipsValue = val?.firstOrNull),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor: Color(0xFFFC4456),
                                  textStyle: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Colors.white,
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
                                  textStyle: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Color(0xFFB6B6B6),
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
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                  [FFAppState().filterChoice],
                                ),
                                wrapped: false,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Condições:',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 0.0),
                            child: trokaCheckboxGroup(
                              options: [
                                'Novo',
                                'Usado',
                                'Recondicionado',
                                'Com defeito'
                              ],
                              onChanged: (val) => setState(
                                  () => _model.objectConditionsValues = val),
                              controller:
                                  _model.objectConditionsValueController ??=
                                      FormFieldController<List<String>>(
                                FFAppState().filterObjectCondition,
                              ),
                              activeColor: Color(0xFFFC4456),
                              checkColor: Colors.white,
                              checkboxBorderColor: Color(0xFFB6B6B6),
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
                                        letterSpacing: 0.0,
                                      ),
                              checkboxBorderRadius: BorderRadius.circular(4.0),
                              initialized:
                                  _model.objectConditionsValues != null,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Selecione a categoria do objeto:',
                                style:
                                    trokaTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Fira Sans',
                                          color: Color(0xFF5D5D5D),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 8.0, 15.0, 0.0),
                            child: trokaDropDown<String>(
                              controller: _model.dropDownValueController3 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue3 ??=
                                    FFAppState().filterObjectCategory,
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
                                  setState(() => _model.dropDownValue3 = val),
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
                              labelText: '',
                              labelTextStyle: GoogleFonts.getFont(
                                'Fira Sans',
                                color: Color(0xFF5D5D5D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          if (_model.choiceChipsValue == 'troka')
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 28.0, 0.0, 0.0),
                                child: Text(
                                  'Categorias para oferecer em troka:',
                                  style: trokaTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Fira Sans',
                                        color: Color(0xFF5D5D5D),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          if (_model.choiceChipsValue == 'troka')
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
                                onChanged: (val) => setState(() => _model
                                    .objectCategoriesInterestValues = val),
                                controller: _model
                                        .objectCategoriesInterestValueController ??=
                                    FormFieldController<List<String>>(
                                  FFAppState().filterObjectInterest,
                                ),
                                activeColor: Color(0xFFFC4456),
                                checkColor: Colors.white,
                                checkboxBorderColor: Color(0xFFB6B6B6),
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
                                checkboxBorderRadius:
                                    BorderRadius.circular(4.0),
                                initialized:
                                    _model.objectCategoriesInterestValues !=
                                        null,
                              ),
                            ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 28.0, 0.0, 0.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 0.0,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.0,
                                    ),
                                  ),
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
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            -1.0,
                          ),
                        )
                      ],
                      border: Border.all(
                        color: Color(0x00B6B6B6),
                        width: 0.0,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent('FILTRO_PAGE_FILTRAR_BTN_ON_TAP');
                          logFirebaseEvent('Button_update_app_state');
                          FFAppState().isFiltered = true;
                          await Future.wait([
                            Future(() async {
                              logFirebaseEvent('Button_update_app_state');
                              FFAppState().filterUF = _model.dropDownValue1!;
                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('explorar');
                            }),
                            Future(() async {
                              logFirebaseEvent('Button_update_app_state');
                              FFAppState().filterCity = _model.dropDownValue2!;
                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('explorar');
                            }),
                            Future(() async {
                              logFirebaseEvent('Button_update_app_state');
                              FFAppState().filterChoice =
                                  _model.choiceChipsValue!;
                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('explorar');
                            }),
                            Future(() async {
                              logFirebaseEvent('Button_update_app_state');
                              FFAppState().filterObjectCategory =
                                  _model.dropDownValue3!;
                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('explorar');
                            }),
                            Future(() async {
                              logFirebaseEvent('Button_update_app_state');
                              FFAppState().filterObjectInterest = _model
                                  .objectCategoriesInterestValues!
                                  .toList()
                                  .cast<String>();
                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('explorar');
                            }),
                            Future(() async {
                              logFirebaseEvent('Button_update_app_state');
                              FFAppState().filterObjectCondition = _model
                                  .objectConditionsValues!
                                  .toList()
                                  .cast<String>();
                              logFirebaseEvent('Button_navigate_to');

                              context.pushNamed('explorar');
                            }),
                          ]);
                        },
                        text: 'Filtrar',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFFC4456),
                          textStyle: trokaTheme.of(context).titleSmall.override(
                                fontFamily: 'Fira Sans',
                                color: Colors.white,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                              ),
                          elevation: 1.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
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
