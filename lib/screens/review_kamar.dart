import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/client/ReviewClient.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';

import 'package:ugd2_c_kelompok6/entity/Review.dart' as ReviewModel;

class ReviewKamar extends StatefulWidget {
  ReviewKamar({super.key, required this.nama_kamar});

  String nama_kamar;

  @override
  _ReviewKamarState createState() => _ReviewKamarState();
}

class _ReviewKamarState extends State<ReviewKamar> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<ReviewModel.Review> filedata = [];
  int? idUser;

  Future<void> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getInt('id')!;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReviews();
    getIdUser();
  }

  Future<void> createReview(ReviewModel.Review review) async {
    try {
      await ReviewClient.create(review);
      print('Review created successfully');
      fetchReviews();
    } catch (err) {
      print('Error creating review: $err');
    }
  }

  Future<void> fetchReviews() async {
    try {
      List<ReviewModel.Review> reviewsData =
          await ReviewClient.findByNamaKamar(widget.nama_kamar);

      setState(() {
        filedata = reviewsData;
      });
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  Widget commentChild(List<ReviewModel.Review> data) {
    return ListView(
      children: [
        for (var review in data)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      // Display the image in large form.
                      print("Comment Clicked");
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.all(Radius.circular(50)),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        // backgroundImage: CommentBox.commentImageParser(
                        //     imageURLorPath: review.pic),
                      ),
                    ),
                  ),
                  title: Text(
                    review
                        .review, // Replace with the actual property name in Review
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(review
                      .nama_kamar), // Replace with the actual property name in Review
                  trailing: review.id_user == idUser
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Handle edit action
                                print("Edit Clicked");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete action
                                print("Delete Clicked");
                              },
                            ),
                          ],
                        )
                      : null,
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: CommentBox(
          // userImage: CommentBox.commentImageParser(
          //     imageURLorPath: "assets/img/userpic.jpg"),
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                ReviewModel.Review review = ReviewModel.Review(
                  id_user: idUser, // Replace with the actual user ID
                  review: commentController.text,
                  tanggal: DateTime.now().toString(),
                  nama_kamar: widget.nama_kamar,
                );
                print('helsadfhasdf'); // Call the createReview method
                createReview(review);
                print('adsfasdfasdfasdfasdfs'); // Call the createReview method
                filedata.insert(0, review);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
