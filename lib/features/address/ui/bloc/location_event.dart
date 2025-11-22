part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLocationEvent extends LocationEvent {}

class ListenToLocationServiceStatusEvent extends LocationEvent {}

class LocationServiceStatusChangedEvent extends LocationEvent {
  final bool isEnabled;
  const LocationServiceStatusChangedEvent({required this.isEnabled});

  @override
  List<Object> get props => [isEnabled];
}
