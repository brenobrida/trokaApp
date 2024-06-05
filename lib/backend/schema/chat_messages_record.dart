import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/troka/troka_util.dart';

class ChatMessagesRecord extends FirestoreRecord {
  ChatMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "offerId" field.
  String? _offerId;
  String get offerId => _offerId ?? '';
  bool hasOfferId() => _offerId != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "userImage" field.
  String? _userImage;
  String get userImage => _userImage ?? '';
  bool hasUserImage() => _userImage != null;

  // "userNickname" field.
  String? _userNickname;
  String get userNickname => _userNickname ?? '';
  bool hasUserNickname() => _userNickname != null;

  // "imageMessage" field.
  String? _imageMessage;
  String get imageMessage => _imageMessage ?? '';
  bool hasImageMessage() => _imageMessage != null;

  void _initializeFields() {
    _offerId = snapshotData['offerId'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _message = snapshotData['message'] as String?;
    _uid = snapshotData['uid'] as String?;
    _userImage = snapshotData['userImage'] as String?;
    _userNickname = snapshotData['userNickname'] as String?;
    _imageMessage = snapshotData['imageMessage'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chatMessages');

  static Stream<ChatMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatMessagesRecord.fromSnapshot(s));

  static Future<ChatMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatMessagesRecord.fromSnapshot(s));

  static ChatMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatMessagesRecordData({
  String? offerId,
  DateTime? dateTime,
  String? message,
  String? uid,
  String? userImage,
  String? userNickname,
  String? imageMessage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'offerId': offerId,
      'dateTime': dateTime,
      'message': message,
      'uid': uid,
      'userImage': userImage,
      'userNickname': userNickname,
      'imageMessage': imageMessage,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatMessagesRecordDocumentEquality
    implements Equality<ChatMessagesRecord> {
  const ChatMessagesRecordDocumentEquality();

  @override
  bool equals(ChatMessagesRecord? e1, ChatMessagesRecord? e2) {
    return e1?.offerId == e2?.offerId &&
        e1?.dateTime == e2?.dateTime &&
        e1?.message == e2?.message &&
        e1?.uid == e2?.uid &&
        e1?.userImage == e2?.userImage &&
        e1?.userNickname == e2?.userNickname &&
        e1?.imageMessage == e2?.imageMessage;
  }

  @override
  int hash(ChatMessagesRecord? e) => const ListEquality().hash([
        e?.offerId,
        e?.dateTime,
        e?.message,
        e?.uid,
        e?.userImage,
        e?.userNickname,
        e?.imageMessage
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatMessagesRecord;
}
