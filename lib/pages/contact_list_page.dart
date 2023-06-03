import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('Contact List'),
              centerTitle: true,
            ),


            body: Consumer<ContactProvider> (
              builder: (context,provider,_)=>ListView.builder(
               itemCount:provider.contactList.length,
               itemBuilder: (context, index) {
                 final contact = provider.contactList[index];
                 return ListTile(

                   onTap: ()=> Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact.id),

                    title: Text(contact.name),
                    subtitle:  Text(contact.number),
                    trailing:  IconButton(icon: Icon(contact.favourite ? Icons.favorite : Icons.favorite_border),
                     onPressed: (){
                      provider.updateFavorite(contact.id!, contact.favourite, index);
                      },
                    ),
                  );

                },
             ),
            ),
    floatingActionButton: FloatingActionButton(
    onPressed: (){
    Navigator.pushNamed(context, NewContactPage.routeName);
    },
    child: Icon(Icons.add),
    tooltip: 'Add new Contact',

    ),


    );
  }
}
