class Event{
  String name;
  String url;
  String image_url;
  DateTime dateFrom;
  DateTime lastDate;
  String prize1;
  String prize2;
  String prize3;
  String summary;
  Event(result)
  {
    name=result['name'];
    url=result['url'];
    image_url=result['image_url'];
    dateFrom=result['dateFrom'].toDate();
    lastDate=result['lastDate'].toDate();
    prize1=result['prize1'];
    prize2=result['prize2'];
    prize3=result['prize3'];
    summary=result['summary'];
  }

}