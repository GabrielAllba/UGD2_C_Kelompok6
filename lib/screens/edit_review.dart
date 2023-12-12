import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/client/ReviewClient.dart';
import 'package:ugd2_c_kelompok6/entity/Review.dart' as ReviewModel;
import 'package:ugd2_c_kelompok6/screens/review_kamar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditReview extends StatefulWidget {
  const EditReview({
    Key? key,
    required this.id,
    required this.id_user,
    required this.nama_kamar,
    required this.review,
    required this.tanggal,
  }) : super(key: key);

  final int id;
  final int id_user;
  final String nama_kamar;
  final String review;
  final String tanggal;

  @override
  State<EditReview> createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _reviewController;
  String reviewValue = '';

  @override
  void initState() {
    super.initState();
    _reviewController = TextEditingController(text: widget.review);
    findReview();
  }

  Future<void> updateReview() async {
    try {
      ReviewModel.Review rev = await ReviewClient.find(widget.id);
      rev.review = _reviewController.text;
      await ReviewClient.update(rev);
      print('Review updated successfully');
    } catch (err) {
      print('Error updating review: $err');
    }
  }

  Future<void> findReview() async {
    try {
      ReviewModel.Review rev = await ReviewClient.find(widget.id);
      setState(() {
        reviewValue = rev.review;
        _reviewController.text = rev.review;
      });
    } catch (err) {
      print('Error finding review: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Review"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _reviewController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await updateReview();
                    Fluttertoast.showToast(
                        msg: "Berhasil Update",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    String refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewKamar(
                          nama_kamar: widget.nama_kamar,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
