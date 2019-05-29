

main(){

  var dateTime = DateTime.now();
  print(dateTime);

  var dateTime2 = DateTime(2019,5,16,12);

  print(dateTime.isBefore(dateTime2));

}
