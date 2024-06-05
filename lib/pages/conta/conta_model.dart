import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/troka_widgets.dart';
import '/troka/request_manager.dart';

import 'conta_widget.dart' show ContaWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContaModel extends trokaModel<ContaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Query cache managers for this widget.

  final _userInfoManager = StreamRequestManager<List<TrokaRecord>>();
  Stream<List<TrokaRecord>> userInfo({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TrokaRecord>> Function() requestFn,
  }) =>
      _userInfoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserInfoCache() => _userInfoManager.clear();
  void clearUserInfoCacheKey(String? uniqueKey) =>
      _userInfoManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();

    /// Dispose query cache managers for this widget.

    clearUserInfoCache();
  }
}
