import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data_layer.dart';
import '../../view_layer.dart';

//edit place info from admin page
class EditPlaceAdmin extends StatefulWidget {
  const EditPlaceAdmin({super.key, required this.placeModel});
  final PlaceModel placeModel;

  @override
  State<EditPlaceAdmin> createState() => _EditPlaceAdminState();
}

class _EditPlaceAdminState extends State<EditPlaceAdmin> {
  final formKey = GlobalKey<FormState>();
  XFile? image;
  bool mapScreenOpened = false;
  List<double>? data;
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
    AdminService adminService = AdminService();
    var style = ThemeManager.textStyle.copyWith(fontSize: 15);
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        centerTitle: true,
        title: Text(
          'Edit Place ADMIN',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFieldWidget(
                  controller: title!,
                  labelText: 'Name',
                  hintText: "edit title",
                ),
                TextFormFieldWidget(
                  controller: address!,
                  hintText: "edit address",
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
                Text("State : ${widget.placeModel.state} ", style: style),
                Text("Likes: ${widget.placeModel.likesList!.length}",
                    style: style),
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
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary
                            
                                ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      key: Key("Visibility icon"),
                        onPressed: () {
                          setState(() {
                            widget.placeModel.isVisible =
                                !widget.placeModel.isVisible!;
                          });
                        },
                        icon: Icon(widget.placeModel.isVisible!
                            ? Icons.visibility_off
                            : Icons.visibility,color: ThemeManager.primary,),
                        label: widget.placeModel.isVisible!
                            ? Text("Hide Place",style: TextStyle(color: ThemeManager.primary))
                            : Text("Show Place",style: TextStyle(color: ThemeManager.primary),)),

                            
                    ElevatedButton(
                      onPressed: () async {
                        data ??= [
                            widget.placeModel.latitude!,
                            widget.placeModel.longitude!
                          ];

                        if (formKey.currentState!.validate() &&

                            data!.isNotEmpty) {
                          log(title!.text);
                          widget.placeModel.title = title!.text;
                          widget.placeModel.status = status!.text;
                          widget.placeModel.description = description!.text;
                          widget.placeModel.address = address!.text;
                          widget.placeModel.latitude = data![0];
                          widget.placeModel.longitude = data![1];

                          adminService.updatePlace(
                              placeModel: widget.placeModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Place Updated Successfully")));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
