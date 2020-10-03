library mydata;


List<Data> data1;

class Data {
  String room;
  String no;
  String hn;
  String physician;
  String patient;

  Data(this.no, this.hn, this.physician, this.room, this.patient);

  factory Data.fromJson(List<dynamic> json) =>
      Data(json[0], json[1], json[2], json[3], json[4]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['hn'] = this.hn;
    data['physician'] = this.physician;
    data['room'] = this.room;
    data['patient'] = this.patient;
    return data;
  }
}

// Future<void> senddownloadDataRequest() async {
//   var url =
//       'https://sheets.googleapis.com/v4/spreadsheets/1jJOi0vZYjMZa5SnxvHBt3w4Vl3qaHPsZo3fzACzLLqI/values/queue!A2:E/?key=AIzaSyBqaDDBMrB6s4JYcR3KVPnoKdGFmdYN-dw';
//   http.get(url).then(
//     (response) {
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         //print(data['values']);
//         if (data['values'] != null) {
//           data1 = new List<Data>();
//           data['values'].forEach((v) {
//             data1.add(new Data.fromJson(v));
//           });
//         }

//         print("Response status: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     },
//   );
//   return data1;
// }
