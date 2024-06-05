import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/troka/troka_util.dart';

class SystemSugestionsRecord extends FirestoreRecord {
  SystemSugestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uidObjectInterest" field.
  String? _uidObjectInterest;
  String get uidObjectInterest => _uidObjectInterest ?? '';
  bool hasUidObjectInterest() => _uidObjectInterest != null;

  // "objectInterestId" field.
  String? _objectInterestId;
  String get objectInterestId => _objectInterestId ?? '';
  bool hasObjectInterestId() => _objectInterestId != null;

  // "objectInterestPhoto" field.
  String? _objectInterestPhoto;
  String get objectInterestPhoto => _objectInterestPhoto ?? '';
  bool hasObjectInterestPhoto() => _objectInterestPhoto != null;

  // "objectInterestTitle" field.
  String? _objectInterestTitle;
  String get objectInterestTitle => _objectInterestTitle ?? '';
  bool hasObjectInterestTitle() => _objectInterestTitle != null;

  // "objectInterestCategory" field.
  String? _objectInterestCategory;
  String get objectInterestCategory => _objectInterestCategory ?? '';
  bool hasObjectInterestCategory() => _objectInterestCategory != null;

  // "objectInterestConditions" field.
  String? _objectInterestConditions;
  String get objectInterestConditions => _objectInterestConditions ?? '';
  bool hasObjectInterestConditions() => _objectInterestConditions != null;

  // "objectInterestCidade" field.
  String? _objectInterestCidade;
  String get objectInterestCidade => _objectInterestCidade ?? '';
  bool hasObjectInterestCidade() => _objectInterestCidade != null;

  // "objectInterestBairro" field.
  String? _objectInterestBairro;
  String get objectInterestBairro => _objectInterestBairro ?? '';
  bool hasObjectInterestBairro() => _objectInterestBairro != null;

  // "objectId" field.
  String? _objectId;
  String get objectId => _objectId ?? '';
  bool hasObjectId() => _objectId != null;

  void _initializeFields() {
    _uidObjectInterest = snapshotData['uidObjectInterest'] as String?;
    _objectInterestId = snapshotData['objectInterestId'] as String?;
    _objectInterestPhoto = snapshotData['objectInterestPhoto'] as String?;
    _objectInterestTitle = snapshotData['objectInterestTitle'] as String?;
    _objectInterestCategory = snapshotData['objectInterestCategory'] as String?;
    _objectInterestConditions =
        snapshotData['objectInterestConditions'] as String?;
    _objectInterestCidade = snapshotData['objectInterestCidade'] as String?;
    _objectInterestBairro = snapshotData['objectInterestBairro'] as String?;
    _objectId = snapshotData['objectId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('system_sugestions');

  static Stream<SystemSugestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SystemSugestionsRecord.fromSnapshot(s));

  static Future<SystemSugestionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => SystemSugestionsRecord.fromSnapshot(s));

  static SystemSugestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SystemSugestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SystemSugestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SystemSugestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SystemSugestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SystemSugestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSystemSugestionsRecordData({
  String? uidObjectInterest,
  String? objectInterestId,
  String? objectInterestPhoto,
  String? objectInterestTitle,
  String? objectInterestCategory,
  String? objectInterestConditions,
  String? objectInterestCidade,
  String? objectInterestBairro,
  String? objectId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uidObjectInterest': uidObjectInterest,
      'objectInterestId': objectInterestId,
      'objectInterestPhoto': objectInterestPhoto,
      'objectInterestTitle': objectInterestTitle,
      'objectInterestCategory': objectInterestCategory,
      'objectInterestConditions': objectInterestConditions,
      'objectInterestCidade': objectInterestCidade,
      'objectInterestBairro': objectInterestBairro,
      'objectId': objectId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SystemSugestionsRecordDocumentEquality
    implements Equality<SystemSugestionsRecord> {
  const SystemSugestionsRecordDocumentEquality();

  @override
  bool equals(SystemSugestionsRecord? e1, SystemSugestionsRecord? e2) {
    return e1?.uidObjectInterest == e2?.uidObjectInterest &&
        e1?.objectInterestId == e2?.objectInterestId &&
        e1?.objectInterestPhoto == e2?.objectInterestPhoto &&
        e1?.objectInterestTitle == e2?.objectInterestTitle &&
        e1?.objectInterestCategory == e2?.objectInterestCategory &&
        e1?.objectInterestConditions == e2?.objectInterestConditions &&
        e1?.objectInterestCidade == e2?.objectInterestCidade &&
        e1?.objectInterestBairro == e2?.objectInterestBairro &&
        e1?.objectId == e2?.objectId;
  }

  @override
  int hash(SystemSugestionsRecord? e) => const ListEquality().hash([
        e?.uidObjectInterest,
        e?.objectInterestId,
        e?.objectInterestPhoto,
        e?.objectInterestTitle,
        e?.objectInterestCategory,
        e?.objectInterestConditions,
        e?.objectInterestCidade,
        e?.objectInterestBairro,
        e?.objectId
      ]);

  @override
  bool isValidKey(Object? o) => o is SystemSugestionsRecord;
}
