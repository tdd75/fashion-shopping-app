import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DotenvService extends GetxService {
  Future<DotEnv> init() async {
    await dotenv.load(fileName: ".env");
    return dotenv;
  }
}
