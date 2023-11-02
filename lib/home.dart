import 'package:ExT/widgets/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {




  final CollectionReference expCollection = FirebaseFirestore.instance.collection('exp');
  //
  // void deleteExpense( String timestamp) {
  //   print(timestamp);
  //   FirebaseFirestore.instance
  //       .collection('exp')
  //       .doc(userid)
  //       .update({
  //     timestamp: FieldValue.delete(),
  //   })
  //       .then((value) => print("Expense deleted"))
  //       .catchError((error) {
  //     print("Failed to delete expense: $error");
  //   });
  // }


  //
  // Future<void> deleteExpense(String timestamp) async {
  //   try {
  //     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //         .collection('exp').doc(userid).get();
  //
  //     if (documentSnapshot.exists) {
  //       Map<String, dynamic> data = documentSnapshot.data() as Map<
  //           String,
  //           dynamic>;
  //
  //       if (data.containsKey('2023-11-01 18:42:00.000')) {
  //         data.remove('2023-11-01 18:42:00.000'); // Remove the map field
  //         await FirebaseFirestore.instance.collection('exp').doc(userid).set(
  //             data);
  //         print('Map "mapexp" deleted successfully from document $userid');
  //       } else {
  //         print('Field "mapexp" does not exist in document $userid');
  //       }
  //     } else {
  //       print('Document $userid does not exist');
  //     }
  //   } catch (e) {
  //     print('Error deleting mapexp: $e');
  //   }
  // }



  void deleteExpense( String timesta) {
    print(timesta);
    FirebaseFirestore.instance
        .collection('exp')
        .doc(userid)
        .update({
      '2023-11-01 18:41:00.000': FieldValue.delete(),
    })
        .then((value) {
  final snackBar = SnackBar(
  content: Text('Expense Deleted!'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  })
        .catchError((error) {      final snackBar = SnackBar(
  content: Text("Failed to delete expense: $error"),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide()),
          backgroundColor: Color(0xFFFCFD3D7),
          onPressed: (){
        showModalBottomSheet(
            elevation: 0,
            // backgroundColor: Colors.white,
            context: context,
            builder: (BuildContext context) {
              return modalsheet();
              ;});
      },child: Text('₹')),
      appBar: AppBar(
        title: Text('ExT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
        leading:
    Container(
      padding: EdgeInsets.all(5),
      child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(70)),


              child: Image.asset('assets/images/logo.png',height: MediaQuery.of(context).size.height*0.04)),
    ),
        actions: [
        IconButton(onPressed: (){
      showModalBottomSheet(
        elevation: 0,
        // backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return modalsheet();
            ;});

        }, icon: Icon(Icons.add))
      ],),
      body: Container(child: Column(children: [


        // Expanded(child:
        //
        //
        // )
// ,

      SizedBox(height: MediaQuery.of(context).size.height*0.07,),

     Container(
         height: MediaQuery.of(context).size.height*0.3,

         child: WeekdayBarChart()),

        SizedBox(height: MediaQuery.of(context).size.height*0.07,),


        Expanded(

        child: Container(
          // color: Colors.red,
          child: StreamBuilder(
            stream: expCollection.doc(userid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              Map<String, dynamic>? expenses = snapshot.data?.data() as Map<String, dynamic>?;

              List<Widget> listTiles = [];

              if (expenses != null) {
                List<MapEntry<String, dynamic>> sortedExpenses = expenses.entries.toList()
                  ..sort((a, b) => DateTime.parse(b.key).compareTo(DateTime.parse(a.key)));

                for (var entry in sortedExpenses) {
                  DateTime timestamp = DateTime.parse(entry.key);
                  String tr = entry.key;
                  String formattedDate = DateFormat('d MMM, EEE, hh:mm a').format(timestamp);

                  print(entry.key);

                  listTiles.add(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress:(){

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Expense?'),
                                  content: Text('Are you sure?  \n \nItem: ${entry.value['title']}\nDate: ${formattedDate}'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,


                                      children: [
                                        ElevatedButton(

                                            onPressed: (){deleteExpense(tr);}, child: Text('Delete',style: TextStyle(color: Colors.red),)),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );

                  },
                          child: Card(

                            color: Colors.white,
                            elevation: 0,
                            child: Container(
                              // color: Colors.red,
                              padding:EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.07),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(entry.value['title'],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),

                                      Text(formattedDate,style: TextStyle(color: Colors.grey,fontSize: 12),),



                                    ],),

                                  Text('₹ ${entry.value['amount']}',style: TextStyle(color: Colors.green,fontSize: 16),),

                                ],
                              ),
                            ),

                          ),
                        ),

                        Container(
                            padding:                      EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.17,vertical: MediaQuery.of(context).size.height*0.01),
                            child: Divider())
                      ],
                    ),
                  );
                }
              }

              return ListView(
                children: listTiles,
              );
            },
          ),
        ),

      ),





      ],),),
    );
  }
}




class modalsheet extends StatefulWidget {
  const modalsheet({super.key});

  @override
  State<modalsheet> createState() => _modalsheetState();
}

class _modalsheetState extends State<modalsheet> {



  TextEditingController title =TextEditingController();
  TextEditingController amount =TextEditingController();



  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();


    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate ) {
setState(() {
  selectedDate = pickedDate;

}

);    } else if (pickedDate == null && selectedDate.isBefore(now)) {


setState(() {
  selectedDate = now;

});    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  String formatDateTime(DateTime date, TimeOfDay time) {
    DateTime now = DateTime.now();
    String formattedDate = '';

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      formattedDate = DateFormat.jm().format(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    } else {
      formattedDate = DateFormat('d MMM, EEE, hh:mm a').format(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    }

    return formattedDate;
  }

  final CollectionReference expCollection = FirebaseFirestore.instance.collection('exp');

  void _addExpense() {
    String titleupload = title.text;
    double amountupload = double.parse(amount.text);

    DateTime selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    Map<String, dynamic> expenseData = {
      'title': titleupload,
      'amount': amountupload,
      'timestamp': selectedDateTime,
    };

    Map<String, dynamic> documentData = {
      selectedDateTime.toString(): expenseData,
    };

    expCollection.doc(userid).set( documentData, SetOptions(merge: true));
  }







  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,left: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.width*0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title'),
            Card(
              child: TextFormField(
                controller: title,
                decoration: InputDecoration(
                    border: InputBorder.none
                ),

                keyboardType: TextInputType.name,



              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width*0.03,
            ),


            Text('Amount'),
            Card(
              child: TextFormField(
                controller: amount,
                decoration: InputDecoration(
                    border: InputBorder.none
                ),

                keyboardType: TextInputType.number,



              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date and Time'),

                TextButton(onPressed: (){

                  setState(() {
                    _selectDateTime(context);
                  });
                }, child: Text(formatDateTime(selectedDate, selectedTime)))
              ],
            ),



            SizedBox(
              height: MediaQuery.of(context).size.width*0.03,
            ),
            
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white

                ),
                onPressed: (){

                  _addExpense();
                }, child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                  child: Text('Submit',),
                )))
          ],)
    );
  }
}






