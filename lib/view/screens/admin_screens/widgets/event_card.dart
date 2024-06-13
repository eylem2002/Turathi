import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';
class EventCard extends StatefulWidget {
  const EventCard({
    Key? key,
    this.width = 300,
    this.aspectRatio = 0.7,
    required this.onPress,
    required this.eventModel,
  }) : super(key: key);

  final double width, aspectRatio;
  final EventModel eventModel;
  final VoidCallback onPress;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Stack(
              children: [
                ClipRRect(

                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      widget.eventModel.images != null &&
                          widget.eventModel.images!.isNotEmpty
                          ? widget.eventModel.images![0]
                          : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.15),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                Positioned(
                  bottom: LayoutManager.widthNHeight0(context, 0) * 0.045,
                  left: LayoutManager.widthNHeight0(context, 0) * 0.003,
                  child: Text(
                    widget.eventModel.name != null
                        ? widget.eventModel.name!.toUpperCase()
                        : 'No Title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: ThemeManager.second,
                      fontFamily: ThemeManager.fontFamily,
                      fontWeight: FontWeight.w900,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.0155,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
