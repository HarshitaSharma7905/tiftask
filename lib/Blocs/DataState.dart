import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../Model/EventModel.dart';
@immutable
abstract class DataState extends Equatable{}
//loading state
class DataloadingState extends DataState{
  @override
  List<Object?> get props =>[];
}

//loaded state
class DataloadedState extends DataState{
  final List<EventData> data;
  DataloadedState(this.data);

  @override
  List<Object?> get props =>[data];
}

//error state
class DataErrorState extends DataState{
  final String data;
  DataErrorState(this.data);

  @override
  List<Object?> get props =>[data];
}