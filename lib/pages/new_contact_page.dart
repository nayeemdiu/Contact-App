import 'dart:io';

import 'package:contact_app/db/db_helper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameControler = TextEditingController();
  final numControler = TextEditingController();
  final emailControler = TextEditingController();
  final addressControler = TextEditingController();
//  final companyControler = TextEditingController();
 // final designationControler = TextEditingController();
//  final websiteControler = TextEditingController();
  String? _dob;
  String? _genderGroupvalue;
  String? _imagePath;
  ImageSource _imageSource= ImageSource.camera;

  final fromKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    nameControler.dispose();
    emailControler.dispose();
    numControler.dispose();
    addressControler.dispose();
   // companyControler.dispose();
   // designationControler.dispose();
   // websiteControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _saveContactInfo, icon: Icon(Icons.save),color: (Colors.yellow),)
        ],



      ),
      body: Form(
         key: fromKey,
         child: ListView(
          children: [
            TextFormField(
              controller: nameControler,
              decoration: InputDecoration(
                  labelText: 'Name', prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                if (value.length > 20) {
                  return 'Name must be in 20 carecter';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: numControler,
              decoration: InputDecoration(
                  labelText: 'Number', prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                if (value.length > 20) {
                  return 'Name must be in 20 carecter';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: emailControler,
              decoration: InputDecoration(
                  labelText: 'Email', prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                if (value.length > 20) {
                  return 'Name must be in 20 carecter';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: addressControler,
              decoration: InputDecoration(
                  labelText: 'Address', prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                if (value.length > 20) {
                  return 'Name must be in 20 carecter';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            // TextFormField(
            //   controller: companyControler,
            //   decoration: InputDecoration(
            //       labelText: 'Company', prefixIcon: Icon(Icons.person)),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'This field must not be empty';
            //     }
            //     if (value.length > 20) {
            //       return 'Name must be in 20 carecter';
            //     } else {
            //       return null;
            //     }
            //   },
            // ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton(onPressed: _selectedDate, child: Text('Select Date of Birth')),
                  Text(_dob==null?'No Date Selected':_dob!),
                ],
              ),
            ),
            SizedBox(height: 10,),
            
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Text('Select Gender'),
                  Radio<String>(
                      value: 'Male',
                      groupValue:_genderGroupvalue,
                      onChanged: (value){
                        setState(() {
                          _genderGroupvalue=value;
                        });

                      }),
                  Text('Male'),
                  Radio<String>(
                      value: 'Female',
                      groupValue:_genderGroupvalue,
                      onChanged: (value){
                        setState(() {
                          _genderGroupvalue=value;
                        });

                      }),
                  Text('Female'),

                  Card(
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Card(
                          child: _imagePath==null?Image.asset('images/download.png',
                          height: 100,width: 100,
                          fit: BoxFit.contain,):
                              Image.file(File(_imagePath!,),
                                height: 100,width: 100,
                                fit: BoxFit.contain,
                              )
                        ),
                     Row(
                     children: [
                       ElevatedButton(
                           onPressed: (){
                             _imageSource = ImageSource.camera;
                             _getImage();
                           },
                           child: Text('Camera')),
                       SizedBox(width: 20,),
                       ElevatedButton(
                           onPressed: (){
                             _imageSource = ImageSource.gallery;
                             _getImage();
                       },
                           child: Text('Gallery')),
                     ],

                     ),


                      ],

                    ),
                  ),

                ],
                
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _saveContactInfo() async {

 if(fromKey.currentState!.validate()){

    final contact = ContactModel(

            name: nameControler.text,
            number: numControler.text,
            email: emailControler.text,
            adress: addressControler.text,
            dob: _dob,
            gender: _genderGroupvalue  ,
            image: _imagePath
    );
   print(contact.toString());

  //final rowId = await DBHelper.insertContact(contact);

    final status = await Provider.of<ContactProvider>(context,listen:false)
    .insertContact(contact);
    if(status){
      Navigator.pop(context);
    }
  else{


  }
  }
}

  void _selectedDate() async{

    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

      if(selectedDate!=null){
          setState(() {
            _dob= DateFormat('dd/MM/yyyy').format(selectedDate);
          });

      }

  }

  void _getImage() async {

     final selectedImage = await ImagePicker().pickImage(source: _imageSource);

     if(selectedImage!=null){

       setState(() {
         _imagePath =  selectedImage.path;
       });
     }

  }
}
