import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import '/services/uploadapi.dart';



class Item {
  String name;


  Item({required this.name});
}



class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}




class MyHomePageState extends State<MyHomePage> {
  List<File> selectedFiles = [];
  List<Item> items = []; 

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        // Adiciona os arquivos selecionados à lista de selectedFiles
        selectedFiles.addAll(result.paths.map((path) => File(path!)).toList());
        
        // Adiciona os arquivos selecionados à lista de itens, evitando duplicatas
        selectedFiles.forEach((file) {
          String fileName = path.basename(file.path);
          // Verifica se o arquivo já está na lista de items
          if (!items.any((item) => item.name == fileName)) {
            items.add(Item(name: fileName));
          }
        });
      });
    }
  }

  Widget listView(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Item item = items[index];
        return ListTile(
          title: Row(
            children: [
              Icon(Icons.attach_file,color: Colors.black,size: 22,), 
              SizedBox(width: 1), 
              Container(
                width: 160, 
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 1, 
                ),
              ),
              Spacer(), 
              GestureDetector(
                onTap: () {
                  String fileName = item.name;
                  int fileIndex = selectedFiles.indexWhere((file) => path.basename(file.path) == fileName);
                  if (fileIndex != -1) {
                    setState(() {
                      selectedFiles.removeAt(fileIndex);
                    });
                  }  
                  setState(() {
                    items.removeAt(index);
                  });
                },
                child: Icon(
                  Icons.delete_outlined, 
                  color: Colors.red,size: 22, ),  
              ),
            ],
          ),
        );
      },
    );
  }
      
  Widget buildAttachButton(BuildContext context,) {
    return ElevatedButton(
          onPressed: _pickFiles,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: Colors.black,
            elevation: 1,
            side: const BorderSide(width: 1, color: Colors.grey),
            minimumSize: const Size(260, 110),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.black87,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                '''Clique aqui para 
    anexar um arquivo''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        );}

  void removeFile(int index) {
      setState(() {
        selectedFiles.removeAt(index);
      });
    }

    List<Item> itensEnviados = []; 

    
  void enviarItensSelecionados() {
    itensEnviados.addAll(selectedFiles.map((file) => Item(name: path.basename(file.path))));
    selectedFiles.clear();
    setState(() {
      items.clear();
    });
  }

    
  Widget listaItensEnviados(BuildContext context) {
  return ListView.builder(
    itemCount: itensEnviados.length,
    itemBuilder: (context, index) {
      Item item = itensEnviados[index];
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(10), 
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(7), 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  itensEnviados.removeAt(index);
                });
              },
              child: const Icon(
                Icons.delete_outlined,
                color: Colors.red,size: 18, 
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
              },
              child: const Icon(
                Icons.arrow_downward_rounded,
                color: Colors.amber, size: 18,
              ),
            ),
          ],
        ),
      );
    },
  );
}


  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
      body: Container(
        width: screenWidth,
        decoration:const  BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/degrade.png'),
            fit: BoxFit.cover,),),

            padding:const EdgeInsets.symmetric(vertical: 20),
              child:Container(color: Colors.white,
                child: Row(children: [
                  Container(width: screenWidth/2,color: Colors.white,

                  child: Column(children: [
                    const SizedBox(height: 5,),
                    const Row(children: [
                      SizedBox(width: 20,),
                      Text('👋',style: TextStyle(fontSize: 30),),
                      Text('Bem-vindo (a)',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    ],),

                    const SizedBox(height: 140,),
                    buildAttachButton(context),
                    const SizedBox(height: 30,),

                    SizedBox(height:160 ,width: 250,child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [const Row(
                        children:[ 
                          SizedBox(width: 15,),
                          Text('Itens anexados',
                          style: TextStyle(
                            fontSize: 15, fontWeight: 
                            FontWeight.bold),)], ),
                      Expanded(child: 
                      listView(context)),
                      ],)),

                    const SizedBox(height: 25,),

                    ElevatedButton(onPressed: (){
                      //try{
                       // uploadFiles(selectedFiles);
                        //}catch(e) {
                          enviarItensSelecionados();                
                        //}
                        } ,

                    child: Text('Enviar'),
                    style:ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,horizontal: 100),
                        shape:RoundedRectangleBorder(
                          borderRadius: 
                          BorderRadius.circular(5)),
                           backgroundColor: Colors.black),)],),
                  
                  ),

                  Column(children: 
                  [const SizedBox(height: 130,),
                  Container( 
                    width: 1,
                    height: screenHeight-(screenHeight/3),
                    color: const Color(0xFF838383),)],),

                  const SizedBox(width: 20,),

                  Container(
                    color: Colors.white,
                    width: (screenWidth/2)-22,
                    child:Column(
                      children:[const SizedBox(
                        height: 10,),
                        Row(mainAxisAlignment: 
                        MainAxisAlignment.end,children: 
                        [ElevatedButton.icon(onPressed: () {},
                            icon: const Icon(
                              Icons.account_circle_outlined, 
                              color: Colors.black),
                            label: const SizedBox.shrink(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                          ),
                          const SizedBox(width: 10), 
                         
                          ElevatedButton.icon(
                            onPressed: () 
                            { Navigator.pop(context);},
                            icon: const Icon(
                              Icons.exit_to_app, 
                              color: Colors.black),
                            label: const SizedBox.shrink(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),),],) 

                            ,const SizedBox(height: 70,),
                            
                      const Row(children:[SizedBox(
                        width: 300,),
                        Text('Itens anexados anteriormente',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),)],),

                      const SizedBox(height: 40,),
                      Align(alignment: Alignment.centerLeft,child:SizedBox(
                        height: 400,
                        width: 450,
                        child:Expanded(child: listaItensEnviados(context)) ,) ,)

                    ]) ,)
                ],),)
                
      ),
    );
  }
}



