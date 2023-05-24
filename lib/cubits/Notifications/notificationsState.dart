import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsnap/models/notificationsModel.dart';



abstract class NotificationState extends Equatable {}

class NotificationInitialState extends NotificationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationLoadingState extends NotificationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class NotificationLoadedState extends NotificationState {
  final List<NotificationsModel> data;

  NotificationLoadedState({required this.data});
  @override
  // TODO: implement props
  List<Object> get props => [data];
}
class NoNotificationState extends NotificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationError extends NotificationState {
  String message;

  NotificationError(this.message);

  @override
  List<Object> get props => [message];
}

