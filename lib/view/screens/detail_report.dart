import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controller/milkPurchaseController.dart';

class DetailReportScreen extends StatefulWidget {
  const DetailReportScreen({Key? key}) : super(key: key);

  @override
  State<DetailReportScreen> createState() => _DetailReportScreenState();
}

double totalAmnt = 0.0;
double fatRate = 0.0;


List<MilkPurchaseDet> employees = <MilkPurchaseDet>[];
late MilkPurchaseDataSource milkPurchaseDataSource;






class _DetailReportScreenState extends State<DetailReportScreen> {

  var myFormat = DateFormat('d-MM-yyyy');
  late List<MilkPurchaseModel> weekList;

  double sunQty = 0;
  double monQty = 0;
  double tueQty = 0;
  double wedQty = 0;
  double thuQty = 0;
  double friQty = 0;
  double satQty = 0;

  List<_MilPurchaseData> weekdata = [];


  List<MilkPurchaseDet> WeekDataSource = [];
  //   return [
  //     MilkPurchaseDet("10001", 'James', 'Project Lead', 20000),
  //     MilkPurchaseDet("10002", 'Kathryn', 'Manager', 30000),
  //     MilkPurchaseDet("10003", 'Lara', 'Developer', 15000),
  //     MilkPurchaseDet("10004", 'Michael', 'Designer', 15000),
  //     MilkPurchaseDet("10005", 'Martin', 'Developer', 15000),
  //     MilkPurchaseDet("10006", 'Newberry', 'Developer', 15000),
  //     MilkPurchaseDet("10007", 'Balnc', 'Developer', 15000),
  //     MilkPurchaseDet("10008", 'Perry', 'Developer', 15000),
  //     MilkPurchaseDet("10009", 'Gable', 'Developer', 15000),
  //     MilkPurchaseDet("10010", 'Grimes', 'Developer', 15000)
  //   ];
  // }


  GetWeekData() async{
    await MilkPurchaseController.allMilkPurchaseByThisWeek().then((result_list){
      setState(() {
        weekList = result_list;
        result_list.forEach((MilkPurchased) {
          int weekDayNum = MilkPurchased.Date.toDate().weekday;
          if(weekDayNum == 1){
            monQty += MilkPurchased.milkQty;
          }else if(weekDayNum == 2){
            tueQty += MilkPurchased.milkQty;
          }else if(weekDayNum == 3){
            wedQty += MilkPurchased.milkQty;
          }else if(weekDayNum == 4){
            thuQty += MilkPurchased.milkQty;
          }else if(weekDayNum == 5){
            friQty += MilkPurchased.milkQty;
          }else if(weekDayNum == 6){
            satQty += MilkPurchased.milkQty;
          }else{
            sunQty += MilkPurchased.milkQty;
          }
        });



        weekdata = [

          _MilPurchaseData('Mon', monQty),
          _MilPurchaseData('Tues', tueQty),
          _MilPurchaseData('Wed', wedQty),
          _MilPurchaseData('Thu', thuQty),
          _MilPurchaseData('Fri', friQty),
          _MilPurchaseData('Sat', satQty),
          _MilPurchaseData('Sun', sunQty),
        ];

        result_list.forEach((element) {
          WeekDataSource.add(MilkPurchaseDet( myFormat.format(element.Date.toDate()), element.SupplierName, element.shift, element.milkQty));
        });



        milkPurchaseDataSource = MilkPurchaseDataSource( milkPurchaseData: WeekDataSource);



      });
    });
  }






  @override
  void initState() {

    GetWeekData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detailed View'),
          backgroundColor: MyColors.primary,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'This Week',
              ),
              Tab(
                text: 'Month',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            matter(data: weekdata , dataSource: milkPurchaseDataSource),
            // matter(data: monthdata),
          ],
        ),
      ),
    );
  }

  Widget matter({
    required List<_MilPurchaseData> data,
    required MilkPurchaseDataSource dataSource,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SfCartesianChart(
            enableMultiSelection: false,
            enableSideBySideSeriesPlacement: false,
            backgroundColor: MyColors.primary,
            plotAreaBorderColor: Colors.transparent,
            primaryYAxis: NumericAxis(
                isVisible: false,
                majorGridLines: const MajorGridLines(width: 0)),
            primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: const TextStyle(color: MyColors.white)),
            // Chart title

            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_MilPurchaseData, String>>[
              ColumnSeries<_MilPurchaseData, String>(
                  color: const Color.fromARGB(197, 252, 252, 252),
                  trackBorderWidth: 0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  dataSource: data,
                  xValueMapper: (_MilPurchaseData sales, _) => sales.day,
                  yValueMapper: (_MilPurchaseData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        SfDataGrid(
          selectionMode: SelectionMode.single,
          onCellTap: (details) {},
          onSelectionChanged: (addedRows, removedRows) {
            print(addedRows.length);
            print(removedRows);
          },
          source: dataSource,
          columnWidthMode: ColumnWidthMode.fill,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'Date',
                label: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Date',
                    ))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'Shift',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Shift',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'Quantity',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Quantity'))),
          ],
        ),
      ],
    );
  }
}


List<_MilPurchaseData> monthdata = [
  _MilPurchaseData('01', 35),
  _MilPurchaseData('02', 28),
  _MilPurchaseData('03', 34),
  _MilPurchaseData('04', 32),
  _MilPurchaseData('05', 40),
  _MilPurchaseData('06', 40),
  _MilPurchaseData('07', 80),
  _MilPurchaseData('08', 80),
  _MilPurchaseData('09', 80),
  _MilPurchaseData('10', 80),
  _MilPurchaseData('11', 35),
  _MilPurchaseData('12', 28),
  _MilPurchaseData('13', 34),
  _MilPurchaseData('14', 32),
  _MilPurchaseData('15', 40),
  _MilPurchaseData('16', 40),
  _MilPurchaseData('17', 80),
  _MilPurchaseData('18', 80),
  _MilPurchaseData('19', 80),
  _MilPurchaseData('20', 80),
  _MilPurchaseData('21', 35),
  _MilPurchaseData('22', 28),
  _MilPurchaseData('23', 34),
  _MilPurchaseData('24', 32),
  _MilPurchaseData('25', 40),
  _MilPurchaseData('26', 40),
  _MilPurchaseData('27', 80),
  _MilPurchaseData('28', 80),
  _MilPurchaseData('29', 80),
  _MilPurchaseData('30', 80),
];


class _MilPurchaseData {
  _MilPurchaseData(this.day, this.sales);

  final String day;
  final double sales;
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class MilkPurchaseDet {
  /// Creates the employee class with required details.
  MilkPurchaseDet(this.Date, this.name, this.shift, this.qty);

  /// Id of an employee.
  final String Date;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String shift;

  /// Salary of an employee.
  final double qty;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class MilkPurchaseDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  MilkPurchaseDataSource({required List<MilkPurchaseDet> milkPurchaseData}) {
    _milkPurchaseData = milkPurchaseData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Date', value: e.Date),
      DataGridCell<String>(columnName: 'Name', value: e.name),
      DataGridCell<String>(columnName: 'Shift', value: e.shift),
      DataGridCell<double>(columnName: 'Quantity', value: e.qty),
      // DataGridCell<int>(columnName: 'Fat', value: e.salary),
    ]))
        .toList();
  }

  List<DataGridRow> _milkPurchaseData = [];

  @override
  List<DataGridRow> get rows => _milkPurchaseData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}