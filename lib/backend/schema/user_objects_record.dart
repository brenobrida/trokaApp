import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/troka/troka_util.dart';

class UserObjectsRecord extends FirestoreRecord {
  UserObjectsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "negotiationType" field.
  String? _negotiationType;
  String get negotiationType => _negotiationType ?? '';
  bool hasNegotiationType() => _negotiationType != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "objectCategory" field.
  String? _objectCategory;
  String get objectCategory => _objectCategory ?? '';
  bool hasObjectCategory() => _objectCategory != null;

  // "objectConditions" field.
  String? _objectConditions;
  String get objectConditions => _objectConditions ?? '';
  bool hasObjectConditions() => _objectConditions != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "cep" field.
  String? _cep;
  String get cep => _cep ?? '';
  bool hasCep() => _cep != null;

  // "objectCategoryInterest" field.
  List<String>? _objectCategoryInterest;
  List<String> get objectCategoryInterest =>
      _objectCategoryInterest ?? const [];
  bool hasObjectCategoryInterest() => _objectCategoryInterest != null;

  // "objectId" field.
  String? _objectId;
  String get objectId => _objectId ?? '';
  bool hasObjectId() => _objectId != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "photo0" field.
  String? _photo0;
  String get photo0 => _photo0 ?? '';
  bool hasPhoto0() => _photo0 != null;

  // "photo1" field.
  String? _photo1;
  String get photo1 => _photo1 ?? '';
  bool hasPhoto1() => _photo1 != null;

  // "photo2" field.
  String? _photo2;
  String get photo2 => _photo2 ?? '';
  bool hasPhoto2() => _photo2 != null;

  // "photo3" field.
  String? _photo3;
  String get photo3 => _photo3 ?? '';
  bool hasPhoto3() => _photo3 != null;

  // "photo4" field.
  String? _photo4;
  String get photo4 => _photo4 ?? '';
  bool hasPhoto4() => _photo4 != null;

  // "photo5" field.
  String? _photo5;
  String get photo5 => _photo5 ?? '';
  bool hasPhoto5() => _photo5 != null;

  // "anyCategory" field.
  bool? _anyCategory;
  bool get anyCategory => _anyCategory ?? false;
  bool hasAnyCategory() => _anyCategory != null;

  // "dateAndTime" field.
  DateTime? _dateAndTime;
  DateTime? get dateAndTime => _dateAndTime;
  bool hasDateAndTime() => _dateAndTime != null;

  // "cidade" field.
  String? _cidade;
  String get cidade => _cidade ?? '';
  bool hasCidade() => _cidade != null;

  // "bairro" field.
  String? _bairro;
  String get bairro => _bairro ?? '';
  bool hasBairro() => _bairro != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "offeredSugestionsObjectsId" field.
  List<String>? _offeredSugestionsObjectsId;
  List<String> get offeredSugestionsObjectsId =>
      _offeredSugestionsObjectsId ?? const [];
  bool hasOfferedSugestionsObjectsId() => _offeredSugestionsObjectsId != null;

  // "available" field.
  bool? _available;
  bool get available => _available ?? false;
  bool hasAvailable() => _available != null;

  void _initializeFields() {
    _negotiationType = snapshotData['negotiationType'] as String?;
    _title = snapshotData['title'] as String?;
    _objectCategory = snapshotData['objectCategory'] as String?;
    _objectConditions = snapshotData['objectConditions'] as String?;
    _description = snapshotData['description'] as String?;
    _cep = snapshotData['cep'] as String?;
    _objectCategoryInterest =
        getDataList(snapshotData['objectCategoryInterest']);
    _objectId = snapshotData['objectId'] as String?;
    _uid = snapshotData['uid'] as String?;
    _photo0 = snapshotData['photo0'] as String?;
    _photo1 = snapshotData['photo1'] as String?;
    _photo2 = snapshotData['photo2'] as String?;
    _photo3 = snapshotData['photo3'] as String?;
    _photo4 = snapshotData['photo4'] as String?;
    _photo5 = snapshotData['photo5'] as String?;
    _anyCategory = snapshotData['anyCategory'] as bool?;
    _dateAndTime = snapshotData['dateAndTime'] as DateTime?;
    _cidade = snapshotData['cidade'] as String?;
    _bairro = snapshotData['bairro'] as String?;
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _offeredSugestionsObjectsId =
        getDataList(snapshotData['offeredSugestionsObjectsId']);
    _available = snapshotData['available'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_objects');

  static Stream<UserObjectsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserObjectsRecord.fromSnapshot(s));

  static Future<UserObjectsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserObjectsRecord.fromSnapshot(s));

  static UserObjectsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserObjectsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserObjectsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserObjectsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserObjectsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserObjectsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserObjectsRecordData({
  String? negotiationType,
  String? title,
  String? objectCategory,
  String? objectConditions,
  String? description,
  String? cep,
  String? objectId,
  String? uid,
  String? photo0,
  String? photo1,
  String? photo2,
  String? photo3,
  String? photo4,
  String? photo5,
  bool? anyCategory,
  DateTime? dateAndTime,
  String? cidade,
  String? bairro,
  String? email,
  String? displayName,
  String? photoUrl,
  DateTime? createdTime,
  String? phoneNumber,
  bool? available,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'negotiationType': negotiationType,
      'title': title,
      'objectCategory': objectCategory,
      'objectConditions': objectConditions,
      'description': description,
      'cep': cep,
      'objectId': objectId,
      'uid': uid,
      'photo0': photo0,
      'photo1': photo1,
      'photo2': photo2,
      'photo3': photo3,
      'photo4': photo4,
      'photo5': photo5,
      'anyCategory': anyCategory,
      'dateAndTime': dateAndTime,
      'cidade': cidade,
      'bairro': bairro,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'available': available,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserObjectsRecordDocumentEquality implements Equality<UserObjectsRecord> {
  const UserObjectsRecordDocumentEquality();

  @override
  bool equals(UserObjectsRecord? e1, UserObjectsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.negotiationType == e2?.negotiationType &&
        e1?.title == e2?.title &&
        e1?.objectCategory == e2?.objectCategory &&
        e1?.objectConditions == e2?.objectConditions &&
        e1?.description == e2?.description &&
        e1?.cep == e2?.cep &&
        listEquality.equals(
            e1?.objectCategoryInterest, e2?.objectCategoryInterest) &&
        e1?.objectId == e2?.objectId &&
        e1?.uid == e2?.uid &&
        e1?.photo0 == e2?.photo0 &&
        e1?.photo1 == e2?.photo1 &&
        e1?.photo2 == e2?.photo2 &&
        e1?.photo3 == e2?.photo3 &&
        e1?.photo4 == e2?.photo4 &&
        e1?.photo5 == e2?.photo5 &&
        e1?.anyCategory == e2?.anyCategory &&
        e1?.dateAndTime == e2?.dateAndTime &&
        e1?.cidade == e2?.cidade &&
        e1?.bairro == e2?.bairro &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        listEquality.equals(
            e1?.offeredSugestionsObjectsId, e2?.offeredSugestionsObjectsId) &&
        e1?.available == e2?.available;
  }

  @override
  int hash(UserObjectsRecord? e) => const ListEquality().hash([
        e?.negotiationType,
        e?.title,
        e?.objectCategory,
        e?.objectConditions,
        e?.description,
        e?.cep,
        e?.objectCategoryInterest,
        e?.objectId,
        e?.uid,
        e?.photo0,
        e?.photo1,
        e?.photo2,
        e?.photo3,
        e?.photo4,
        e?.photo5,
        e?.anyCategory,
        e?.dateAndTime,
        e?.cidade,
        e?.bairro,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.createdTime,
        e?.phoneNumber,
        e?.offeredSugestionsObjectsId,
        e?.available
      ]);

  @override
  bool isValidKey(Object? o) => o is UserObjectsRecord;
}
