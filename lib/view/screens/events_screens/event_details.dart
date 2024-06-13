import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';

import 'package:turathi/view/view_layer.dart';
import 'package:intl/intl.dart';


// page to view selected events info
class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({Key? key, required this.eventModel})
      : super(key: key);

  final EventModel eventModel;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int selectedImage = 0;

  Key? get key => null;

  @override
  Widget build(BuildContext context) {
    String date= "Date";
    String dateFormate='yyyy-MM-dd';
    String ticketPrice=  "Ticket Price";
    String free='Free';
    String visitEvent= 'Visit Event';

    var height = LayoutManager.widthNHeight0(context, 0) * 0.55;
    double left = LayoutManager.widthNHeight0(context, 0) * 0.02;
    return Stack(
      children: <Widget>[
        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.network(
            widget.eventModel.images![selectedImage],
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.1),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned(
          top: height - 100,
          left: left,
          child: SizedBox(
            width: LayoutManager.widthNHeight0(context, 1) - 20,
            child: AutoSizeText(
                maxLines: 3,
                widget.eventModel.name!,
                style: ThemeManager.textStyle.copyWith(
                   shadows: const [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(6, 6),
                          ),
                        ],
                  fontSize: 26,
                    color: ThemeManager.second,
                    decoration: TextDecoration.none)),
          ),
        ),
        Positioned(
            top: height - 36,
            bottom: 0,
            child: Container(
              width: LayoutManager.widthNHeight0(context, 1),
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(35))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25, top: 20, bottom: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeManager.containerback.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffE9E6E2).withOpacity(0.4),
                            spreadRadius: 0,
                            blurRadius: 12,
                            offset: Offset(3, -3),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: LayoutManager.widthNHeight0(context, 0) * 0.074,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                    date,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeManager.textColor
                                            .withOpacity(0.7),
                                        fontFamily: ThemeManager.fontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                     SizedBox(
                                      height: LayoutManager.widthNHeight0(context, 0)*0.008,
                                    ),
                                    Text(
                                      DateFormat(dateFormate)
                                          .format(widget.eventModel.date!),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeManager.primary,
                                        fontFamily: ThemeManager.fontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                    ticketPrice,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeManager.textColor
                                            .withOpacity(0.7),
                                        fontFamily: ThemeManager.fontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    SizedBox(
                                      height: LayoutManager.widthNHeight0(context, 0)*0.008,
                                    ),
                                    Text(
                                      widget.eventModel.ticketPrice == 0
                                          ? 
                                          free: widget.eventModel.ticketPrice
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeManager.primary,
                                        fontFamily: ThemeManager.fontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${widget.eventModel.description!} ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeManager.textColor.withOpacity(0.7),
                        fontFamily: ThemeManager.fontFamily,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 1) * 0.0357,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          addNewLineAfterChars(
                            widget.eventModel.address!,
                            18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          style: ThemeManager.textStyle.copyWith(
                            decoration: TextDecoration.none,
                            fontSize: 19,
                            color: ThemeManager.primary,
                          ),
                          maxLines: 3,
                        ),

                        defaultButton(
                          text:visitEvent,
                          borderRadius: 18,
                          background: ThemeManager.primary,
                          textColor: ThemeManager.second,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreenLocation(
                                    lon: widget.eventModel.longitude!,
                                    lat: widget.eventModel.latitude!),
                              ),
                            );
                          },
                          borderWidth: 0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
        Positioned(
            top: LayoutManager.widthNHeight0(context, 1) * 0.1, //45,
            left: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.white,
                  size: 25,
                ))),
        Positioned(
            top: LayoutManager.widthNHeight0(context, 1) * 0.3, //45,
            right: LayoutManager.widthNHeight0(context, 1) * 0.03, //10
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int index = 0;
                    index < widget.eventModel.images!.length;
                    index++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SmallImage(
                      isSelected: index == selectedImage,
                      press: () {
                        setState(() {
                          selectedImage = index;
                        });
                      },
                      image: widget.eventModel.images![index],
                    ),
                  ),
              ],
            )),
      ],
    );
  }
}
