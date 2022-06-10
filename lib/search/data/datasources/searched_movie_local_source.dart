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
    print('sdfasfsfdfasfsfsfsaddddd1!!!!');
    print(box.containsKey(boxKey));
    print(box.get(boxKey).runtimeType);
    print(box.get(boxKey));
    if(!box.containsKey(boxKey)) {
      List<String> searchedlist = [];
      box.put(boxKey, searchedlist);
    }
  }

  @override
  List<String> getAllSearchedItems() {
    print(box.get(boxKey).runtimeType);
    // in-memory system이라서 List<String>으로 저장해도 dynamic으로 가져오는 문제가 있었음
    // 따라서 defaultValue와 타입캐스팅을 추가함
    List<String> res = box.get(boxKey, defaultValue: <String>[]).cast<String>();
    return res;
  }

  @override
  void saveSearchedItem(String input) {
    List<String> tempList = box.get(boxKey, defaultValue: <String>[]).cast<String>();
    tempList.add(input);
    box.put(boxKey, tempList);
  }
  
}