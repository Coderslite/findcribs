import 'package:get/get.dart';

import '../../models/notification_model.dart';
import '../../service/notification_all_service.dart';

class GetAllNotificationController extends GetxController {
  var allNotificationList = [].obs;
  var myNotificationList = [].obs;
  late Future<List<NotificationModel>> notificationList;

  handleGetNotification() {
    notificationList = getAllNotification();
    notificationList.then((value) {
      myNotificationList.value = value;
      allNotificationList.value = myNotificationList
          .where((element) => element.isRead == false)
          .toList();
    });
  }

  

  @override
  void onInit() {
    handleGetNotification();
    super.onInit();
  }

  @override
  void onClose() {
    handleGetNotification();
    super.onClose();
  }
}
