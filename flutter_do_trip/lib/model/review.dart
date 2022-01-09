import 'package:firebase_database/firebase_database.dart';

class Review {
  String id;
  String review;
  String createTiem;

  Review(this.id, this.review, this.createTiem);

  Review.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value['id'],
        review = snapshot.value['review'],
        createTiem = snapshot.value['createTiem'];

  toJson() {
    return {
      'id': id,
      'review': review,
      'createTiem': createTiem,
    };
  }
}
