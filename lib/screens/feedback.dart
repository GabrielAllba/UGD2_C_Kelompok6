import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  final String id;

  FeedbackPage({required this.id});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<String> feedbackList = []; // Daftar komentar
  TextEditingController feedbackController =
      TextEditingController(); // Controller untuk TextFormField

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
              'Berikan komentar atau masukkan untuk kami :',
              style: TextStyle(fontSize: 17),
            ),
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
                            title: Text(feedbackList[index]),
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
                            padding: const EdgeInsets.only(
                                top: 60), // Sesuaikan jarak di atas tombol
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  feedbackList.add(feedbackController.text);
                                });

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

void main() {
  runApp(MaterialApp(
    home: FeedbackPage(id: ""),
  ));
}
