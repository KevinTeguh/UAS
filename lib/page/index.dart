import 'package:flutter/material.dart';
import 'package:mahasiswa_app/model/mahasiswa_model.dart';
import 'package:mahasiswa_app/page/form.dart';

import '../service/api.dart';
import '../service/snack_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool _loading = false;

  List<MahasiswaModel> data = [];

  @override
  void initState(){
    super.initState();
    _getMahasiswa();
  }

  Future<void> _getMahasiswa() async {
    setState(() {
      _loading = true;
    });
    try {
      data = await Api.getMahasiswa();
      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
      print(e);
    }
    setState(() {
      _loading = false;
    });
  }

  void deleteMahasiswa(String id)async{
    setState(() {
      _loading = true;
    });
    try {
      var result = await Api.deleteMahasiswa(id);
      if (!mounted) return;
      showSnackBar(context, result);
      _getMahasiswa();
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
      print(e);
    }
    setState(() {
      _loading = false;
    });
  }

  void showDeleteAlert(String id){
    showDialog(
      context: context,
      builder: (ctx){
         return AlertDialog(
           title: Text("Hapus Data"),
           content: Text("Anda yakin ingin menghapus data ini?"),
           actions: [
             TextButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               child: Text(
                 'Batal',
                 style: TextStyle(
                     color: Colors.grey
                 ),
               ),
             ),
             TextButton(
               onPressed: (){
                 deleteMahasiswa(id);
                 Navigator.pop(context);
               },
               child: Text(
                 'Hapus',
                 style: TextStyle(
                   color: Colors.red
                 ),
               ),
             ),
           ],
         );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Mahasiswa'
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _getMahasiswa,
        child: Visibility(
          visible: !_loading,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (ctx,index){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 16,
                          offset: Offset(0, 4)
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].nama ?? '-',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            data[index].nim ?? '-'
                          ),
                          Text(
                              data[index].jurusan ?? '-'
                          ),
                          Text(
                              data[index].jk ?? '-'
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return FormMahasiswa(
                                data: data[index],
                              );
                            })).then((value) => _getMahasiswa());
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            showDeleteAlert(data[index].id!);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (ctx,index){
              return SizedBox(height: 10,);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
            return FormMahasiswa();
          })).then((value) => _getMahasiswa());
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}
