import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//form to fill the event data
class AddNewEvent extends StatefulWidget {
  const AddNewEvent({super.key});

  @override
  State<AddNewEvent> createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  final address = TextEditingController();
  final ticketPrice = TextEditingController();
  final creatorName = TextEditingController();


  bool mapScreenOpened = false;

  DateTime selectedDate = DateTime.now();
  List<double>? data;
  List<XFile>? images;

// pick the event date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
          'Add Event',
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
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: name,
                  hintText: 'Enter event name',
                  labelText: 'Name',
                ),
                TextFormFieldWidget(
                  controller: address,
                  hintText: 'Enter event address in your words',
                  labelText: 'Address',
                ),
                NumberFormFieldWidget(
                  controller: ticketPrice,
                  hintText: 'Enter event ticket price, 0 for free events',
                  labelText: 'Ticket Price',
                ),
                TextFormFieldWidget(
                  hintText: 'Enter event description',
                  labelText: 'Description',
                  maxLine: 3,
                  controller: description,
                ),
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
              //  if (images != null) Image.file(File(image!.path)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          color: mapScreenOpened &&
                                  addEventLocatonLat != 0 &&
                                  addEventLocatonLog != 0
                              ? Colors.grey
                              : (addEventLocatonLat != 0 &&
                                      addEventLocatonLog != 0)
                                  ? Colors.grey
                                  : ThemeManager.primary,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pickDate();
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Select date',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (formKey.currentState!.validate() && images != null && data != null) {
                        eventProvider.addEvent(
                            EventModel(
                              name: name.text,
                              address:  address.text,
                              date: selectedDate,
                              description: description.text,
                              latitude: data![0],
                              longitude: data![1],
                              ticketPrice: double.parse(ticketPrice.text)
                            ),images!);
                        Navigator.of(context).pop();

                      }
                      else {
                        log('add Event failed');
                      }
                    });
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Add Event',
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
