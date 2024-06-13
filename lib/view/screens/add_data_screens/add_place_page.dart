import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/data_layer.dart';
import '../../view_layer.dart';

//form to fill data about new place
class AddNewPlace extends StatefulWidget {
  const AddNewPlace({super.key});

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final disc = TextEditingController();
  final address = TextEditingController();
  final creatorName = TextEditingController();

  XFile? image;
  bool mapScreenOpened = false;
  DateTime selectedDate = DateTime.now();
  List<double>? data;
  List<XFile>? images;

  @override
  Widget build(BuildContext context) {
    final PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        centerTitle: true,
        title: Text(
          'Add Place',
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
                  controller: name,
                  hintText: 'Enter place name',
                  labelText: 'Name',
                ),
                TextFormFieldWidget(
                  controller: address,
                  hintText: 'Enter place address in your words',
                  labelText: 'Address',
                ),
                TextFormFieldWidget(
                  hintText: 'Enter place description',
                  labelText: 'Description',
                  maxLine: 3,
                  controller: disc,
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
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.1,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        images != null &&
                        data!.isNotEmpty) {
                      String msg = await placesProvider.addPlace(
                          model: PlaceModel(
                            title: name.text,
                            description: disc.text,
                            address: address.text,
                            latitude: data![0],
                            longitude: data![1],
                          ),
                          images: images!.length > 4
                              ? images!.take(4).toList()
                              : images!);
                      if (msg == "Done") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Place Added Successfully")));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Place Name Already Exists"),
                          backgroundColor: Colors.red,
                        ));
                      }

                      Navigator.pop(context); //BACK
                    } else {
                      log('add place failed');
                    }
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Add Place',
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
