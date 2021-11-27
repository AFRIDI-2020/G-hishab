import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamworl_it_income_expenditure/controllers/sqlite_database_helper.dart';
import 'package:glamworl_it_income_expenditure/screens/home.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _count = 0;
  Future <void> _customInit(DatabaseHelper databaseHelper) async {
    _count++;
    await databaseHelper.getIncomeExpenseList();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500)).then((value){
      Get.offAll(() => Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper databaseHelper = Get.put(DatabaseHelper());
    final Size size = MediaQuery.of(context).size;
    if(_count == 0) _customInit(databaseHelper);
    return SafeArea(
      child: Scaffold(
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(Size size) => Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/income_expense_logo.png',
                  height: size.width * .4,
                  width: size.width * .4,
                ),
                SizedBox(
                  height: size.width * .01,
                ),
                RichText(
                    text:  TextSpan(
                        style: TextStyle(color: const Color(0xff57B5CE), fontSize: size.width*.1, fontWeight: FontWeight.bold),
                        children: const [
                      TextSpan(
                          text: 'G-',
                          style: TextStyle(color: Color(0xff2DA4D0))),
                      TextSpan(
                        text: 'হিসাব',
                      ),
                    ])),
              ],
            ),
            Positioned(
              bottom: 5,
              child: Column(
                children: [
                  Text(
                    'Developed by',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width*.035
                    ),
                  ),
                  Image.asset('assets/company_banner.png', height: size.width*.2, width: size.width*.6,)
                ],
              ),
            )
          ],
        ),
      );
}
