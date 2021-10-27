import 'package:flutter/foundation.dart';

enum CodeState { Initial, Loading, Loaded, Error }

class CodeProvider extends ChangeNotifier {
  CodeState _codeState = CodeState.Initial;

    CodeState get chatState => _codeState;

    getdata()async{

    }
}
