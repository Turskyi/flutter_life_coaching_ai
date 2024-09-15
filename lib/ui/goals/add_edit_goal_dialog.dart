import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:models/models.dart';

class AddEditGoalDialog extends StatefulWidget {
  const AddEditGoalDialog({super.key, this.goal});

  final Goal? goal;

  @override
  State<AddEditGoalDialog> createState() => _AddEditGoalDialogState();
}

class _AddEditGoalDialogState extends State<AddEditGoalDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isSubmitting = false;
  bool _deleteInProgress = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.goal?.title ?? '');
    _contentController = TextEditingController(
      text: widget.goal?.content ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final FormState? formState = _formKey.currentState;
    if (formState != null && !formState.validate()) return;

    setState(() => _isSubmitting = true);
    final Goal? goal = widget.goal;

    if (goal != null) {
      context.read<GoalsBloc>().add(
            UpdateGoalEvent(
              goal.copyWith(
                title: _titleController.text,
                content: _contentController.text,
              ),
            ),
          );
    } else {
      context.read<GoalsBloc>().add(
            CreateGoalEvent(
              title: _titleController.text,
              content: _contentController.text,
            ),
          );
    }
    setState(() => _isSubmitting = false);
    Navigator.of(context).pop(true);
  }

  Future<void> _deleteGoal() async {
    final Goal? goal = widget.goal;
    if (goal == null) return;

    setState(() => _deleteInProgress = true);

    context.read<GoalsBloc>().add(DeleteGoalEvent(goal));
    setState(() => _deleteInProgress = false);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.goal == null ? 'Add Goal' : 'Edit Goal'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Goal title'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Goal content'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter content';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        if (widget.goal != null)
          TextButton(
            onPressed: _deleteInProgress ? null : _deleteGoal,
            child: _deleteInProgress
                ? const CircularProgressIndicator()
                : const Text(
                    'Delete goal',
                    style: TextStyle(color: Colors.red),
                  ),
          ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _titleController,
          child: const Text('Submit'),
          builder: (
            _,
            TextEditingValue titleValue,
            Widget? submitText,
          ) {
            const double progressIndicatorSize = 24.0;
            return ElevatedButton(
              onPressed:
                  (_isSubmitting || titleValue.text.isEmpty) ? null : _onSubmit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: progressIndicatorSize,
                      height: progressIndicatorSize,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    )
                  : submitText,
            );
          },
        ),
      ],
    );
  }
}
