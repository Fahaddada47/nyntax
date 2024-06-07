import 'package:flutter/material.dart';

class DetailContainer extends StatelessWidget {
  final List<Map<String, String>> details;

  DetailContainer({required this.details});

  TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? const Color(0xFF1B1B1B),
      fontSize: fontSize ?? 14,
      fontFamily: fontFamily ?? 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Color(0xffD7D7FF)),
      ),
      child: Column(
        children: details.map((detail) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(detail['label'] ?? '', style: getTextStyle()),
                  Text(detail['value'] ?? '', style: getTextStyle()),
                ],
              ),
              SizedBox(height: 8.0),
            ],
          );
        }).toList(),
      ),
    );
  }
}
