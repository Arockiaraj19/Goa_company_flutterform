import 'package:dating_app/models/games.dart';
import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

class Games {
  Future getallgames() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.get(getall_games);
        print("games");
        print(response.data["response"]);
        final results =
            List<Map<String, dynamic>>.from(response.data["response"]);

        List<GamesModel> finaldata = results
            .map((codeData) => GamesModel.fromMap(codeData))
            .toList(growable: false);

        return finaldata;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future sendgamerequest() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.post(create_game_request, data: {
          "game_id": "611674f2715272678c19c9cb",
          "match_id": "6110e19d4039d12c40a68aee",
          "confirmed_user": "610ccb5b9d38be286811f02d",
          "requested_user": "6109417a9d387a29ac196f96"
        });
        print("game request");
        print(response.data);
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future gameRequestAction(id) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.patch(gameaction + id, data: {"action": "2"});
        print("game request");
        print(response.data);
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future answerquestion(gameid, questionid, option, type) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(gameanswer, data: {
          "game_play_id": id,
          "game_id": gameid,
          "question_id": questionid,
          "option": option,
          "question_type": type
        });
        print("game answer");
        print(response.data);
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future getquestion(id) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.get(getgamesquestion + id);
        print("get questions");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<Getquestion> finaldata = results
            .map((codeData) => Getquestion.fromMap(codeData))
            .toList(growable: false);

        return finaldata;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}
