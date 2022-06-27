import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/services/services.dart';

// state //
@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotifSent extends NotificationState {
  @override
  List<Object> get props => [];
}

// event //
@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class SendNotificationToOutlet extends NotificationEvent {
  final String? contents;
  final String? headings;
  final String? outlet;

  SendNotificationToOutlet({this.contents, this.headings, this.outlet});

  @override
  List<Object?> get props => [contents, headings, outlet];
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<SendNotificationToOutlet>((event, emit) async {
      String? tokenOutlet =
          await NotificationServices.getOutletToken(event.outlet);

      await NotificationServices.sendNotification(
        tokenId: tokenOutlet,
        contents: event.contents,
        heading: event.headings,
      );

      emit(NotifSent());
    });
  }
}
