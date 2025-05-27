import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jokes_app_flutter/api/fetch_joke.dart';
import 'package:share_plus/share_plus.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String _joke = "Click on Get Joke";
  bool _isLoading = false;

  void onGetJokeBtnPressed() {
    setState(() { _isLoading = true; });

    JokeFetcher.fetchRandomJoke().then((joke) {
      setState(() {
        _isLoading = false;
        _joke = joke;
      });
    });
  }

  void onCopyPressed() {
    Clipboard.setData(ClipboardData(text: _joke));
    Fluttertoast.showToast(
      msg: "Joke copied to Clipboard",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1
    );
  }

  void onSharePressed() {
    SharePlus.instance.share(
      ShareParams(text: _joke)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Random Jokes",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.blue.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(_joke),
                    ),
                  ),
                ),
              ]
            ),
            Expanded(
              child: Center(
                child: Visibility(
                  visible: _isLoading,
                  child: CircularProgressIndicator()
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: onGetJokeBtnPressed,
                      child: Text("Get Joke")
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      onPressed: onCopyPressed,
                      icon: Icon(
                          Icons.copy,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      onPressed: onSharePressed,
                      icon: Icon(
                          Icons.share,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
