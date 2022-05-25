abstract class BackendService {
  String getUserId();
  Stream streamData(String path);
  Future<void> createData(String path, dynamic data);
}
