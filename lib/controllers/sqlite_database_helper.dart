import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamworl_it_income_expenditure/model/income_expense_model.dart';
import 'package:glamworl_it_income_expenditure/variables/language_convert.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper extends GetxController {
  RxList<IncomeExpenseModel> incomeList = RxList<IncomeExpenseModel>([]);
  RxList<IncomeExpenseModel> expenseList = <IncomeExpenseModel>[].obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;
  RxString totalIncomeString = '০.০'.obs;
  RxString totalExpenseString = '০.০'.obs;
  RxDouble balance = 0.0.obs;
  RxString balanceString = '০.০'.obs;
  RxString remainingTitle = 'অবশিষ্ট'.obs;

  static DatabaseHelper? _databaseHelper; // singleton DatabaseHelper
  static Database? _database; // singleton Database

  String incomeExpenseTable = 'incomeExpenseTable';
  String colId = 'id';
  String colEntryId = 'entryId';
  String colDate = 'date';
  String colAmount = 'amount';
  String colDescription = 'description';
  String colStatus = 'status';

  DatabaseHelper._createInstance(); //Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $incomeExpenseTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colEntryId TEXT, $colDate TEXT, $colAmount TEXT, $colDescription TEXT, $colStatus TEXT)');
  }

  Future<Database> initializeDatabase() async {
    //Get the directory path for both android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'favouriteBook.db';
    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return noteDatabase;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  ///Fetch Map list from DB
  Future<List<Map<String, dynamic>>> getIncomeExpenseMapList() async {
    Database db = await database;
    var result = await db.query(incomeExpenseTable, orderBy: '$colId DESC');
    return result;
  }

  ///Get the 'Map List' and convert it to 'Cart List
  Future<void> getIncomeExpenseList() async {
    incomeList.clear();
    expenseList.clear();
    totalIncome.value = 0;
    totalExpense.value = 0;
    var incomeExpenseMapList = await getIncomeExpenseMapList();
    int count = incomeExpenseMapList.length;
    for (int i = 0; i < count; i++) {
      String status = incomeExpenseMapList[i]['status'];
      if (status == 'income') {
        totalIncome.value =
            totalIncome.value + double.parse(incomeExpenseMapList[i]['amount']);
        incomeList
            .add(IncomeExpenseModel.fromMapObject(incomeExpenseMapList[i]));
        update();
      } else {
        totalExpense.value = totalExpense.value +
            double.parse(incomeExpenseMapList[i]['amount']);
        expenseList
            .add(IncomeExpenseModel.fromMapObject(incomeExpenseMapList[i]));
        update();
      }
      // ignore: avoid_print
      print(
          'status = ${incomeExpenseMapList[i]['status']} & amount = ${incomeExpenseMapList[i]['amount']}');
    }
    totalIncomeString.value =
        enToBnNumberConvert(totalIncome.value.toStringAsFixed(2));
    totalExpenseString.value =
        enToBnNumberConvert(totalExpense.value.toStringAsFixed(2));
    update();
    if (totalExpense.value > totalIncome.value) {
      remainingTitle.value = 'অতিরিক্ত ব্যয়';
      balance.value = totalExpense.value - totalIncome.value;
      print('balance = ${balance.value}');
      balanceString.value = enToBnNumberConvert(balance.value.toString());
      update();
    } else {
      remainingTitle.value = 'অবশিষ্ট';
      balance.value = totalIncome.value - totalExpense.value;
      print('balance = ${balance.value}');
      balanceString.value = enToBnNumberConvert(balance.value.toStringAsFixed(2));
      update();
    }
    update();
  }

  ///update operation
  Future<int> updateEntry(IncomeExpenseModel incomeExpenseModel) async {
    Database db = await database;
    var result = await db.update(incomeExpenseTable, incomeExpenseModel.toMap(),
        where: '$colEntryId = ?', whereArgs: [incomeExpenseModel.entryId]);
    await getIncomeExpenseList();
    update();
    return result;
  }

  ///Insert operation
  Future<int> insertIncomeExpense(IncomeExpenseModel incomeExpenseModel) async {
    Database db = await database;
    var result =
        await db.insert(incomeExpenseTable, incomeExpenseModel.toMap());
    await getIncomeExpenseList();
    update();
    return result;
  }

  ///Delete operation
  Future<int> deleteEntry(String entryId, String status, int index) async {
    print(status);
    Database db = await database;
    var result = await db.delete(incomeExpenseTable,
        where: '$colEntryId = ?', whereArgs: [entryId]);
    if(status == 'income'){
      incomeList.removeAt(index);
    }else{
      expenseList.removeAt(index);
    }
    update();
    await getIncomeExpenseList();
    update();
    return result;
  }
}
