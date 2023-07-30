import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MySliderComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // Return the preferred size of the label
    return const Size.fromRadius(10);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    final Rect rect = Rect.fromCenter(
      center: Offset(
        center.dx - (labelPainter.height / 9),
        center.dy - (-labelPainter.width * 0.7),
      ),
      width: labelPainter.width + 60,
      height: 40,
    );
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(30),
    );
    final Paint paint = Paint()
      ..color = const Color(0xff59287b).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);
    labelPainter.paint(
      canvas,
      Offset(
        center.dx - (labelPainter.width / 1.8),
        center.dy - (-labelPainter.width * 0.55),
      ),
    );
  }
}

class CustomCalender {
  static buildCustomCalender({required DateRangePickerController controller}) {
    return SfDateRangePicker(
      controller: controller,
      selectionMode: DateRangePickerSelectionMode.multiple,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderHeight: 50,
        showTrailingAndLeadingDates: true,
      ),
      headerHeight: 0,
      cellBuilder: (context, cellDetails) {
        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          alignment: Alignment.center,
          child: Text(
            cellDetails.date.day.toString(),
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}

// monthCellStyle: DateRangePickerMonthCellStyle(
// todayTextStyle: TextStyle(
// fontStyle: FontStyle.normal,
// fontSize: 15,
// fontWeight: FontWeight.w500,
// color: AppConstantsColor.blackColor,
// ),
// todayCellDecoration: BoxDecoration(
// color: Color(0xff59287b),
// shape: BoxShape.circle,
// ),
// ),
// minDate: DateTime.now().subtract(
// Duration(days: 7),
// ),
// maxDate: DateTime.now().add(
// Duration(days: 7),
// ),
// onSelectionChanged: (value) {},
// selectionMode: DateRangePickerSelectionMode.multiple,
// monthViewSettings: DateRangePickerMonthViewSettings(
// viewHeaderHeight: 50,
// viewHeaderStyle: DateRangePickerViewHeaderStyle(
// textStyle: TextStyle(
// fontWeight: FontWeight.w500,
// fontStyle: FontStyle.normal,
// fontFamily: "",
// fontSize: 16,
// color:
// AppConstantsColor.titleColor.withOpacity(0.3),
// ),
// ),
// ),
// showActionButtons: false,
// showNavigationArrow: false,
// allowViewNavigation: false,
// view: DateRangePickerView.month,
// headerHeight: 0.0,
