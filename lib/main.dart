import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_list_page.dart';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers:[

        ChangeNotifierProvider(create :(contect)=>ContactProvider()..getAllContacts()),
      ],
      child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {

           ContactListPage.routeName:(context)=>ContactListPage(),
           NewContactPage.routeName:(context)=>NewContactPage(),
           ContactDetailsPage.routeName:(context)=>ContactDetailsPage()
      },
    );
  }
}
