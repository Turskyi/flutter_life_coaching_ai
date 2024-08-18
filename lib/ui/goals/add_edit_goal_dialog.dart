import 'package:flutter/material.dart';
import 'package:lifecoach/models/goal.dart';

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
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      if (widget.goal != null) {
        //TODO:
        // await DBService().updateGoal(
        //   widget.goal!.id,
        //   _titleController.text,
        //   _contentController.text,
        // );
      } else {
        //TODO:
        // await DBService().createGoal(
        //   _titleController.text,
        //   _contentController.text,
        // );
      }
      Navigator.of(context).pop(true);
    } catch (error, stackTrace) {
      debugPrint(
        'Error in $runtimeType in `_onSubmit`: $error.\n'
        'Stacktrace: $stackTrace',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _deleteGoal() async {
    if (widget.goal == null) return;

    setState(() {
      _deleteInProgress = true;
    });

    try {
      //TODO: await DBService().deleteGoal(widget.goal!.id);
      Navigator.of(context).pop(true);
    } catch (error, stackTrace) {
      debugPrint(
        'Error in $runtimeType in `_deleteGoal`: $error.\n'
        'Stacktrace: $stackTrace',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        _deleteInProgress = false;
      });
    }
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _onSubmit,
          child: _isSubmitting
              ? const CircularProgressIndicator()
              : const Text('Submit'),
        ),
      ],
    );
  }
}
