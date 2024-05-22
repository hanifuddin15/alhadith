enum HadithItems { hadith, books, section }

class ListItem {
  final HadithItems type;
  final Map<String, dynamic> data;

  ListItem(this.type, this.data);
}
