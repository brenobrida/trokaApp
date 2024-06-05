import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/troka/troka_util.dart';

class OffersRecord extends FirestoreRecord {
  OffersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "offerDateTime" field.
  DateTime? _offerDateTime;
  DateTime? get offerDateTime => _offerDateTime;
  bool hasOfferDateTime() => _offerDateTime != null;

  // "uidWhoOfferd" field.
  String? _uidWhoOfferd;
  String get uidWhoOfferd => _uidWhoOfferd ?? '';
  bool hasUidWhoOfferd() => _uidWhoOfferd != null;

  // "uidReceivedOffer" field.
  String? _uidReceivedOffer;
  String get uidReceivedOffer => _uidReceivedOffer ?? '';
  bool hasUidReceivedOffer() => _uidReceivedOffer != null;

  // "offerAccepted" field.
  bool? _offerAccepted;
  bool get offerAccepted => _offerAccepted ?? false;
  bool hasOfferAccepted() => _offerAccepted != null;

  // "objectOfferTitle" field.
  String? _objectOfferTitle;
  String get objectOfferTitle => _objectOfferTitle ?? '';
  bool hasObjectOfferTitle() => _objectOfferTitle != null;

  // "objectOfferCategory" field.
  String? _objectOfferCategory;
  String get objectOfferCategory => _objectOfferCategory ?? '';
  bool hasObjectOfferCategory() => _objectOfferCategory != null;

  // "objectOfferId" field.
  String? _objectOfferId;
  String get objectOfferId => _objectOfferId ?? '';
  bool hasObjectOfferId() => _objectOfferId != null;

  // "objectOfferConditions" field.
  String? _objectOfferConditions;
  String get objectOfferConditions => _objectOfferConditions ?? '';
  bool hasObjectOfferConditions() => _objectOfferConditions != null;

  // "objectOfferCidade" field.
  String? _objectOfferCidade;
  String get objectOfferCidade => _objectOfferCidade ?? '';
  bool hasObjectOfferCidade() => _objectOfferCidade != null;

  // "objectOfferBairro" field.
  String? _objectOfferBairro;
  String get objectOfferBairro => _objectOfferBairro ?? '';
  bool hasObjectOfferBairro() => _objectOfferBairro != null;

  // "objectOfferPhoto" field.
  String? _objectOfferPhoto;
  String get objectOfferPhoto => _objectOfferPhoto ?? '';
  bool hasObjectOfferPhoto() => _objectOfferPhoto != null;

  // "objectInterestPhoto" field.
  String? _objectInterestPhoto;
  String get objectInterestPhoto => _objectInterestPhoto ?? '';
  bool hasObjectInterestPhoto() => _objectInterestPhoto != null;

  // "objectInterestTitle" field.
  String? _objectInterestTitle;
  String get objectInterestTitle => _objectInterestTitle ?? '';
  bool hasObjectInterestTitle() => _objectInterestTitle != null;

  // "offerViewed" field.
  bool? _offerViewed;
  bool get offerViewed => _offerViewed ?? false;
  bool hasOfferViewed() => _offerViewed != null;

  // "offerId" field.
  String? _offerId;
  String get offerId => _offerId ?? '';
  bool hasOfferId() => _offerId != null;

  // "objectInteresCategory" field.
  String? _objectInteresCategory;
  String get objectInteresCategory => _objectInteresCategory ?? '';
  bool hasObjectInteresCategory() => _objectInteresCategory != null;

  // "objectInterestConditions" field.
  String? _objectInterestConditions;
  String get objectInterestConditions => _objectInterestConditions ?? '';
  bool hasObjectInterestConditions() => _objectInterestConditions != null;

  // "objectInterestId" field.
  String? _objectInterestId;
  String get objectInterestId => _objectInterestId ?? '';
  bool hasObjectInterestId() => _objectInterestId != null;

  // "objectInterestCidade" field.
  String? _objectInterestCidade;
  String get objectInterestCidade => _objectInterestCidade ?? '';
  bool hasObjectInterestCidade() => _objectInterestCidade != null;

  // "objectInterestBairro" field.
  String? _objectInterestBairro;
  String get objectInterestBairro => _objectInterestBairro ?? '';
  bool hasObjectInterestBairro() => _objectInterestBairro != null;

  // "lastMessage" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "lastMessageOwner" field.
  String? _lastMessageOwner;
  String get lastMessageOwner => _lastMessageOwner ?? '';
  bool hasLastMessageOwner() => _lastMessageOwner != null;

  // "messageTime" field.
  DateTime? _messageTime;
  DateTime? get messageTime => _messageTime;
  bool hasMessageTime() => _messageTime != null;

  // "offerCategory" field.
  String? _offerCategory;
  String get offerCategory => _offerCategory ?? '';
  bool hasOfferCategory() => _offerCategory != null;

  void _initializeFields() {
    _offerDateTime = snapshotData['offerDateTime'] as DateTime?;
    _uidWhoOfferd = snapshotData['uidWhoOfferd'] as String?;
    _uidReceivedOffer = snapshotData['uidReceivedOffer'] as String?;
    _offerAccepted = snapshotData['offerAccepted'] as bool?;
    _objectOfferTitle = snapshotData['objectOfferTitle'] as String?;
    _objectOfferCategory = snapshotData['objectOfferCategory'] as String?;
    _objectOfferId = snapshotData['objectOfferId'] as String?;
    _objectOfferConditions = snapshotData['objectOfferConditions'] as String?;
    _objectOfferCidade = snapshotData['objectOfferCidade'] as String?;
    _objectOfferBairro = snapshotData['objectOfferBairro'] as String?;
    _objectOfferPhoto = snapshotData['objectOfferPhoto'] as String?;
    _objectInterestPhoto = snapshotData['objectInterestPhoto'] as String?;
    _objectInterestTitle = snapshotData['objectInterestTitle'] as String?;
    _offerViewed = snapshotData['offerViewed'] as bool?;
    _offerId = snapshotData['offerId'] as String?;
    _objectInteresCategory = snapshotData['objectInteresCategory'] as String?;
    _objectInterestConditions =
        snapshotData['objectInterestConditions'] as String?;
    _objectInterestId = snapshotData['objectInterestId'] as String?;
    _objectInterestCidade = snapshotData['objectInterestCidade'] as String?;
    _objectInterestBairro = snapshotData['objectInterestBairro'] as String?;
    _lastMessage = snapshotData['lastMessage'] as String?;
    _lastMessageOwner = snapshotData['lastMessageOwner'] as String?;
    _messageTime = snapshotData['messageTime'] as DateTime?;
    _offerCategory = snapshotData['offerCategory'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('offers');

  static Stream<OffersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OffersRecord.fromSnapshot(s));

  static Future<OffersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OffersRecord.fromSnapshot(s));

  static OffersRecord fromSnapshot(DocumentSnapshot snapshot) => OffersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OffersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OffersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OffersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OffersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOffersRecordData({
  DateTime? offerDateTime,
  String? uidWhoOfferd,
  String? uidReceivedOffer,
  bool? offerAccepted,
  String? objectOfferTitle,
  String? objectOfferCategory,
  String? objectOfferId,
  String? objectOfferConditions,
  String? objectOfferCidade,
  String? objectOfferBairro,
  String? objectOfferPhoto,
  String? objectInterestPhoto,
  String? objectInterestTitle,
  bool? offerViewed,
  String? offerId,
  String? objectInteresCategory,
  String? objectInterestConditions,
  String? objectInterestId,
  String? objectInterestCidade,
  String? objectInterestBairro,
  String? lastMessage,
  String? lastMessageOwner,
  DateTime? messageTime,
  String? offerCategory,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'offerDateTime': offerDateTime,
      'uidWhoOfferd': uidWhoOfferd,
      'uidReceivedOffer': uidReceivedOffer,
      'offerAccepted': offerAccepted,
      'objectOfferTitle': objectOfferTitle,
      'objectOfferCategory': objectOfferCategory,
      'objectOfferId': objectOfferId,
      'objectOfferConditions': objectOfferConditions,
      'objectOfferCidade': objectOfferCidade,
      'objectOfferBairro': objectOfferBairro,
      'objectOfferPhoto': objectOfferPhoto,
      'objectInterestPhoto': objectInterestPhoto,
      'objectInterestTitle': objectInterestTitle,
      'offerViewed': offerViewed,
      'offerId': offerId,
      'objectInteresCategory': objectInteresCategory,
      'objectInterestConditions': objectInterestConditions,
      'objectInterestId': objectInterestId,
      'objectInterestCidade': objectInterestCidade,
      'objectInterestBairro': objectInterestBairro,
      'lastMessage': lastMessage,
      'lastMessageOwner': lastMessageOwner,
      'messageTime': messageTime,
      'offerCategory': offerCategory,
    }.withoutNulls,
  );

  return firestoreData;
}

class OffersRecordDocumentEquality implements Equality<OffersRecord> {
  const OffersRecordDocumentEquality();

  @override
  bool equals(OffersRecord? e1, OffersRecord? e2) {
    return e1?.offerDateTime == e2?.offerDateTime &&
        e1?.uidWhoOfferd == e2?.uidWhoOfferd &&
        e1?.uidReceivedOffer == e2?.uidReceivedOffer &&
        e1?.offerAccepted == e2?.offerAccepted &&
        e1?.objectOfferTitle == e2?.objectOfferTitle &&
        e1?.objectOfferCategory == e2?.objectOfferCategory &&
        e1?.objectOfferId == e2?.objectOfferId &&
        e1?.objectOfferConditions == e2?.objectOfferConditions &&
        e1?.objectOfferCidade == e2?.objectOfferCidade &&
        e1?.objectOfferBairro == e2?.objectOfferBairro &&
        e1?.objectOfferPhoto == e2?.objectOfferPhoto &&
        e1?.objectInterestPhoto == e2?.objectInterestPhoto &&
        e1?.objectInterestTitle == e2?.objectInterestTitle &&
        e1?.offerViewed == e2?.offerViewed &&
        e1?.offerId == e2?.offerId &&
        e1?.objectInteresCategory == e2?.objectInteresCategory &&
        e1?.objectInterestConditions == e2?.objectInterestConditions &&
        e1?.objectInterestId == e2?.objectInterestId &&
        e1?.objectInterestCidade == e2?.objectInterestCidade &&
        e1?.objectInterestBairro == e2?.objectInterestBairro &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageOwner == e2?.lastMessageOwner &&
        e1?.messageTime == e2?.messageTime &&
        e1?.offerCategory == e2?.offerCategory;
  }

  @override
  int hash(OffersRecord? e) => const ListEquality().hash([
        e?.offerDateTime,
        e?.uidWhoOfferd,
        e?.uidReceivedOffer,
        e?.offerAccepted,
        e?.objectOfferTitle,
        e?.objectOfferCategory,
        e?.objectOfferId,
        e?.objectOfferConditions,
        e?.objectOfferCidade,
        e?.objectOfferBairro,
        e?.objectOfferPhoto,
        e?.objectInterestPhoto,
        e?.objectInterestTitle,
        e?.offerViewed,
        e?.offerId,
        e?.objectInteresCategory,
        e?.objectInterestConditions,
        e?.objectInterestId,
        e?.objectInterestCidade,
        e?.objectInterestBairro,
        e?.lastMessage,
        e?.lastMessageOwner,
        e?.messageTime,
        e?.offerCategory
      ]);

  @override
  bool isValidKey(Object? o) => o is OffersRecord;
}
