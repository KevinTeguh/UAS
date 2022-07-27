import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mahasiswa_app/model/mahasiswa_model.dart';

import '../service/api.dart';
import '../service/snack_bar.dart';

class FormMahasiswa extends StatefulWidget {
  final MahasiswaModel? data;
  const FormMahasiswa({Key? key,this.data}) : super(key: key);

  @override
  State<FormMahasiswa> createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {

  bool isMan = true;
  var namaController = TextEditingController();
  var nimController = TextEditingController();
  var jurusanController = TextEditingController();
  var alamatController = TextEditingController();
  bool _loadingSave = false;
  bool _loadingDelete = false;

  @override
  void initState(){
    super.initState();
    if (widget.data != null){
      namaController.text = widget.data!.nama!;
      nimController.text = widget.data!.nim!;
      jurusanController.text = widget.data!.jurusan!;
      alamatController.text = widget.data!.alamat!;
      if (widget.data?.jk == 'L'){
        isMan = true;
      }else{
        isMan = false;
      }
    }
  }

  void addMahasiswa()async{
    Map body = {
      'nama':namaController.text,
      'nim':nimController.text,
      'alamat':alamatController.text,
      'jurusan':jurusanController.text,
      'jk':isMan?'L':'P'
    };
    setState(() {
      _loadingSave = true;
    });
    try {
      // String jsonBody = jsonEncode(body);
      var result = await Api.addMahasiswa(body);
      if (!mounted) return;
      showSnackBar(context, result);
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
      print(e);
    }
    setState(() {
      _loadingSave = false;
    });
  }

  void updateMahasiswa()async{
    Map body = {
      'nama':namaController.text,
      'nim':nimController.text,
      'alamat':alamatController.text,
      'jurusan':jurusanController.text,
      'jk':isMan?'L':'P'
    };
    setState(() {
      _loadingSave = true;
    });
    try {
      // String jsonBody = jsonEncode(body);
      var result = await Api.updateMahasiswa(body,widget.data!.id!);
      if (!mounted) return;
      showSnackBar(context, result);
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
      print(e);
    }
    setState(() {
      _loadingSave = false;
    });
  }

  void deleteMahasiswa()async{
    setState(() {
      _loadingDelete = true;
    });
    try {
      // String jsonBody = jsonEncode(body);
      var result = await Api.deleteMahasiswa(widget.data!.id!);
      if (!mounted) return;
      showSnackBar(context, result);
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
      print(e);
    }
    setState(() {
      _loadingDelete = false;
    });
  }

  void showDeleteAlert(){
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
                  deleteMahasiswa();
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
          widget.data != null?'Ubah Mahasiswa':'Tambah Mahasiswa'
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nim Mahasiswa',
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: nimController,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Masukkan Nim',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      )),
                )
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Mahasiswa',
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Masukkan Nama',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      )),
                )
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jurusan Mahasiswa',
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: jurusanController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Masukkan Jurusan',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      )),
                )
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jenis Kelamin Mahasiswa',
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Checkbox(
                                value: isMan,
                                onChanged: (value){
                              setState((){
                                isMan = !isMan;
                              });
                            }),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Pria'
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Checkbox(
                                value: !isMan,
                                onChanged: (value){
                              setState((){
                                isMan = !isMan;
                              });
                            }),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Wanita'
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Mahasiswa',
                ),
                SizedBox(height: 8,),
                TextFormField(
                  maxLines: 4,
                  controller: alamatController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Masukkan Alamat',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      )),
                )
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                if (widget.data != null)Expanded(
                  child: OutlinedButton(
                    onPressed: (){
                      showDeleteAlert();
                    },
                    child: _loadingDelete?SizedBox(height:10,width: 10,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,),):Text(
                      'Hapus'
                    ),
                  ),
                ),
                if (widget.data != null)SizedBox(width: 10,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      if (widget.data == null){
                        addMahasiswa();
                      }else{
                        updateMahasiswa();
                      }
                    },
                    child: _loadingSave?SizedBox(height:10,width: 10,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,),):Text(
                      'Simpan'
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
