import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';

CollectionReference userRef = FirebaseFirestore.instance.collection('hw2-users');
CollectionReference convRef = FirebaseFirestore.instance.collection('hw2-conversations');

Future<void> modifyUserData(String userID, Map<String, dynamic> data) async {
  await userRef.doc(userID).set(data, SetOptions(merge: true));
}

Future<Map<String, dynamic>?> getUserData(String userID) async {

  return await userRef.doc(userID).get().then((DocumentSnapshot document) {
    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  });

}

String combineTwoIDs(String userOne, String userTwo) {
  print(userOne);
  print(userTwo);
  return userOne.hashCode <= userTwo.hashCode ? userOne + '_' + userTwo : userTwo + '_' + userOne;
}

// TODO modify these Streams to use data objects instead of the built-in QuerySnapshot

Stream<QuerySnapshot> contactsListStream() {
  return userRef.snapshots();
}

Stream<QuerySnapshot> chatsListStream() {
  return convRef.where('members', arrayContains: AuthWrapper.getUserID()).snapshots();
}

Stream<QuerySnapshot> conversationStream(String conversationID) {
  return convRef.doc(conversationID).collection(conversationID)
      .orderBy('timestamp', descending: true)
      .limit(20)
      .snapshots();
}

Future<void> addMessageToConversation(String conversationID, String message) async {
  await convRef.doc(conversationID).collection(conversationID).add({
    'message': message,
    'fromID': AuthWrapper.getUserID(),
    'timestamp': Timestamp.now(),
  });
}
