import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/data_layer.dart';
import '../../view_layer.dart';

//admin event edit page
class EditEvent extends StatefulWidget {
  const EditEvent({Key? key, required this.eventModel}) : super(key: key);
  final EventModel eventModel;

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final formKey = GlobalKey<FormState>();
  XFile? image;
  bool mapScreenOpened = false;
  DateTime selectedDate = DateTime.now();
  List<double>? data;
  List<XFile>? images;
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController address;
  late TextEditingController dateEvent;
  late TextEditingController ticketPrice;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.eventModel.name);
    description = TextEditingController(text: widget.eventModel.description);
    address = TextEditingController(text: widget.eventModel.address);
    dateEvent = TextEditingController(text: widget.eventModel.date.toString());
    ticketPrice = TextEditingController(text: widget.eventModel.ticketPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    final EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        centerTitle: true,
        title: Text(
          'Edit Event',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: title,
                  labelText: 'Name',
                  hintText: "Edit title",
                ),
                TextFormFieldWidget(
                  controller: address,
                  hintText: "Edit address",
                  labelText: 'Address',
                ),
                TextFormFieldWidget(
                  hintText: "Edit description",
                  labelText: 'Description',
                  maxLine: 3,
                  controller: description,
                ),
                TextFormFieldWidget(
                  controller: dateEvent,
                  hintText: "Edit dateEvent",
                  labelText: 'Date Event',
                ),
                TextFormFieldWidget(
                  controller: ticketPrice,
                  hintText: "Edit ticket price",
                  labelText: 'Ticket Price',
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.08,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        images = await pickImages();
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Pick Image',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final temp = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPlaceMap(),
                          ),
                        );
                        setState(() {
                          mapScreenOpened = true;
                          data = temp;
                        });
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Location',
                        style: ThemeManager.textStyle.copyWith(
                          color: mapScreenOpened && data != null && data!.isNotEmpty
                              ? Colors.grey
                              : ThemeManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.1,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (data == null) {
                      data = [
                        widget.eventModel.latitude!,
                        widget.eventModel.longitude!
                      ];
                    }
                    if (images == null) {
                      images = [];
                    }
                    if (formKey.currentState!.validate() &&
                        images != null &&
                        data != null) {
                      widget.eventModel.name = title.text;
                      widget.eventModel.date = DateTime.parse(dateEvent.text);
                      widget.eventModel.description = description.text;
                      widget.eventModel.address = address.text;
                      widget.eventModel.ticketPrice = double.parse(ticketPrice.text);
                      widget.eventModel.latitude = data![0];
                      widget.eventModel.longitude = data![1];

                      eventProvider.updateEvent(
                          eventModel: widget.eventModel, images: images!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Event Updated Successfully")));
                      Navigator.pop(context);
                    } else {
                      log('Update Event failed');
                    }
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Edit Event',
                    style: ThemeManager.textStyle
                        .copyWith(color: ThemeManager.textColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
