import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/constants/named_routes.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/pages/clients_screen.dart';
import 'package:go_router/go_router.dart';

class CardClient extends StatelessWidget {
  const CardClient({
    this.client,
    super.key,
  });

  final Client? client;

  void showDeleteDialog(
    BuildContext context,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Hapus Akun',
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus akun Anda? Aksi ini tidak dapat dibatalkan.',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                context.pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                // Tambahkan logika penghapusan akun di sini
                context.read<ClientBloc>().add(
                      DeleteClient(id),
                    );
                context.pop(); // Menutup dialog setelah menghapus
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client!.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.sbh(),
                      Text(
                        client!.phone ?? 'No Phone',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      8.sbh(),
                      Text(
                        client!.email ?? 'No Email',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      8.sbh(),
                      Text(
                        client!.address ?? 'No Address',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                12.sbw(),
                IconButton(
                  onPressed: () {
                    context.push(NamedRoutes.clientEdit, extra: client);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
                12.sbw(),
                IconButton(
                  onPressed: () {
                    showDeleteDialog(
                      context,
                      client!.id.toString(),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                8.sbw(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
