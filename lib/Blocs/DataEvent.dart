import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DataEvent extends Equatable{
 const DataEvent();
}
class LoadDataEvent extends DataEvent{
  @override
  List<Object?> get props => [];

}