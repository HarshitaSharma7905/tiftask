import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Model/EventModel.dart';

import 'Constant.dart';

class EventDetails extends StatefulWidget {
  final EventData e;
  const EventDetails({Key? key, required this.e, }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
          child: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.pop(context);
            },color:white),
            flexibleSpace: Container(
              height: 244,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.e.bannerImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              'Event Details',
              style: TextStyle(color: white),
            ),
          ),
        ),
        body: Container(

          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(widget.e.title, style: TextStyle(fontFamily: 'Inter',fontSize: 35,
// Adjust the factor (0.1) as needed for the desired font size
                ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child:
                Row(
                  children: [
                    Image.network(widget.e.organiserIcon,
                      height: 50, // Adjust as needed
                      width: 50,  // Adjust as needed
                    ),
                    SizedBox(width: 8), // Add some spacing between the image and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          widget.e.organiserName,
                          style: TextStyle(fontFamily: 'Inter',fontSize: 16,fontWeight: FontWeight.w500), // Adjust as needed
                        ),
                        Text(
                          'Organizer',
                          style: TextStyle(fontFamily: 'Inter',fontSize: 12,fontWeight: FontWeight.w400,color: grey), // Adjust as needed
                        ),
                      ],
                    ),
                  ],
                ),),
              Container(
                child:
                Row(
                  children: [
                    Image.asset('assets/icons/Date.png',
                      height: 50, // Adjust as needed
                      width: 50,  // Adjust as needed
                    ),
                    SizedBox(width: 8), // Add some spacing between the image and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          widget.e.dateTime,
                          style: TextStyle(fontFamily: 'Inter',fontSize: 16,fontWeight: FontWeight.w500), // Adjust as needed
                        ),
                        Text(
                          widget.e.dateTime,
                          style: TextStyle(fontFamily: 'Inter',fontSize: 12,fontWeight: FontWeight.w400,color: grey), // Adjust as needed
                        ),
                      ],
                    ),
                  ],
                ),),
              Container(
                child:
                Row(
                  children: [
                    Image.asset('assets/icons/Location.png',
                      height: 50, // Adjust as needed
                      width: 50,  // Adjust as needed
                    ),
                    SizedBox(width: 8), // Add some spacing between the image and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          widget.e.venueName,
                          style: TextStyle(fontFamily: 'Inter',fontSize: 16,fontWeight: FontWeight.w500), // Adjust as needed
                        ),
                        Text(
                          '${widget.e.venueCity+','+widget.e.venueCountry}',
                          style: TextStyle(fontFamily: 'Inter',fontSize: 12,fontWeight: FontWeight.w400,color: grey), // Adjust as needed
                        ),
                      ],
                    ),
                  ],
                ),),
              Text('About Event',style: TextStyle(fontFamily: 'Inter',fontSize: 18,fontWeight: FontWeight.w400), // Adjust as needed
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                 Text('${widget.e.description+'Read More...'}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Inter'),),
                  SizedBox(height: 10),
                  Container(
                    width: 271,
                    height: 58,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(buttonColor),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
// Your onPressed callback here
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Book Now',
                              style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w400),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: circleColor,
                                shape: BoxShape.circle,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.arrow_forward, color: Colors.white),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )

                ],)

            ],
          ),

        )

    );



  }
}
