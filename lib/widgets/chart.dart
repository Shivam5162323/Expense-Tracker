import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../main.dart';


String totalmoneyspent ='0';
class WeekdayBarChart extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('exp').doc(userid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // Loading indicator while data is being fetched
          }

          Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>;

          List expenses = data.values.toList(); // Assuming data is stored as a list

          Map<String, double> weekdayExpenses = {};

          // Calculate total sum of money spent
          // Calculate total sum of money spent
          // Calculate total sum of money spent
          double totalAmount = 0;
          expenses.forEach((expense) {
            totalAmount += expense['amount'];
          });

// Calculate the interval for each label
          double labelInterval = totalAmount / 7;

// Generate labels for y-axis
          List<String> yLabels = [];
          for (int i = 0; i <= 7; i++) {
            yLabels.add((i * labelInterval).toStringAsFixed(2));
          }

          print(totalAmount);


          // Map data to weekdays
          expenses.forEach((expense) {
            DateTime timestamp = expense['timestamp'].toDate();
            String weekday = DateFormat('EEEE').format(timestamp);

            if (weekdayExpenses.containsKey(weekday)) {
              weekdayExpenses[weekday] = (weekdayExpenses[weekday] ?? 0) + expense['amount'];
            } else {
              weekdayExpenses[weekday] = expense['amount'];
            }
          });

          List<BarChartGroupData> showingGroups = [];
          List<String> weekdaysfromtoday = [];

          for (int i = 0; i < 7; i++) {
            String weekday = DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 6 - i)));

            double amount = weekdayExpenses[weekday] ?? 0;
            // print(weekday);
            weekdaysfromtoday.add(weekday);

            showingGroups.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    color: Colors.blue, toY: amount, // You can customize the color here
                  ),
                ],





              ),
            );
          }
          print(weekdaysfromtoday);

          String keepFirstThreeWords(String inputString) {
            List<String> words = inputString.split(' ');
            if (words.length >= 3) {
              return '${words[0]} ${words[1]} ${words[2]}';
            } else {
              return inputString;
            }
          }

          return BarChart(

            BarChartData(
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
                  )
                ),
                rightTitles:AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: false
                    )
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    // reservedSize: MediaQuery.of(context).size.height*0.2,
                    // getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
                    getTitlesWidget: (double value,meta) {

                      int index = value.toInt();
                      if (index >= 0 && index < weekdaysfromtoday.length) {
                        return Text('${weekdaysfromtoday[index][0]}${weekdaysfromtoday[index][1]}${weekdaysfromtoday[index][2]}');
                      }
                      return Text('');
                    },
                    // margin: 16,
                    // reservedSize: 16,

                  )
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    // getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
                    getTitlesWidget: (value, meta) {
                      int index = totalAmount.toInt();
                      if (index >= 0 && index < yLabels.length) {
                        return Text(yLabels[index].toString());
                      }
                      return Text('');
                    },
                    // reservedSize: MediaQuery.of(context).size.height*0.03,
                    // margin: 12,
                  )
                ),
              ),
              borderData: FlBorderData(
                show: false,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              barGroups: showingGroups,
              gridData: FlGridData(show: true),
              // axisTitleData: FlAxisTitleData(show: false),
            ),
          );
        },
      ),
    );
  }
}
