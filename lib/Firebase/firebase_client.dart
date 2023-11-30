import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:natural_languaje_processing_mobile/models/user.dart';

class FirebaseClient {
  late CollectionReference collection;
  FirebaseClient(String collection) {
    this.collection = FirebaseFirestore.instance.collection(collection);
  }
  void create({required String id, required UserNLP user}) {
    collection.doc(id).set(UserNLP.toJSON(user));
  }

  Future<Map<String, dynamic>> getDocById({required String id}) async {
    final user = await collection.doc(id).get();
    return user.data() as Map<String, dynamic>;
  }
}
