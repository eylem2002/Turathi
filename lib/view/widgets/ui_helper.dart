import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:turathi/view/view_layer.dart';

snackBarFunction({required String msg, context}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}

autoTextFunction({required String txt, int maxLine = 2}) {
  return AutoSizeText(
    txt,
    style: ThemeManager.textStyle.copyWith(fontSize: 12),
    textAlign: TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,

  );
}
