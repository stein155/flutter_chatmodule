import 'package:chatmodule/service/backend_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService implements BackendService {
  late DatabaseReference _db;

  FirebaseService() {
    _db = FirebaseDatabase.instance.ref();
  }

  @override
  String getUserId() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.uid;
    }

    return '';
  }

  @override
  Stream streamData(String path) {
    return _db.child(path).onValue;
  }

  @override
  Future<void> createData(String path, dynamic data) async {
    final ref = _db.child(path).push();
    await ref.set(data);
  }
}
