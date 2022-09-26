import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_app/data/server.dart';


class EditPostScreen extends StatefulWidget {
  String postId;
  String username;
  String postTitle;
  String postText;

  EditPostScreen({Key? key,
    required this.postId,
    required this.username,
    required this.postTitle,
    required this.postText,
  }) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState(
    postId,
    username,
    postTitle,
    postText,
  );
}

class _EditPostScreenState extends State<EditPostScreen> {
  String postId;
  String username;
  String postTitle;
  String postText;

  _EditPostScreenState(
      this.postId,
      this.username,
      this.postTitle,
      this.postText,
      );

  final TextEditingController _postTitleTD = TextEditingController();
  final TextEditingController _postTextTD = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _postTitleTD.text = postTitle;
      _postTextTD.text = postText;
    });
  }

  _updatePost() {
    Services.updatePost(postId, username, _postTitleTD.text, _postTextTD.text)
        .then((result) {
      if (kDebugMode) {
        print(postId);
      }
      if ('success' == result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Row(
              children: const [
                Icon(Icons.thumb_up, color: Colors.white),
                Text(
                  'تم تعديل المنشور',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل منشور'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'تعديل منشور',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _postTitleTD,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'العنوان',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _postTextTD,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'النص',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _updatePost(),
                    child: const Text(
                      'تعديل',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}