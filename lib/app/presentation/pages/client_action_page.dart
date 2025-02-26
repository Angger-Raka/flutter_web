import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/presentation/presentation.dart';

import '../../data/data.dart';

class ClientActionPage extends StatefulWidget {
  const ClientActionPage({
    super.key,
    this.client,
  });

  final Client? client;

  @override
  State<ClientActionPage> createState() => _ClientActionPageState();
}

class _ClientActionPageState extends State<ClientActionPage> {
  bool isEdit = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nameController.text = widget.client!.name ?? '';
      _addressController.text = widget.client!.address ?? '';
      _phoneController.text = widget.client!.phone ?? '';
      _emailController.text = widget.client!.email ?? '';
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state is ClientSuccess) {
          final selection = context.read<SelectionBloc>().state;
          context.read<ListClientBloc>().add(
                GetAllClient(
                  selection is SelectionOffset,
                ),
              );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.client == null ? 'Add Client' : 'Edit Client'),
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
                8.sbh(),
                CustomTextField.label(
                  controller: _addressController,
                  text: 'Alamat',
                  hintText: 'Alamat',
                ),
                8.sbh(),
                CustomTextField.label(
                  controller: _phoneController,
                  text: 'No. Telp',
                  hintText: 'No. Telp',
                ),
                8.sbh(),
                CustomTextField.label(
                  controller: _emailController,
                  text: 'Email',
                  hintText: 'Email',
                ),
                16.sbh(),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isEdit) {
                        final client = Client(
                          name: _nameController.text,
                          address: _addressController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                        );
                        final selection = context.read<SelectionBloc>().state;

                        context.read<ClientBloc>().add(
                              AddClient(
                                client: client,
                                isOffset: selection is SelectionOffset,
                              ),
                            );
                      } else {
                        final client = widget.client!.copyWith(
                          name: _nameController.text,
                          address: _addressController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                        );
                        // final selection = context.read<SelectionBloc>().state;

                        context.read<ClientBloc>().add(
                              UpdateClient(
                                client: client,
                                // isOffset: selection is SelectionOffset,
                              ),
                            );
                      }
                    },
                    child: Text('Submit'),
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
