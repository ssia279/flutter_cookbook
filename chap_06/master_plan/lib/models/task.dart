import '../repos/repository.dart';

class Task {
  final int id;
  String description;
  bool isComplete;

  Task({
    required this.id,
    this.isComplete = false,
    this.description = '',
  });

  Task.fromModel(Model model) : id = model.id, description = model.data['description'], isComplete = model.data['isComplete'];

  Model toModel() => Model(id: id, data: {'description' : description, 'isComplete': isComplete});

}