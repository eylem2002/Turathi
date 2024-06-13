import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/data_layer.dart';
import '../../view_layer.dart';

//form to edit the added place data
class EditPlace extends StatefulWidget {
  const EditPlace({super.key,required this.placeModel});
  final PlaceModel placeModel;

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  final formKey = GlobalKey<FormState>();
  bool mapScreenOpened = false;
  List<double>? data;
  List<XFile>? images;
  TextEditingController? title;
  TextEditingController? description;
  TextEditingController? address;
  TextEditingController? status;




  @override
  void initState() {
    super.initState();
     title = TextEditingController(text: widget.placeModel.title);
    description = TextEditingController(text: widget.placeModel.description);
     address = TextEditingController(text: widget.placeModel.address);
     status = TextEditingController(text: widget.placeModel.status);
  }
  @override
  Widget build(BuildContext context) {
log(widget.placeModel.title!);
    final PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        centerTitle: true,
        title: Text(
          'Edit Place',
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
                  controller: title!,
                  labelText: 'Name',
                  hintText: "edit title",
                ),
                TextFormFieldWidget(
                  controller: address!,
                  hintText: "edit addredd",
                  labelText: 'Address',
                ),
                TextFormFieldWidget(
                  hintText: "edit description",
                  labelText: 'Description',
                  maxLine: 3,
                  controller: description!,
                ),
                TextFormFieldWidget(
                  controller: status!,
                  hintText: "edit status",
                  labelText: 'Status',
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
                        final temp =   await   Navigator.push(
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
                    data ??= [widget.placeModel.latitude!,widget.placeModel.longitude!];
                    images ??= [];
                    if (formKey.currentState!.validate() && images != null &&data!.isNotEmpty) {
                      log(title!.text);
                      widget.placeModel.title = title!.text;
                      widget.placeModel.status = status!.text;
                      widget.placeModel.description = description!.text;
                      widget.placeModel.address = address!.text;
                      widget.placeModel.latitude = data![0];
                      widget.placeModel.longitude = data![1];

                      placesProvider.updatePlace(
                          placeModel:  widget.placeModel,

                        images:   images!);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Place Updated Successfully")));
                      Navigator.pop(context);
                    } else {
                      log('add place failed');
                    }
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Edit Place',
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
