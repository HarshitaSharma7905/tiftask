import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Blocs/DataEvent.dart';
import 'package:task/Blocs/DataState.dart';
import 'package:task/Model/EventModel.dart';
import 'package:task/Repository/APIService.dart';

class DataBloc extends Bloc<DataEvent,DataState>{
  final APIService _apiService;
  DataBloc(this._apiService):super(DataloadingState()){
    on<LoadDataEvent>((events,emit) async{
      emit(DataloadingState());
      try{
        final List<EventData> data=await _apiService.getData();
        emit(DataloadedState(data));
      }catch(error){
        emit(DataErrorState(error.toString()));

      }



    });
  }

}