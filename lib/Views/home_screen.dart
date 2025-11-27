import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/tab_model.dart';
import 'package:smart_school_system/Views/widgets/date_container.dart';
import 'package:smart_school_system/Views/widgets/lab.dart';
import 'package:smart_school_system/helpers/bottom_sheet_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController dateController;
  late TabController typeController;
  final List<String> dateTabs = ['16', '17', '18', '19', '20'];
  final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu'];
  final List<String> typeTabs = ['All', 'Lab', 'Class', 'P.E.'];

  @override
  void initState() {
    super.initState();
    dateController = TabController(length: dateTabs.length, vsync: this);
    typeController = TabController(length: typeTabs.length, vsync: this);

    dateController.addListener(_onFilterChanged);
    typeController.addListener(_onFilterChanged);
  }

  void _onFilterChanged() {
    if (!dateController.indexIsChanging && !typeController.indexIsChanging) {
      setState(() {});
    }
  }

  List<TabModel> get filteredItems {
    final selectedDate = dateTabs[dateController.index];
    final selectedType = typeTabs[typeController.index];

    return allItems.where((item) {
      final matchDate = item.date == selectedDate;
      final matchType = (selectedType == 'All')
          ? true
          : item.type == selectedType;
      return matchDate && matchType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.calendar_today_outlined, color: Colors.white),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 56, 110, 238),
        title: const Text(
          "Schedules",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showBottomChoiceSheet(
                context,
                "Are you sure you want to Logout?",
                Colors.red,
                Color.fromARGB(255, 56, 110, 238),
              );
              if (result == true) {
                await showBlockingSheet(context);
                Navigator.pushReplacementNamed(context, "/signin");
              }
            },
            icon: Icon(Icons.login_outlined, color: Colors.white, size: 25),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: const Color.fromARGB(255, 56, 110, 238),
              ),
              child: TabBar(
                controller: dateController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                dividerColor: Colors.transparent,
                labelColor: Color.fromARGB(255, 56, 110, 238),
                unselectedLabelColor: Colors.white,
                tabs: dateTabs.map((t) {
                  return SizedBox(
                    width: 70,
                    child: DateContainer(
                      day: days[dateTabs.indexOf(t)],
                      month: "Nov",
                      daynum: t,
                    ),
                  );
                }).toList(),
              ),
            ),
            Center(
              child: Container(
                height: 43,
                width: 270,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 56, 110, 238),
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Color.fromARGB(255, 56, 110, 238),
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Color.fromARGB(255, 56, 110, 238),
                      width: 2,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: TabBar(
                  controller: typeController,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 56, 110, 238),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabAlignment: TabAlignment.center,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color.fromARGB(255, 56, 110, 238),
                  tabs: typeTabs.map((t) {
                    return SizedBox(width: 60, child: Tab(text: t));
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: filteredItems.isEmpty
                    ? Center(
                        child: Text(
                          'No places for this selection',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredItems.length,
                        separatorBuilder: (_, _) => SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Lab(
                            item: item,
                            labname: item.place,
                            from: "${item.from} AM",
                            to: "${item.to} AM",
                            instructor: item.instructor,
                            classname: item.classname,
                            t: item,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
