import 'package:chinesequizapp/Screens/ProfileScreens/controller/profile_screen_controller.dart';
import 'package:chinesequizapp/Screens/QuestionScreen/component/consult_component.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/component/reserve_component.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/controller/reserve_controller.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/model/reserve_model.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReserveScreen extends GetView<ReserveController> {
  ReserveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileScreenController>();

    return Obx(
      () {
        debugPrint('리빌드!!');

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                    SizedBox(width: 4.0),
                    //Text(controller.noReserveDate.toString())
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (profileController.account.value.name == '김기남')
                  ManageReserve(
                    selectedDate: controller.selectedDate.value,
                    controller: controller,
                  ),
                SizedBox(height: 15),
                CalendarMove(
                    currentDate: controller.currentDate.value,
                    controller: controller.datePickerController.value),
                SizedBox(height: 15),
                Flexible(
                  child: SfDateRangePicker(
                    onViewChanged: (dateRangePickerViewChangedArgs) async {
                      await Future.delayed(Duration(milliseconds: 100));
                      debugPrint('${controller.datePickerController.value.displayDate}');
                      controller.currentDate.value =
                          dateRangePickerViewChangedArgs.visibleDateRange.endDate ?? DateTime.now();
                      debugPrint('${controller.datePickerController.value.displayDate}');
                    },
                    controller: controller.datePickerController.value,
                    selectionColor: Colors.transparent,
                    cellBuilder: (context, cellDetails) {
                      debugPrint('cellBuilder 리빌드');
                      DateTime nowDt = DateTime.now();
                      bool isAfter = cellDetails.date.isAfter(nowDt.subtract(Duration(days: 1)));
                      bool isSelected = cellDetails.date == controller.selectedDate.value;
                      /* 반드시 공부해야 할 내용 */
                      // final aa = controller.noReserveDate.value --> 이렇게 하면 value를 굳이 써도 되지 않는다고 나온다
                      // 왜냐하면 List는 기본적으로 반응형(call by Reference) 그래서 저렇게 쓰면 굳이 쓸 필요가 없다는 것이다. 어차피 가리키는 값은 같으니까.
                      // final aa = controller.noReserveDate --> 이렇게 써도 충분하다.
                      // 다만 값을 리빌드하기 위한 경우에는 다르다
                      // controller.noReserveDate = List.from([]) 이렇게 하면 오류가 난다.
                      // 애초에 데이터 타입 자체도 다르기 때문이다.( RxList --> List --> Iterable 인데 RxList에 List를 넣을 수 없다)
                      //debugPrint('cellDetails.date ${cellDetails.date}');
                      bool isNoReserve =
                          DatabaseConstants.noReserveDates.contains(cellDetails.date.toString());
                      debugPrint(
                          'isNoReserve : $isNoReserve DatabaseConstants.noReserveDates ${DatabaseConstants.noReserveDates} ${cellDetails.date.toString()}');

                      bool isToday = (cellDetails.date.year == nowDt.year) &&
                          (cellDetails.date.month == nowDt.month) &&
                          (cellDetails.date.day == nowDt.day);

                      if (isToday) {
                        return DateBgStyle(
                            date: cellDetails.date,
                            bgColor: AppConstantsColor.normalTextColor.withOpacity(0.5));
                      }
                      if (isSelected) {
                        return DateBgStyle(
                            date: cellDetails.date, bgColor: AppConstantsColor.basicColor.withOpacity(0.9));
                      }
                      if (isNoReserve) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cellDetails.date.day.toString(),
                                style: TextStyle(
                                  color: AppConstantsColor.normalTextColor.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Positioned(
                                top: 6,
                                child: Container(
                                  width: 15,
                                  height: 1,
                                  color: AppConstantsColor.normalTextColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (isAfter) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: Text(
                            cellDetails.date.day.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        child: Text(
                          cellDetails.date.day.toString(),
                          style: TextStyle(
                            color: AppConstantsColor.normalTextColor.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    onSelectionChanged: (value) {
                      controller.selectedDate.value = value.value;
                      debugPrint('onSelectionChanged ${value.value}');
                    },
                    selectionMode: DateRangePickerSelectionMode.single,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderHeight: 50,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: "",
                          fontSize: 16,
                          color: AppConstantsColor.titleColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                    showActionButtons: false,
                    showNavigationArrow: false,
                    allowViewNavigation: false,
                    view: DateRangePickerView.month,
                    headerHeight: 0.0,
                  ),
                ),
                Image.asset('assets/images/boarder_line.png'),
                if (controller.selectedDate.value.weekday != DateTime.saturday &&
                    controller.selectedDate.value.weekday != DateTime.sunday)
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('reserve').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.waiting) {
                          final noReserveDocs = snapshot.data!.docs
                              .where((element) => element.id == DateTime(1990, 01, 01).toString())
                              .toList();
                          if (noReserveDocs.isEmpty) {
                            return SizedBox.shrink();
                          }
                          final noReserveDate = noReserveDocs[0]['noReserveDate'] as List<dynamic>;
                          if (noReserveDate.contains(controller.selectedDate.value.toString())) {
                            return SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              for (int i = 9; i < 18; i++) ...[
                                if (i != 12) ...[
                                  _buildReserveCards(
                                    i,
                                    snapshot.data!.docs
                                        .where((data) =>
                                            data.data()['date'].toDate() ==
                                            controller.selectedDate.value.add(Duration(hours: i)))
                                        .toList(),
                                    0,
                                  ),
                                  _buildReserveCards(
                                    i,
                                    snapshot.data!.docs
                                        .where((data) =>
                                            data.data()['date'].toDate() ==
                                            controller.selectedDate.value
                                                .add(Duration(hours: i, minutes: 30)))
                                        .toList(),
                                    30,
                                  ),
                                ]
                              ]
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      })
              ],
            ),
          ),
        );
      },
    );
  }

  _buildReserveCards(int hour, List<QueryDocumentSnapshot<Map<String, dynamic>>> listDocs, int minute) {
    ReserveModel reserveModel;
    if (listDocs.isNotEmpty) {
      reserveModel = ReserveModel.fromJson(listDocs[0].data());
    } else {
      reserveModel = ReserveModel(
        date: Timestamp.now(),
        userEmail: 'initialEmail',
        status: '예약가능',
        noReserveDate: [],
        phoneNumber: '0',
      );
    }
    return ReserveCard(
      date: controller.selectedDate.value.add(Duration(hours: hour, minutes: minute)),
      reserveModel: reserveModel,
    );
  }
}
