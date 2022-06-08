import 'package:hive/hive.dart';

abstract class SearchedMovieLocalSource {
  void saveSearchedKeyInLocalStoreIfNotExists();
  List<String> getAllSearchedItems();
  void saveSearchedItem(String input);
}

class SearchedMovieLocalSourceImpl implements SearchedMovieLocalSource {

  late final Box box;
  String boxKey = "searched";

  SearchedMovieLocalSourceImpl(this.box);

  @override
  void saveSearchedKeyInLocalStoreIfNotExists() {
    if(!box.containsKey(boxKey)) {
      List<String> searchedlist = [];
      box.put(boxKey, searchedlist);
    }
  }

  @override
  List<String> getAllSearchedItems() {
    return box.get(boxKey);
  }

  @override
  void saveSearchedItem(String input) {
    List<String> tempList = box.get(boxKey);
    tempList.add(input);
    box.put(boxKey, tempList);
  }
  
}