import 'package:hive/hive.dart';

abstract class SearchedMovieLocalSource {
  List<String> getAllSearchedItems();
  void saveSearchedItem(String input);
}

class SearchedMovieLocalSourceImpl implements SearchedMovieLocalSource {

  late final Box box;
  String boxKey = "searched";

  SearchedMovieLocalSourceImpl(this.box);

  @override
  List<String> getAllSearchedItems() {
    print('box getㅎㅏ는 중 : ${box.get(boxKey).runtimeType}');
    if(!box.containsKey(boxKey)) {
      List<String> searchedlist = [];
      box.put(boxKey, searchedlist);
    }
    // in-memory system이라서 List<String>으로 저장해도 dynamic으로 가져오는 문제가 있었음
    // 따라서 defaultValue와 타입캐스팅을 추가함
    // containsKey확인해서 키가 없을 때 nullable한 List<String>을 넣으면,
    // box get할 때 defaultValue가 String으로 지정되어있어도 null로 가져오기 때문에 널러블로는 저장할 수 없을 것 같음
    // 왜..그런지는... 찾아보기
    List<String> res = box.get(boxKey, defaultValue: <String>[]).cast<String>();
    return res;
  }

  @override
  void saveSearchedItem(String input) {
    if(!box.containsKey(boxKey)) {
      List<String> searchedlist = [];
      box.put(boxKey, searchedlist);
    }
    List<String> tempList = box.get(boxKey, defaultValue: <String>[]).cast<String>();
    tempList.add(input);
    box.put(boxKey, tempList);
  }
  
}