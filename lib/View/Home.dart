import 'package:flutter/material.dart';
import 'package:task/Blocs/DataBloc.dart';
import 'package:task/Blocs/DataEvent.dart';
import 'package:task/Blocs/DataState.dart';
import 'package:task/Repository/APIService.dart';
import 'package:task/View/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/View/EventDetail.dart';
import 'package:task/View/Search.dart';
import 'package:task/main.dart';

import '../Model/EventModel.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider<DataBloc>(
         create: (context) => DataBloc(APIService()),
       ),
      ],
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white,
          title: Text('Events', style: TextStyle(color: black)),
          automaticallyImplyLeading: MediaQuery.of(context).size.width < 600, // Toggle leading icon
          actions: <Widget>[
            MediaQuery.of(context).size.width < 600
                ? IconButton(
              onPressed: () {
// Add your action here
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(),));
              },
              icon: Icon(Icons.search, color: black),
            )
                : IconButton(
              onPressed: () {
// Add your action here
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(),));
              },
              icon: Icon(Icons.search, color: black),
            ),
            IconButton(
              onPressed: () {
// Add your action here
              },
              icon: Icon(Icons.more_vert, color: black),
            )
          ],
        ),
        body: dataBlocBody(),
      ),
    );
  }
  Widget dataBlocBody(){
    return BlocProvider(create: (context) => DataBloc(APIService()
    )..add(LoadDataEvent()),
    child:BlocBuilder<DataBloc,DataState>(
        builder: (context, state) {
          if(state is DataloadingState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is DataloadedState){
            List<EventData> eventList=state.data;
            return ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>EventDetails(e: eventList[index])));
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
                                        eventList[index].bannerImage,fit: BoxFit.cover,

                                      )

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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(child: Text(eventList[index].dateTime,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,fontFamily: 'Inter',color: toptextcolor)),),
                                    Container(child: Text(eventList[index].title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Inter',color: black))),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on, color: grey),
                                          SizedBox(width: 8), // Add some spacing between the icon and text
                                          Expanded(
                                            child: Text(
                                              '${eventList[index].venueName + ', ' + eventList[index].venueCity}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Inter',
                                                color: grey,
                                              ),
                                              overflow: TextOverflow.ellipsis, // Handles overflow if text is too long
                                              maxLines: 1, // Restricts to a single line
                                            ),
                                          ),
                                        ],
                                      ),
                                    )

                                  ],
                                )),
                          ))
                        ],
                      )
                  ),
                );
              },
            );
          }
          if(state is DataErrorState)
            {
              return Center(child: Text('Error'),);
            }
          return Container();
        },) ,
    );
  }

}
