import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlTextViewer extends StatelessWidget {
  const HtmlTextViewer({
    super.key,
    this.text,
    required this.fontSize,
    required this.maxLine,
    required this.boldColor,
    required this.normalColor,
  });

  final String? text;
  final double fontSize;
  final Color boldColor;
  final Color normalColor;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text,
      style: {
        'body': Style(
            margin: Margins.all(0),
            fontSize: FontSize(fontSize),
            maxLines: maxLine,
            color: normalColor,
            textOverflow: TextOverflow.ellipsis),
        'strong': Style(
            margin: Margins.all(0),
            fontSize: FontSize(fontSize),
            color: boldColor,
            fontWeight: FontWeight.normal),
      },
    );
  }
}
