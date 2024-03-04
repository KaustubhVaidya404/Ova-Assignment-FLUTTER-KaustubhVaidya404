import 'package:chatlily/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUser() {
    return _firestore.collection('users').snapshots().map((event) {
      return event.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String usermessage, String receiverID) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message message = Message(
        message: usermessage,
        senderID: currentUserId,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        timestamp: timestamp);

    List<String> users = [currentUserId, receiverID];
    users.sort();
    String charRoomId = users.join("_");

    await _firestore
        .collection('chats')
        .doc(charRoomId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserId) {
    List<String> users = [userID, otherUserId];
    users.sort();
    String chatRoomId = users.join("_");

    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
