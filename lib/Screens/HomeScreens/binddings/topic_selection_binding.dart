import 'package:get/get.dart';

import '../controller/topic_selection_controller.dart';

class TopicSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopicSelectionController());
  }
}
