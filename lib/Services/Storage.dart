import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:primebasket/Models/tradesModel.dart';
class Storage{

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadfile(String filename, String filepath, String tradesID) async{
    File file = File(filepath);
    try{
      await storage.ref('/uploads/chats/$tradesID/file:/$filepath').putFile(file);
    } on FirebaseException catch(e){
      print(e);
    }
  }
    Future getImage(String tradesID) async{
      ListResult result = await storage.ref(
          'uploads/chats/$tradesID/file://data/user/0/com.example.primebasketapp/cache/file_picker/').list();
      result.items.forEach((Reference ref) {
        print('found file: $ref');
      });
      print(result.items[0].name);
      return result.items[0].name;
    }
    Future getdata(String tradesID) async{
   String name = await getImage(tradesID);
    String downloadUrL = await storage.ref('uploads/chats/$tradesID/file://data/user/0/com.example.primebasketapp/cache/file_picker/'
        '$name').getDownloadURL();
    return downloadUrL;
  }


}