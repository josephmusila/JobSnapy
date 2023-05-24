import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/cubits/Notifications/notificationCubit.dart';
import 'package:jobsnap/cubits/Notifications/notificationsState.dart';

import '../models/notificationsModel.dart';
import '../widgets/adsSlider.dart';


class AdSliderLogic extends StatefulWidget {
  const AdSliderLogic({Key? key}) : super(key: key);

  @override
  State<AdSliderLogic> createState() => _AdSliderLogicState();
}

class _AdSliderLogicState extends State<AdSliderLogic> {

  @override
  void initState() {
    BlocProvider.of<NotificationsCubit>(context).getNotification();
    super.initState();
  }



  List <NotificationsModel>items= [
    NotificationsModel(id: 1, notification: "Kenya's Number JobSearch Onestop.",),
    NotificationsModel(id: 2, notification: "You can Post\nAll Types of\nJobs",),
    NotificationsModel(id: 3, notification: "All For Free!!\n\n No Brokers No Agents",),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit,NotificationState>(
        builder: (context,state){
          if(state is NotificationLoadedState){
            return CustomImageSlider(notifications: state.data,);
          }else{
            return CustomImageSlider(notifications: items,);
          }
        }
    );
  }
}
