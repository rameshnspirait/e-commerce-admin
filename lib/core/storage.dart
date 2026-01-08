import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage(
  webOptions: WebOptions(dbName: 'admin_panel', publicKey: 'admin_key'),
);
