
import 'dart:async';

import 'package:task/Blocs/Bloc.dart';

import '../Model/EventModel.dart';




class SearchBloc extends Bloc{
//private streambuilder declear that will manage stream and sink for that bloc
final userController=StreamController<List<EventData>>.broadcast();
@override
  void dispose(){
  userController.close();
}
}
SearchBloc searchBloc=SearchBloc();