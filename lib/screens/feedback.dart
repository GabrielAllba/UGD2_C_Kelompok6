import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/client/FeedbackClient.dart';
import 'package:ugd2_c_kelompok6/entity/Feedback.dart' as FeedbackModel;

class FeedbackPage extends StatefulWidget {
  final int id;

  FeedbackPage({required this.id});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<FeedbackModel.Feedback> feedbackList = [];

  TextEditingController feedbackController = TextEditingController();

  Future<void> fetchFeedback() async {
    try {
      List<FeedbackModel.Feedback> reviewsData =
          await FeedbackClient.fetchAll();

      setState(() {
        feedbackList = reviewsData;
      });
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  Future<void> createFeedback(FeedbackModel.Feedback feedback) async {
    try {
      await FeedbackClient.create(feedback);
      print('feedback created successfully');
      fetchFeedback();
    } catch (err) {
      print('Error creating review: $err');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Berikan komentar atau masukkan untuk kami : ',
              style: TextStyle(fontSize: 17),
            ),
            // create a list that can be scrolled here
            SizedBox(height: 16),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: feedbackList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(feedbackList[index].feedback),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                feedbackController, // Assign controller to TextFormField
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your feedback here...',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: ElevatedButton(
                              onPressed: () async {
                                FeedbackModel.Feedback feedback =
                                    FeedbackModel.Feedback(
                                        id_user: widget.id,
                                        feedback: feedbackController.text);
                                await createFeedback(feedback);
                                feedbackController.clear();
                              },
                              child: Text('Submit'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
