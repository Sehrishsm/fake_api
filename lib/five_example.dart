import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Model/products_model.dart';
class FiveExample extends StatefulWidget {
  const FiveExample({Key? key}) : super(key: key);

  @override
  State<FiveExample> createState() => _FiveExampleState();
}

class _FiveExampleState extends State<FiveExample> {
  Future<ProductsModel> getProductsApi()async{
  final response = await http.get(Uri.parse('https://webhook.site/77d26a22-6f80-4c74-940a-ce2f2b550457'));
  var data= jsonDecode(response.body.toString());
  if(response.statusCode==200){
    return ProductsModel.fromJson(data);
  }else{
    return ProductsModel.fromJson(data);
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fake Api'),
      ),
      body: Column(
        children: [
       Expanded(
           child: FutureBuilder<ProductsModel>(
             future: getProductsApi(),
             builder: (context, snapshot){
               if(snapshot.hasData){
                 return ListView.builder(
                     itemCount: snapshot.data!.data![0].products!.length,
                     itemBuilder: (context,index){
                       return Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ListTile(
                             title: Text(snapshot.data!.data![0].shopcity.toString()),
                             subtitle: Text(snapshot.data!.data![0].shopemail.toString()),
                             leading: CircleAvatar(
                               backgroundImage: NetworkImage(snapshot.data!.data![0].image.toString()),
                             ),
                           ),
                           Container(
                             height: MediaQuery.of(context).size.height *.3,
                             width:MediaQuery.of(context).size.width * 1,
                             child: ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                 itemCount:snapshot.data!.data![0].products![index].images!.length,
                                 itemBuilder: (context,pos){
                                   return Padding(
                                     padding: const EdgeInsets.only(right: 10),
                                     child: Container(
                                       margin: const EdgeInsets.all(10),
                                       height: MediaQuery.of(context).size.height *.25,
                                       width:MediaQuery.of(context).size.width * .5,
                                       decoration: BoxDecoration(
                                           color: Colors.white,
                                           border: Border.all(color: Colors.black, width: 1.2),
                                           borderRadius: BorderRadius.circular(10),
                                           image: DecorationImage(
                                             fit: BoxFit.cover,
                                             image: NetworkImage(snapshot.data!.data![0].products![index].images![pos].url.toString()),
                                           )
                                       ),
                                     ),
                                   );
                                 }),
                           ),
                           Icon(snapshot.data!.data![0].products![index].inWishlist== false ? Icons.favorite : Icons.favorite_outline),
                         ],
                       );

                     });
               }
               else{
                 return Text("Loading");
               }

             },
           )
       )
        ],
      ),
    );
  }
}
