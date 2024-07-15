import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/routes.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

late final TextEditingController headerText;
late final TextEditingController bodyText;

class _CreatePostState extends State<CreatePost> {
  @override
  void initState() {
    // TODO: implement initState

    headerText = TextEditingController();
    bodyText = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    headerText.dispose();
    bodyText.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new post'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: headerText,
              decoration: InputDecoration(
                  hintText: 'Please enter a header text',
                  suffixIcon: IconButton(
                    onPressed: headerText.clear,
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: bodyText,
              decoration: InputDecoration(
                  hintText: 'Please enter the body text',
                  suffixIcon: IconButton(
                    onPressed: headerText.clear,
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                saveCloud();
                Navigator.pushNamedAndRemoveUntil(
                    context, postsRoute, (route) => false);
              },
              child: Text('Save this post!'))
        ],
      )),
    );
  }
}

void saveCloud() {
  FirebaseFirestore.instance.collection('All Posts').add({
    "headerText": headerText.text,
    "bodyText": bodyText.text,
  });
}
