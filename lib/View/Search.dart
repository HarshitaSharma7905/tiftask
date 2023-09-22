import 'package:flutter/material.dart';
import 'package:task/Blocs/SearchBloc.dart';
import 'package:task/View/Constant.dart';
import 'package:task/View/EventDetail.dart';
import 'package:task/main.dart';

import '../Model/EventModel.dart';
import '../Repository/APIService.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<EventData> totalEvents=[];
@override
  void initState() {
     fetchEvents();
    super.initState();
  }

  //search
void search(String searchQuery){
  List<EventData> searchResult=[];
  searchBloc.userController.sink.add([]);
  if(searchQuery.isEmpty){
    searchBloc.userController.sink.add(totalEvents);
    return;
  }
  totalEvents.forEach((user){
    if(user.title.toLowerCase().contains(searchQuery.toLowerCase())){
      searchResult.add(user);
    }
  });
  searchBloc.userController.sink.add(searchResult);
}
  //fetching data from api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),));
            },
            color: black),
        backgroundColor: white,
        title: Text('Search',style: TextStyle(color: black),),
        bottom: PreferredSize(preferredSize: Size.fromHeight(35),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => search(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.black,),
                    hintText: 'Search Title',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3.1,color: Colors.red),
                      borderRadius: BorderRadius.circular(5),

                    )

                ),
              ),
            ),
        ),
      ),
      body: Container(child:  eventWidget()),
    );
  }
  Widget eventWidget(){
  return StreamBuilder(
    stream: searchBloc.userController.stream,
    builder: (BuildContext context, AsyncSnapshot<List<EventData>> snapshot){
      if(snapshot==null){
        return Center(child: CircularProgressIndicator(),);
      }
      return snapshot.connectionState==ConnectionState.waiting ? Center(child: CircularProgressIndicator())
          :ListView(
        children: snapshot.data!.map((eventData){
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(e: eventData),));
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1, // 80% of screen width
                height: MediaQuery.of(context).size.height * 0.2, // 20% of screen height
                margin: EdgeInsets.all(24),

                child: Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.0, // Maintain a 1:1 aspect ratio
                        child: FractionallySizedBox(
                          widthFactor: 0.8, // Set the width factor to 80% of available space
                          heightFactor: 0.8, // Set the height factor to 80% of available space
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                eventData.bannerImage,
                                fit: BoxFit.cover, // Ensure the image covers the entire container
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: AspectRatio(aspectRatio: 1.0,
                      child: FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(child: Text( eventData.dateTime,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'Inter',color: toptextcolor)),),
                              Container(child: Text(eventData.title,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,fontFamily: 'Inter',color: black))),
                            ],
                          )),
                    ))
                  ],
                )

            ),
          );

      }).toList());

    },
  );

  }
  Future<void> fetchEvents() async{

  try{
    List<EventData> eventData=await APIService().getData();
    totalEvents=eventData;
    print(eventData);
  }catch(e){
    // Handle error
    print('Error fetching data: $e');
  }

    searchBloc.userController.sink.add(totalEvents);
  }
}
