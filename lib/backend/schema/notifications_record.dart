import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/troka/troka_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "viewed" field.
  bool? _viewed;
  bool get viewed => _viewed ?? false;
  bool hasViewed() => _viewed != null;

  // "objectImage" field.
  String? _objectImage;
  String get objectImage => _objectImage ?? '';
  bool hasObjectImage() => _objectImage != null;

  // "objectTitle" field.
  String? _objectTitle;
  String get objectTitle => _objectTitle ?? '';
  bool hasObjectTitle() => _objectTitle != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "offerAccepted" field.
  bool? _offerAccepted;
  bool get offerAccepted => _offerAccepted ?? false;
  bool hasOfferAccepted() => _offerAccepted != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _viewed = snapshotData['viewed'] as bool?;
    _objectImage = snapshotData['objectImage'] as String?;
    _objectTitle = snapshotData['objectTitle'] as String?;
    _uid = snapshotData['uid'] as String?;
    _offerAccepted = snapshotData['offerAccepted'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  String? type,
  DateTime? dateTime,
  bool? viewed,
  String? objectImage,
  String? objectTitle,
  String? uid,
  bool? offerAccepted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'dateTime': dateTime,
      'viewed': viewed,
      'objectImage': objectImage,
      'objectTitle': objectTitle,
      'uid': uid,
      'offerAccepted': offerAccepted,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.type == e2?.type &&
        e1?.dateTime == e2?.dateTime &&
        e1?.viewed == e2?.viewed &&
        e1?.objectImage == e2?.objectImage &&
        e1?.objectTitle == e2?.objectTitle &&
        e1?.uid == e2?.uid &&
        e1?.offerAccepted == e2?.offerAccepted;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.type,
        e?.dateTime,
        e?.viewed,
        e?.objectImage,
        e?.objectTitle,
        e?.uid,
        e?.offerAccepted
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
