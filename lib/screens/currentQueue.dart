List<CurrentQueue> currentQueue;

class CurrentQueue {
  int room1;
  int room2;
  int room3;
  int room4;
  int room5;

  CurrentQueue({this.room1, this.room2, this.room3, this.room4, this.room5});

  CurrentQueue.fromJson(Map<String, dynamic> json) {
    room1 = json['room1'];
    room2 = json['room2'];
    room3 = json['room3'];
    room4 = json['room4'];
    room5 = json['room5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room5'] = this.room5;
    data['room3'] = this.room3;
    data['room4'] = this.room4;
    data['room1'] = this.room1;
    data['room2'] = this.room2;
    return data;
  }
}