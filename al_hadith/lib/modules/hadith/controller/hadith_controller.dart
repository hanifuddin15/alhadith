
// import 'package:al_hadith/core/utils/local_db/db_helper.dart';
// import 'package:get/get.dart';


// class HadithController extends GetxController {
//   var hadithList = <Map<String, dynamic>>[];
//    var bookList = <Map<String, dynamic>>[];
//     var sectionList = <Map<String, dynamic>>[];
//   var isLoading = true;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchHadiths();
//     fetchBooks();
//     fetchSections();
//   }

//   void fetchHadiths() async {
//     try {
//       isLoading = true;
//       update(); 
//       var hadiths = await DatabaseHelper.instance.getHadiths();
//       hadithList = hadiths;
//     } finally {
//       isLoading = false;
//       update();  
//     }
//   }
//    void fetchBooks() async {
//     try {
//       isLoading = true;
//       update();  
//       var books = await DatabaseHelper.instance.getBooks();
//       bookList = books;
//     } finally {
//       isLoading = false;
//       update();  
//     }
//   }

//   void fetchSections() async {
//     try {
//       isLoading = true;
//       update();  
//       var section = await DatabaseHelper.instance.getSections();
//       sectionList = section;
//     } finally {
//       isLoading = false;
//       update();  
//     }
//   }
  
  
// }
import 'package:al_hadith/core/utils/local_db/db_helper.dart';
import 'package:al_hadith/models/hadith_item_model.dart';
import 'package:get/get.dart';

class HadithController extends GetxController {
  var itemList = <ListItem>[];
  var isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  void fetchAllData() async {
    try {
      isLoading = true;
      update();

      var hadiths = await DatabaseHelper.instance.getHadiths();
      var books = await DatabaseHelper.instance.getBooks();
      var sections = await DatabaseHelper.instance.getSections();

      // Combine all data into a single list
      itemList = [
        ...hadiths.map((hadith) => ListItem(HadithItems.hadith, hadith)),
        ...books.map((books) => ListItem(HadithItems.books, books)),
        ...sections.map((section) => ListItem(HadithItems.section, section)),
      ];
    } finally {
      isLoading = false;
      update();
    }
  }
}
