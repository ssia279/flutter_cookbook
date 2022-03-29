import 'package:flutter/material.dart';
import 'package:master_plan/plan_provider.dart';
import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({Key? key, required this.plan}) : super(key: key);

  @override
  _PlanScreenState createState() {
    return _PlanScreenState();
  }

}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  Plan get plan => widget.plan;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final controller = PlanProvider.of(context);
        controller?.savePlan(plan);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Master Plan')),
        body: Column(
          children: [
            Expanded(child: _buildList()),
            SafeArea(child: Text(plan.completenessMessage)),
          ],
        ),
        floatingActionButton: _buildAddTaskButton(),
      ),
    );
  }

  @override
  void displose() {
    scrollController.dispose();
    super.dispose();
  }


  Widget _buildAddTaskButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final controller = PlanProvider.of(context);
          controller?.createNewTask(plan);
          setState(() {
          });
        });
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: plan.tasks.length,
        itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index])
    );
  }

  Widget _buildTaskTile(Task task) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(color: Colors.red,),
      direction: DismissDirection.endToStart,
      onDismissed: (_){
        final controller = PlanProvider.of(context);
        controller?.deleteTask(plan, task);
        setState(() {

        });
      },
      child: ListTile(
        leading: Checkbox(
          value: task.isComplete,
          onChanged: (selected) {
            setState(() {
              task.isComplete = selected!;
            });
          },
        ),
        title: TextFormField(
          initialValue: task.description,
          onFieldSubmitted: (text){
            setState(() {
              task.description = text;
            });
          },
        ),
      ),
    );
  }

}