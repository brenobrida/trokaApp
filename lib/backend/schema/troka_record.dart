import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/troka/troka_util.dart';

class TrokaRecord extends FirestoreRecord {
  TrokaRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "objects" field.
  List<String>? _objects;
  List<String> get objects => _objects ?? const [];
  bool hasObjects() => _objects != null;

  // "firstAcess" field.
  bool? _firstAcess;
  bool get firstAcess => _firstAcess ?? false;
  bool hasFirstAcess() => _firstAcess != null;

  // "favoriteObjects" field.
  List<String>? _favoriteObjects;
  List<String> get favoriteObjects => _favoriteObjects ?? const [];
  bool hasFavoriteObjects() => _favoriteObjects != null;

  // "CPF" field.
  String? _cpf;
  String get cpf => _cpf ?? '';
  bool hasCpf() => _cpf != null;

  // "nickname" field.
  String? _nickname;
  String get nickname => _nickname ?? '';
  bool hasNickname() => _nickname != null;

  // "offers" field.
  List<String>? _offers;
  List<String> get offers => _offers ?? const [];
  bool hasOffers() => _offers != null;

  // "userNotifications" field.
  int? _userNotifications;
  int get userNotifications => _userNotifications ?? 0;
  bool hasUserNotifications() => _userNotifications != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _objects = getDataList(snapshotData['objects']);
    _firstAcess = snapshotData['firstAcess'] as bool?;
    _favoriteObjects = getDataList(snapshotData['favoriteObjects']);
    _cpf = snapshotData['CPF'] as String?;
    _nickname = snapshotData['nickname'] as String?;
    _offers = getDataList(snapshotData['offers']);
    _userNotifications = castToType<int>(snapshotData['userNotifications']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('troka');

  static Stream<TrokaRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TrokaRecord.fromSnapshot(s));

  static Future<TrokaRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TrokaRecord.fromSnapshot(s));

  static TrokaRecord fromSnapshot(DocumentSnapshot snapshot) => TrokaRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TrokaRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TrokaRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TrokaRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TrokaRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTrokaRecordData({
  String? email,
  String? displayName,
  String? uid,
  DateTime? createdTime,
  String? photoUrl,
  String? phoneNumber,
  bool? firstAcess,
  String? cpf,
  String? nickname,
  int? userNotifications,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'uid': uid,
      'created_time': createdTime,
      'photo_url': photoUrl,
      'phone_number': phoneNumber,
      'firstAcess': firstAcess,
      'CPF': cpf,
      'nickname': nickname,
      'userNotifications': userNotifications,
    }.withoutNulls,
  );

  return firestoreData;
}

class TrokaRecordDocumentEquality implements Equality<TrokaRecord> {
  const TrokaRecordDocumentEquality();

  @override
  bool equals(TrokaRecord? e1, TrokaRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.phoneNumber == e2?.phoneNumber &&
        listEquality.equals(e1?.objects, e2?.objects) &&
        e1?.firstAcess == e2?.firstAcess &&
        listEquality.equals(e1?.favoriteObjects, e2?.favoriteObjects) &&
        e1?.cpf == e2?.cpf &&
        e1?.nickname == e2?.nickname &&
        listEquality.equals(e1?.offers, e2?.offers) &&
        e1?.userNotifications == e2?.userNotifications;
  }

  @override
  int hash(TrokaRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.uid,
        e?.createdTime,
        e?.photoUrl,
        e?.phoneNumber,
        e?.objects,
        e?.firstAcess,
        e?.favoriteObjects,
        e?.cpf,
        e?.nickname,
        e?.offers,
        e?.userNotifications
      ]);

  @override
  bool isValidKey(Object? o) => o is TrokaRecord;
}
