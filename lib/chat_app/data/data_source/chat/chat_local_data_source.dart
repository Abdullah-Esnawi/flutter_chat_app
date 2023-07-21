import 'package:flutter/cupertino.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';

abstract class BaseChatLocalDataSource{
  Future<GiphyGif?> pickGif(BuildContext context);
}

class ChatLocalDataSource extends BaseChatLocalDataSource{
  @override
  Future<GiphyGif?> pickGif(BuildContext context) {
    // TODO: implement pickGif
    throw UnimplementedError();
  }



}