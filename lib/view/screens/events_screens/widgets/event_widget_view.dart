import 'package:flutter/material.dart';

import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

// Widget representing the event card
class ViewEvent extends StatelessWidget {
  ViewEvent({
    super.key,
    required this.eventModel,
    this.height,
    required this.flag,
  });


  final EventModel eventModel;
  double? height;
  bool flag;

  @override
  Widget build(BuildContext context) {
    // Set default height if not provided
    height ??= LayoutManager.widthNHeight0(context, 0) * 0.145;

    return InkWell(
      onTap: () {

         // Navigate to event details page when tapped
        Navigator.of(context)
            .pushNamed(eventDetailsRoute, arguments: eventModel);
      },
      child: Container(
        height: height,
        width: LayoutManager.widthNHeight0(context, 1),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: ThemeManager.second,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width:  LayoutManager.widthNHeight0(context, 1)*0.35,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  eventModel.images![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: LayoutManager.widthNHeight0(context, 1) * 0.02,
            ), 
            Padding(
              padding: EdgeInsets.all(
                  LayoutManager.widthNHeight0(context, 1) * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  autoTextFunction(txt: eventModel.name!, maxLine: 3),
                  
                  autoTextFunction(
                    txt: 'Address: ${eventModel.address!}',
                    maxLine: 3,
                  ),
                  if (flag)
                    autoTextFunction(
                      txt: 'Creator Name: ${eventModel.creatorName!}',
                    ),

                     // Display ticket price show 'Free' if ticket price is 0
                  if ( eventModel.ticketPrice != 0)
                    autoTextFunction(
                      txt: 'Ticket Price: ${eventModel.ticketPrice!}',
                    )
                    else if ( eventModel.ticketPrice == 0)
                    autoTextFunction(
                      txt: 'Ticket Price: Free',
                    )

                    
                   
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
