import 'dart:io';

import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
   static const String routeName = '/contact_details';

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {

  late int id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Contact Details'),
        centerTitle: true,
      ),


      body: Center(

        child: Consumer<ContactProvider>(
          builder: (context,provider,_)=> FutureBuilder<ContactModel>(
            future: provider.getContactById(id),

            builder: (context ,snapshot){

              if(snapshot.hasData){

                final model = snapshot.data;
                return ListView(

                  children: [
                   Image.file(File(model!.image!),width: double.infinity,height: 300,fit: BoxFit.cover,)

                  ],

                );
              }
              if(snapshot.hasError){

                return const Text('Failed to fetch data');
              }
              return const CircularProgressIndicator();
            },
          ),
          ),
        ),
      );

  }
}
