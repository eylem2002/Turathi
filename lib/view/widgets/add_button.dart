import 'package:flutter/material.dart';
import 'package:turathi/view/view_layer.dart';
class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed});
final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundColor: ThemeManager.primary,
      radius: LayoutManager.widthNHeight0(context, 0) * 0.033,
      child: IconButton(
        icon: Icon(
          Icons.add,
          color: ThemeManager.second,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
