class EventContent {
  List<EventData> data;
  Meta meta;

  EventContent({required this.data, required this.meta});

  factory EventContent.fromJson(Map<String, dynamic> json) {
    List<EventData> eventDataList = (json['data'] as List)
        .map((eventData) => EventData.fromJson(eventData))
        .toList();

    return EventContent(
      data: eventDataList,
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class EventData {
  int id;
  String title;
  String description;
  String bannerImage;
  String dateTime;
  String organiserName;
  String organiserIcon;
  String venueName;
  String venueCity;
  String venueCountry;



  EventData({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['banner_image'],
      dateTime: json['date_time'],
      organiserName: json['organiser_name'],
      organiserIcon: json['organiser_icon'],
      venueName: json['venue_name'],
      venueCity: json['venue_city'],
      venueCountry: json['venue_country'],
    );
  }
}

class Meta {
  int total;

  Meta({required this.total});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
    );
  }
}
