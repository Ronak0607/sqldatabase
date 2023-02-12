import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqldatabase/Database/DbHelper.dart';
import 'package:sqldatabase/Screen/Controller/HomeController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmobile = TextEditingController();

  TextEditingController utxtname = TextEditingController();
  TextEditingController utxtmobile = TextEditingController();

  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DbHelper db = DbHelper();
    controller!.studentlist.value = await db.readdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: controller.studentlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "${controller.studentlist.value[index]['name']}"),
                      subtitle: Text(
                          "${controller.studentlist.value[index]['mobile']}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  DbHelper db = DbHelper();
                                  db.deletdata(
                                      "${controller.studentlist.value[index]['id']}");
                                  getdata();
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  utxtname= TextEditingController(text: "${controller.studentlist.value[index]["name"]}");
                                  utxtmobile= TextEditingController(text: "${controller.studentlist.value[index]["mobile"]}");

                                  Get.defaultDialog(
                                      title: "Add Data",
                                      content: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: Column(
                                          children: [

                                            TextField(
                                              controller: utxtname,
                                              decoration: InputDecoration(
                                                hintText: "Name",
                                              ),
                                            ),
                                            TextField(
                                              controller: utxtmobile,
                                              decoration: InputDecoration(
                                                hintText: "Mobile",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  DbHelper db = DbHelper();
                                                  db.editdata(
                                                      "${controller.studentlist.value[index]['id']}",
                                                      utxtname.text,
                                                      utxtmobile.text);
                                                  getdata();
                                                  Get.back();
                                                },
                                                child: Text("Submit"))
                                          ],
                                        ),
                                      ));
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
                title: "Add Data",
                content: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: txtname,

                        decoration: InputDecoration(
                          hintText: "Name",
                        ),
                      ),
                      TextField(
                        controller: txtmobile,
                        decoration: InputDecoration(
                          hintText: "Mobile",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            DbHelper db = DbHelper();
                            db.insertata(txtname.text, txtmobile.text);
                            getdata();
                            Get.back();
                          },
                          child: Text("Submit"))
                    ],
                  ),
                ));
          },
          child: Icon(Icons.add)),
    ));
  }
}
