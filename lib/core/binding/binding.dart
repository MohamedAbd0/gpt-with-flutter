import 'package:get/get.dart';
import '../controllers/gpt_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GPTController(), fenix: true);
  }
}
