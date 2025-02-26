import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/components/components.dart';

class PrintActionScreen extends StatefulWidget {
  const PrintActionScreen({
    this.printer,
    super.key,
  });

  final Printer? printer;

  @override
  State<PrintActionScreen> createState() => _PrintActionScreenState();
}

class _PrintActionScreenState extends State<PrintActionScreen> {
  bool isEdit = false;
  bool isOffset = false;

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final selection = context.read<SelectionBloc>().state;
    if (selection is SelectionOffset) {
      isOffset = true;
    }
    if (widget.printer != null) {
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrinterBloc, PrinterState>(
      listener: (context, state) {
        if (state is PrinterSuccess) {
          Navigator.pop(context);
        } else if (state is PrinterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEdit ? 'Edit Printer' : 'Add Printer',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                CustomTextField.label(
                  controller: _nameController,
                  text: 'Nama',
                  hintText: 'Nama',
                ),
                16.sbh(),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isEdit) {
                        context.read<PrinterBloc>().add(
                              AddPrinter(
                                Printer(
                                  name: _nameController.text,
                                ),
                                isOffset: isOffset,
                              ),
                            );
                        context
                            .read<ListPrinterBloc>()
                            .add(GetAllPrinter(isOffset));
                      } else {
                        // Edit Printer
                        context.read<PrinterBloc>().add(
                              UpdatePrinter(
                                Printer(
                                  id: widget.printer!.id,
                                  name: _nameController.text,
                                ),
                              ),
                            );
                        context
                            .read<ListPrinterBloc>()
                            .add(GetAllPrinter(isOffset));
                      }
                    },
                    child: Text(
                      'Submit',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
