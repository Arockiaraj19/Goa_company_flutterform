import 'package:dating_app/models/game_request_model.dart';
import 'package:dating_app/models/games.dart';
import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/models/user2_game_request_model.dart';
import 'package:dating_app/models/user2_question_model.dart';
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

  Future sendgamerequest(gameid, user2) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(create_game_request, data: {
          "game_id": gameid,
          "confirmed_user": user2,
          "requested_user": id,
        });
        print("game request");
        print(response.data["response"]);
        GameRequest reuslt = GameRequest.fromMap(response.data["response"]);
        return reuslt;
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

  Future<bool> answerquestion(String gameid, String questionid, String option,
      String type, String playid) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(gameanswer, data: {
          "game_play_id": playid,
          "game_id": gameid,
          "question_id": questionid,
          "option": option,
          "question_type": type,
          "user": id,
        });
        print("game answer");
        print(response.data);
        return true;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future getquestion(id, playid) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.get("/user/gamequestions/$id/play/$playid");
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

  Future checkrequest(String user) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get("/user/requestedgame", queryParameters: {
          "user_id_1": id,
          "user_id_2": user,
        });
        print("check game request");
        print(response.data);
        CheckRequestModel result = CheckRequestModel.fromMap(response.data);
        List<Getquestion> finaldata =
            await sendrequest(result.gameId, result.questions);
        User2Question combinedata = User2Question.fromMap(result.id, finaldata);
        return combinedata;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future sendrequest(String gameid, List<String> question) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.post("/user/reqgamequestions",
            data: {"game_id": gameid, "questions": question});
        print("game send requestion");
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

  Future getscrore(id) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.get("/user/gamescore/$id");
        print("get score");
        print(response.data);
        int score = response.data["score"];
        return score;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> leavegame(id) async {
    Response response;
    try {
      final _dio = apiClient();
      String userid = await getUserId();
      var data = _dio.then((value) async {
        response = await value.patch("/user/leavegame",
            data: {"game_play_id": id, "user": userid});
        print("user leaving");
        print(response.data);

        return true;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}
