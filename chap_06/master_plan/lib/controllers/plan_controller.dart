import 'package:master_plan/services/plan_services.dart';

import '../models/data_layer.dart';

class PlanController {
  //final _plans = <Plan>[];
  final services = PlanServices();

  List<Plan> get plans => List.unmodifiable(services.getAllPlans());

  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedCount = items.where((item) => item.contains(text)).length;
    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}';
    }
    return text;
  }

  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }

    name = _checkForDuplicates(plans.map((plan) => plan.name?? ''), name);
    services.createPlan(name);
  }

  void deletePlan(Plan plan) {
    services.delete(plan);
  }

  void savePlan(Plan plan) {
    services.savePlan(plan);
  }

  void createNewTask(Plan plan, [String? description]) {
    if (description == null || description.isEmpty) {
      description = 'New Task';
    }
    description = _checkForDuplicates(plan.tasks.map((task) => task.description), description);

    services.addTask(plan, description);
  }

  void deleteTask(Plan plan, Task task) {
    services.deleteTask(plan, task);
  }
}