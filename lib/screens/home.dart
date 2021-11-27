import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamworl_it_income_expenditure/controllers/sqlite_database_helper.dart';
import 'package:glamworl_it_income_expenditure/screens/expense_page.dart';
import 'package:glamworl_it_income_expenditure/screens/income_page.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Color> colorList = const [
    Color(0xff00D099),
    Color(0xffDBB049),
  ];

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper databaseHelper = Get.find();
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: _bodyUI(size, databaseHelper)),
    );
  }

  Container _bodyUI(Size size, DatabaseHelper databaseHelper) => Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: size.width * .25,
              child: SizedBox(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: const Color(0xff57B5CE),
                                fontSize: size.width * .1,
                                fontWeight: FontWeight.bold),
                            children: const [
                          TextSpan(
                              text: 'G- ',
                              style: TextStyle(color: Color(0xff2DA4D0))),
                          TextSpan(
                            text: 'হিসাব',
                          ),
                        ])),
                    SizedBox(
                      height: size.width * .1,
                    ),
                    PieChart(
                      dataMap: {
                        "আয়": databaseHelper.totalIncome.value,
                        "ব্যয়": databaseHelper.totalExpense.value,
                      },
                      animationDuration: const Duration(milliseconds: 3000),
                      chartLegendSpacing: 35,
                      chartRadius: size.width * .4,
                      colorList: colorList,
                      initialAngleInDegree: 1,
                      chartType: ChartType.ring,
                      ringStrokeWidth: size.width * .05,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendShape: BoxShape.rectangle,
                        legendTextStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        chartValueStyle: TextStyle(
                            color: Colors.black, fontSize: size.width * .03),
                        showChartValueBackground: false,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 0,
                      ),
                    ),
                    SizedBox(
                      height: size.width * .1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'মোট আয়',
                                style: TextStyle(
                                    color: const Color(0xff00D099),
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * .045),
                              ),
                              SizedBox(
                                height: size.width * .03,
                              ),
                              Text(
                                databaseHelper.totalIncomeString.value,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * .07),
                              ),
                              SizedBox(
                                height: size.width * .03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const IncomePage());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xff6a93cb),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * .03,
                                      vertical: size.width * .02),
                                  child: Text(
                                    'আয় যোগ করুন',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * .04),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'মোট ব্যয়',
                                style: TextStyle(
                                    color: const Color(0xffDBB049),
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * .045),
                              ),
                              SizedBox(
                                height: size.width * .03,
                              ),
                              Text(
                                databaseHelper.totalExpenseString.value,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * .07),
                              ),
                              SizedBox(
                                height: size.width * .03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ExpensePage());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xff6a93cb),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * .03,
                                      vertical: size.width * .02),
                                  child: Text(
                                    'ব্যয় যোগ করুন',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * .04),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * .1,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * .045),
                            children: [
                          TextSpan(
                              text: '${databaseHelper.remainingTitle.value}: ',
                              ),
                              TextSpan(
                                  text: '${databaseHelper.balanceString.value} টাকা',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )
                              )
                        ])),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              child: Column(
                children: [
                  Text(
                    'Developed by',
                    style: TextStyle(
                        color: Colors.black, fontSize: size.width * .035),
                  ),
                  Image.asset(
                    'assets/company_banner.png',
                    height: size.width * .2,
                    width: size.width * .6,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
