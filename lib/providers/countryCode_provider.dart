import 'package:dating_app/models/country_code_model.dart';
import 'package:dating_app/networks/countrycode_network.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum CodeState { Initial, Loading, Loaded, Error }

class CodeProvider extends ChangeNotifier {
  CodeState _codeState = CodeState.Initial;

  CodeState get chatState => _codeState;

  List<CountryCode> _codeData = [];

  List<CountryCode> get codeData => _codeData;
   String _errorText;
  String get errorText => _errorText;

  getdata(String data) async {
    _codeState = CodeState.Loading;
  
    try {
        _codeData = await CountryCodeNetwork().getcountrycode(data);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  loaded() {
    _codeState = CodeState.Loaded;
    notifyListeners();
  }
    error() {
    _codeState = CodeState.Error;
    notifyListeners();
  }
}
