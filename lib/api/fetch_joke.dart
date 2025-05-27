import 'package:dio/dio.dart';

class JokeFetcher {
  static Future<String> fetchRandomJoke() async {
    try {
      var dio = Dio();
      dio.options.headers["Accept"] = "application/json";
      var jokeResponse = await dio.get("https://icanhazdadjoke.com/slack");

      return jokeResponse.data["attachments"][0]["text"];
    } catch (e) {
      return e.toString();
    }
  }
}