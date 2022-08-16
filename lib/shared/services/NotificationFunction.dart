import 'package:billing/shared/services/storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationFunction {
  static void init()async
  {
    /*
    FirebaseMessaging.instance.getToken().then((value)
        {
           SaveFCM(value!);
        }

    );

     */
  }
static  Future<bool>SaveFCM(String token)async
  {
    if(token!=null)
      await  StorageService.SaveFCM(token);
    return true;
  }

}
