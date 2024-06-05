import 'dart:convert';
import 'dart:typed_data';

import '/troka/troka_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class CepCall {
  static Future<ApiCallResponse> call({
    String? cep = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'CEP',
      apiUrl: 'https://viacep.com.br/ws/${cep}/json/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'cepConsult': cep,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? bairro(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.bairro''',
      ));
  static String? cidade(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.localidade''',
      ));
}

class BuscaCidadeCall {
  static Future<ApiCallResponse> call({
    String? uf = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'buscaCidade',
      apiUrl:
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf}/municipios',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'UF': uf,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? nomeCidade(dynamic response) => (getJsonField(
        response,
        r'''$[:].nome''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class BuscaCidadeViaLocCall {
  static Future<ApiCallResponse> call({
    double? lat,
    double? lon,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'buscaCidadeViaLoc',
      apiUrl:
          'https://geocode.maps.co/reverse?lat=${lat}&lon=${lon}&api_key=6615cb604748b570475878qxh5a34b5',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'lat': lat,
        'lon': lon,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? adressCity(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address.city''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
