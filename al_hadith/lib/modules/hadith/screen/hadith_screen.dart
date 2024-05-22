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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.kWhite),
            onPressed: () {}),
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
                          Text(
                            ' ${firstBookItem.data['title'] ?? ''}',
                            style: TextStyle(
                                fontFamily: 'Kalpurush',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kWhite),
                          ),
                          Text(
                            ' ওহীর সূচনা অধ্যায়',
                            style: TextStyle(
                                fontFamily: 'Kalpurush',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kWhite),
                          )
                        ]
                      : [],
                ),
                IconButton(
                    icon: Icon(Icons.tune_outlined, color: AppColors.kWhite),
                    onPressed: () {}),
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
                  var hadithNarrator = relatedHadiths.isNotEmpty
                      ? relatedHadiths[0].data['narrator'] ?? ''
                      : '';

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: const Color.fromARGB(255, 236, 232, 232),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${item.data['number'] ?? ''} ',
                                      style: TextStyle(
                                          color: AppColors.kGreenColor,
                                          fontFamily: 'Kalpurush',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: '${item.data['title'] ?? ''}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Kalpurush',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: const Color.fromARGB(255, 236, 232, 232),
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '${item.data['preface'] ?? ''}',
                                  style: TextStyle(
                                      fontFamily: 'Kalpurush',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  HexagonWidget.pointy(
                                    cornerRadius: 10,
                                    width: 40,
                                    color: Color(0xFF24DF0C),
                                    elevation: 0,
                                    child: Center(
                                        child: Text(
                                      'B',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: relatedBooks.map((bookItem) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                ' ${bookItem.data['title'] ?? ''}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kalpurush',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                ' হাদিস: ${bookItem.data['id'].toString() ?? ''}',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kGreenColor,
                                                    fontFamily: 'Kalpurush',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          right: 15,
                                          left: 10,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.kGreenColor),
                                      child: Text(' ${firstHadithGrade}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Kalpurush',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold))),
                                  PopupMenuButton<String>(
                                    onSelected: (String value) {
                                      // Handle the selection action here
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return {
                                        'Option 1',
                                        'Option 2',
                                        'Option 3'
                                      }.map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.only(right: 20, left: 10),
                                child: Text(' ${firstHadithAr}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'KGFQ',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20, left: 10),
                                child: Text('${hadithNarrator} থেকে বর্ণিত:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppColors.kGreenColor,
                                        fontFamily: 'Kalpurush',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height:20),
                               Padding(
                                padding: EdgeInsets.only(right: 20, left: 10),
                                child: Text('${firstHadithBn}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black
                        ,
                                        fontFamily: 'Kalpurush',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
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
