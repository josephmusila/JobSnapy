


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/cubits/Notifications/notificationsState.dart';
import 'package:jobsnap/models/notificationsModel.dart';

import '../../services/notificationService.dart';




class NotificationsCubit extends Cubit<NotificationState>{
  NotificationService notificationService;

  NotificationsCubit({required this.notificationService}):super(NotificationInitialState());

  List<NotificationsModel> notifications=[];


  void getNotification() async{
    emit(NotificationLoadingState());
    try {
      notifications = await notificationService.getNotifications();
      if (notifications.isEmpty){
        emit(NoNotificationState());
      }else{
        emit(NotificationLoadedState(data: notifications));
      }
    } on Exception catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}