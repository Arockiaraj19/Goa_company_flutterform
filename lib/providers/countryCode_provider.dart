import 'package:dating_app/models/country_code_model.dart';
import 'package:dating_app/networks/countrycode_network.dart';
import 'package:flutter/foundation.dart';

enum CodeState { Initial, Loading, Loaded, Error }

class CodeProvider extends ChangeNotifier {
  CodeState _codeState = CodeState.Initial;

  CodeState get chatState => _codeState;

  List<CountryCode> _codeData = [];

  List<CountryCode> get codeData => _codeData;

  getdata(String data) async {
    _codeState = CodeState.Loading;
    _codeData = await CountryCodeNetwork().getcountrycode(data);
    loaded();
  }

  loaded() {
    _codeState = CodeState.Loaded;
    notifyListeners();
  }
}
