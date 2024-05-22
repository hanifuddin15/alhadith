import 'package:al_hadith/core/utils/app_colors/app_colors.dart';
import 'package:al_hadith/models/hadith_item_model.dart';
import 'package:al_hadith/modules/hadith/controller/hadith_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexagon/hexagon.dart';

class HadithPage extends StatelessWidget {
  final HadithController hadithController = Get.put(HadithController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kGreenColor,
        shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.kWhite),
          onPressed: (){}
        ),
        title: GetBuilder<HadithController>(
          builder: (controller) {
            var firstBookItem = controller.itemList.firstWhere(
              (item) => item.type == HadithItems.books,
            );

            if (firstBookItem != null) {
              print(
                  'First Book Title: ${firstBookItem.data['title'] ?? 'No title'}');
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: firstBookItem != null
                      ? [
                          Text(' ${firstBookItem.data['title'] ?? ''}'),
                          Text('ওহীর সূচনা অধ্যায়')
                        ]
                      : [],
                ),
                IconButton(
                  icon: Icon(Icons.tune_outlined, color: AppColors.kWhite),
                  onPressed: () {}
                ),
              ],
            );
          },
        ),
      ),
      body: GetBuilder<HadithController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.itemList.isEmpty) {
            return Center(child: Text('No items found'));
          }

          return ListView.builder(
            itemCount: controller.itemList.length,
            itemBuilder: (context, index) {
              var item = controller.itemList[index];
              print(item.data);

              switch (item.type) {
                case HadithItems.section:
                  var relatedBooks = controller.itemList
                      .where((element) => element.type == HadithItems.books)
                      .toList();
                  var relatedHadiths = controller.itemList
                      .where((element) => element.type == HadithItems.hadith)
                      .toList();
                  var firstHadithGrade = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['grade'] ?? ''
                      : '';
                  var firstHadithAr = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['ar'] ?? ''
                      : '';
                  var firstHadithBn = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['bn'] ?? ''
                      : '';

                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${item.data['number'] ?? ''} ',
                                style: TextStyle(color: Colors.green),
                              ),
                              TextSpan(
                                text: '${item.data['title'] ?? ''}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.red),
                        Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(10),
                          child: Text('${item.data['preface'] ?? ''}'),
                        ),
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              HexagonWidget.pointy(
                                cornerRadius: 10,
                                width: 40,
                                color: Colors.green,
                                elevation: 8,
                                child: Center(child: Text('B')),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: relatedBooks.map((bookItem) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            ' ${bookItem.data['title'] ?? ''}'),
                                        Text(
                                            'হাদিস: ${bookItem.data['id'].toString() ?? ''}'),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green),
                                  child: Text(' ${firstHadithGrade}')),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  // Handle the selection action here
                                },
                                itemBuilder: (BuildContext context) {
                                  return {'Option 1', 'Option 2', 'Option 3'}
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                                icon: Icon(Icons.more_vert),
                              ),
                            ],
                          ),
                        ),
                        if (firstHadithAr.isNotEmpty) Text(' ${firstHadithAr}'),
                        if (firstHadithBn.isNotEmpty) Text(' ${firstHadithBn}'),
                      ],
                    ),
                  );
                default:
                  return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
