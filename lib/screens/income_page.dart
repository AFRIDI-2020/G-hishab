import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamworl_it_income_expenditure/controllers/sqlite_database_helper.dart';
import 'package:glamworl_it_income_expenditure/custom_widgets/income_expense_detail_preview.dart';
import 'package:glamworl_it_income_expenditure/custom_widgets/text_form_builder.dart';
import 'package:glamworl_it_income_expenditure/model/income_expense_model.dart';
import 'package:glamworl_it_income_expenditure/variables/language_convert.dart';
import 'package:glamworl_it_income_expenditure/variables/save_pdf.dart';
import 'package:glamworl_it_income_expenditure/variables/toast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _updateDescriptionController =
      TextEditingController();
  final TextEditingController _updateAmountController = TextEditingController();

  Future<void> _onRefresh(DatabaseHelper databaseHelper) async {
    await Future.delayed(const Duration(milliseconds: 2000))
        .then((value) async {
      await databaseHelper.getIncomeExpenseList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper databaseHelper = Get.find();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6a93cb),
        centerTitle: true,
        title: const Text(
          'আয় বিবরণী',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await SavePdf().savePdf(databaseHelper.incomeList, databaseHelper.expenseList, databaseHelper.totalIncome.value, databaseHelper.totalExpense.value, databaseHelper.balance.value);
              },
              icon: const Icon(Icons.print))
        ],
      ),
      body: _bodyUI(size, databaseHelper),
    );
  }

  Widget _bodyUI(Size size, DatabaseHelper databaseHelper) => SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * .1),
                    topRight: Radius.circular(size.width * .1),
                  ),
                ),
                elevation: 2,
                color: Colors.white,
                child: Container(
                  width: size.width,
                  height: size.width * .4,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .04, vertical: size.width * .02),
                  child: Column(
                    children: [
                      TextFormBuilder(
                        hintText: 'আয়ের উৎস',
                        textEditingController: _descriptionController,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: size.width * .03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: TextFormBuilder(
                            hintText: 'টাকার পরিমাণ',
                            textEditingController: _amountController,
                            textInputType: TextInputType.text,
                          )),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(
                            'টাকা',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * .04),
                          ),
                          SizedBox(
                            width: size.width * .1,
                          ),
                          GestureDetector(
                            onTap: () {
                              addIncome();
                            },
                            child: Container(
                              padding: EdgeInsets.all(size.width * .03),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: size.width * .4,
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .03, vertical: size.width * .04),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Colors.grey.shade300,
                          padding: EdgeInsets.symmetric(
                              vertical: size.width * .02,
                              horizontal: size.width * .02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'তারিখ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * .04),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'বিবরণ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * .04),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'টাকার পরিমাণ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * .04),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => _onRefresh(databaseHelper),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: databaseHelper.incomeList.length,
                              itemBuilder: (context, index) {
                                DateTime miliDate = DateTime
                                    .fromMillisecondsSinceEpoch(int.parse(
                                        databaseHelper.incomeList[index].date));
                                var format = DateFormat("yMMMd").add_jm();
                                String finalDate = format.format(miliDate);
                                String amountInBn = enToBnNumberConvert(
                                    databaseHelper.incomeList[index].amount);
                                return GestureDetector(
                                  onLongPress: () {
                                    showUpdateDeleteDialog(
                                        size,
                                        databaseHelper,
                                        databaseHelper.incomeList[index],
                                        index);
                                  },
                                  child: IncomeExpenseDetailPreview(
                                    date: finalDate,
                                    description: databaseHelper
                                        .incomeList[index].description,
                                    amount: amountInBn,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .02,
                                  vertical: size.width * .02),
                              color: Colors.grey.shade300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'মোট আয় : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * .04),
                                  ),
                                  Text(
                                    '${databaseHelper.totalIncomeString.value} টাকা',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * .04),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  void addIncome() async {
    if (_descriptionController.text.isEmpty) {
      showToast('আয়ের উৎস লিখুন');
      return;
    }
    if (_amountController.text.isEmpty) {
      showToast('আয়ের পরিমাণ লিখুন');
      return;
    }
    String entryId = const Uuid().v4();
    String amount = bnToEnNumberConvert(_amountController.text);
    IncomeExpenseModel incomeExpenseModel = IncomeExpenseModel(
        entryId,
        DateTime.now().millisecondsSinceEpoch.toString(),
        amount,
        _descriptionController.text,
        'income');
    await DatabaseHelper()
        .insertIncomeExpense(incomeExpenseModel)
        .then((value) {
      setState(() {
        _descriptionController.clear();
        _amountController.clear();
      });
    });
  }

  void showUpdateDeleteDialog(Size size, DatabaseHelper databaseHelper,
      IncomeExpenseModel incomeExpenseModel, int index) {
    _updateDescriptionController.text =
        databaseHelper.incomeList[index].description;
    _updateAmountController.text = databaseHelper.incomeList[index].amount;

    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: context,
        builder: (ctx) => Container(
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .04, vertical: size.width * .03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'সংস্করণ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * .05,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: size.width * .02,
                ),
                TextFormBuilder(
                  hintText: 'বিবরণ',
                  textEditingController: _updateDescriptionController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: size.width * .03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextFormBuilder(
                      hintText: 'টাকার পরিমাণ',
                      textEditingController: _updateAmountController,
                      textInputType: TextInputType.number,
                    )),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    Text(
                      'টাকা',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * .04),
                    ),
                    SizedBox(
                      width: size.width * .1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String amount =
                            bnToEnNumberConvert(_updateAmountController.text);
                        await databaseHelper.updateEntry(IncomeExpenseModel(
                            databaseHelper.incomeList[index].entryId,
                            databaseHelper.incomeList[index].date,
                            amount,
                            _updateDescriptionController.text,
                            databaseHelper.incomeList[index].status));
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(size.width * .03),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * .1,
                ),
                Text(
                  'মুছে ফেলুন',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * .05,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: size.width * .02,
                ),
                Text(
                  'তালিকা থেকে এই ব্যয় হিসাবটি মুছে ফেলতে চান?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * .04,
                  ),
                ),
                SizedBox(
                  height: size.width * .03,
                ),
                GestureDetector(
                  onTap: () async {
                    print('deleting');
                    await databaseHelper
                        .deleteEntry(databaseHelper.incomeList[index].entryId,
                            databaseHelper.incomeList[index].status, index)
                        .then((value) {
                      Get.back();
                      databaseHelper.getIncomeExpenseList();
                    });
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
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .02,
                        vertical: size.width * .01),
                    child: Text(
                      'মুছে ফেলুন',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * .035),
                    ),
                  ),
                ),
              ],
            )));
  }
}
