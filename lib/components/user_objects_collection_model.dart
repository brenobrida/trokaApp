import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_search_text_widget.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import '/troka/request_manager.dart';

import 'user_objects_collection_widget.dart' show UserObjectsCollectionWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class UserObjectsCollectionModel
    extends trokaModel<UserObjectsCollectionWidget> {
  /// Query cache managers for this widget.

  final _userObjectsCollectionManager =
      StreamRequestManager<List<UserObjectsRecord>>();
  Stream<List<UserObjectsRecord>> userObjectsCollection({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UserObjectsRecord>> Function() requestFn,
  }) =>
      _userObjectsCollectionManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserObjectsCollectionCache() =>
      _userObjectsCollectionManager.clear();
  void clearUserObjectsCollectionCacheKey(String? uniqueKey) =>
      _userObjectsCollectionManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearUserObjectsCollectionCache();
  }
}
