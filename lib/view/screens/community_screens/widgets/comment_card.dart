import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

class CommentCard extends StatelessWidget {
  final CommentModel commentModel;

  const CommentCard({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: LayoutManager.widthNHeight0(context, 0) * 0.01,
          ),
          CommentInfo(
              text: commentModel.commentTxt,
              writer: commentModel.writerName,
              date: commentModel.date,
              writtenByExpert: commentModel.writtenByExpert),
          SizedBox(
            height: LayoutManager.widthNHeight0(context, 0) * 0.02,
          ),
        ],
      ),
    );
  }
}

class CommentInfo extends StatelessWidget {
  final String? text;
  final String? writer;
  final DateTime? date;
  final int? writtenByExpert;

  const CommentInfo({
    Key? key,
    required this.text,
    required this.writer,
    required this.date,
    required this.writtenByExpert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleTextWidget(text: writer ?? ''),
                SizedBox(
                    width: LayoutManager.widthNHeight0(context, 1) * 0.015),
                DefaultTextStyle(
                  style: TextStyle(),
                  child: Text(
                    writer ?? '',
                    style: TextStyle(
                      fontFamily: ThemeManager.fontFamily,
                      color: ThemeManager.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),

            DefaultTextStyle(
              style: TextStyle(),
              child: Text(
                _getDisplayTime(date),
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.textColor,
                  fontSize: 12,
                ),
              ),
            ),
            // Expanded(child: SizedBox()),
          ],
        ),
        SizedBox(
          height: LayoutManager.widthNHeight0(context, 0) * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultTextStyle(
              style: TextStyle(),
              child: Flexible(
                child: Text(
                  text ?? '',
                  style: TextStyle(
                    height: 1.3,
                    fontFamily: ThemeManager.fontFamily,
                    color: ThemeManager.textColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (writtenByExpert == 1)
          Padding(
            padding: const EdgeInsets.only(left: 286),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ThemeManager.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "EXPERT",
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.second,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _getDisplayTime(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      return '${DateFormat.Hm().format(date)}   ';
    }
  }
}
