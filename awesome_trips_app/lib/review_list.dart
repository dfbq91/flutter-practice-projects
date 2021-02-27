import 'package:flutter/material.dart';
import 'review.dart';

class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Review("assets/img/people.jpg", "Varuna Yasas", "1 review · 5 photos",
              "There is an amazing place"),
          Review("assets/img/diego.jpg", "Anahí Salgado", "2 review · 5 photos",
              "There is an amazing place"),
          Review("assets/img/girl.jpg", "Gissele Thomas", "2 review · 2 photos",
              "There is an amazing place"),
        ]);
  }
}
