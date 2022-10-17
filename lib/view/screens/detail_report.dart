import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DetailReportScreen extends StatefulWidget {
  const DetailReportScreen({Key? key}) : super(key: key);

  @override
  State<DetailReportScreen> createState() => _DetailReportScreenState();
}

final _formKey = GlobalKey<FormState>();
final List<MilkSupplierModel> searchList = [];
const List<String> milktyplist = <String>['Cow', 'Buffalow'];
const List<String> shiftlist = <String>['Morning', 'Evening'];
String dropdownValue = milktyplist.first;
String dropdownValue1 = shiftlist.first;

TextEditingController suppNameEdCont = TextEditingController();
TextEditingController shiftEdCont = TextEditingController();
TextEditingController milkTypeEdCont = TextEditingController();
TextEditingController fatEdCont = TextEditingController();
TextEditingController snfEdCont = TextEditingController();
TextEditingController qtyEdCont = TextEditingController();

double totalAmnt = 0.0;
double fatRate = 0.0;
List<Employee> employees = <Employee>[];
late EmployeeDataSource employeeDataSource;

class _DetailReportScreenState extends State<DetailReportScreen> {
  @override
  void initState() {
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
    suppNameEdCont.addListener(() async {
      final String value = suppNameEdCont.value.text;
      searchList.clear();
      searchList.addAll(await milkSupplierController.fetchOneLedger(value));

      searchList.toSet().toList();

      // YOUR CODE
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Week',
              ),
              Tab(
                text: 'Month',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            matter(),
            matter(),
          ],
        ),
      ),
    );
  }

  Widget matter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        SfCartesianChart(
            enableMultiSelection: false,
            enableSideBySideSeriesPlacement: false,
            backgroundColor: MyColors.white,
            plotAreaBorderColor: Colors.transparent,
            primaryXAxis: CategoryAxis(),
            // Chart title

            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              ColumnSeries<_SalesData, String>(
                  color: MyColors.primary,
                  trackBorderWidth: 0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        SfDataGrid(
          source: employeeDataSource,
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

List<_SalesData> data = [
  _SalesData('Sunday', 35),
  _SalesData('Monday', 28),
  _SalesData('Tuesday', 34),
  _SalesData('Wednesday', 32),
  _SalesData('Thursday', 40),
  _SalesData('Frieday', 40),
  _SalesData('Saturday', 80),
];
List<Employee> getEmployeeData() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 15000),
    Employee(10005, 'Martin', 'Developer', 15000),
    Employee(10006, 'Newberry', 'Developer', 15000),
    Employee(10007, 'Balnc', 'Developer', 15000),
    Employee(10008, 'Perry', 'Developer', 15000),
    Employee(10009, 'Gable', 'Developer', 15000),
    Employee(10010, 'Grimes', 'Developer', 15000)
  ];
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'Date', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Shift', value: e.designation),
              DataGridCell<int>(columnName: 'Quantity', value: e.salary),
              // DataGridCell<int>(columnName: 'Fat', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

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
