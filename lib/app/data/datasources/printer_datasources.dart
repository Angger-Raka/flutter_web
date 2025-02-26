import 'package:dio/dio.dart';
import 'package:flutter_web/app/data/data.dart';

class PrinterDatasources {
  final Dio dio;

  PrinterDatasources({required this.dio});

  Future<List<Printer>> getAllPrinter({
    bool isOffset = false,
  }) async {
    try {
      String addParam =
          "?populate=*&filters[jenis][\$eq]=${isOffset ? "Offset" : "POD"}";

      final result = await dio.get(
        '/prints$addParam',
      );

      if (result.statusCode == 200) {
        final List<Printer> printers = [];
        final data = result.data['data'] as List<dynamic>;
        for (var item in data) {
          final orders =
              item['attributes']['orders']['data'] as List<dynamic>? ?? [];

          printers.add(
            Printer(
              id: item['id'],
              name: item['attributes']['name'],
              orders: orders.map((e) {
                final attributes = e['attributes'];

                return Order(
                  id: e['id'],
                  tanggalMasuk: attributes['tanggal_masuk'],
                  tanggalSelesai: attributes['tanggal_selesai'],
                  judul: attributes['judul'],
                  // pengorder: attributes['client']['data']['attributes']['name'],
                  oplahSoftCover: attributes['oplah_soft_cover'],
                  oplahHardCover: attributes['oplah_hard_cover'],
                  oplahCoverLidah: attributes['oplah_cover_lidah'],
                  ukuran: attributes['ukuran'],
                  kertasCover: attributes['kertas_cover'],
                  kertasIsi: attributes['kertas_isi'],
                  cetakIsi: attributes['cetak_isi'],
                  cetakCover: attributes['cetak_cover'],
                  laminasiCover: attributes['laminasi_cover'],
                  finishingCover: attributes['finishing_cover'],
                  phoneNumber: attributes['phone_number'],
                  isActive: attributes['is_active'],
                );
              }).toList(),
            ),
          );
        }
        // for (var item in result.data['data']) {
        //   printers.add(
        //     Printer(
        //       id: item['id'],
        //       name: item['attributes']['name'],
        //     ),
        //   );
        // }
        return printers;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Printer?> getPrinterById({
    required String id,
  }) async {
    try {
      final result = await dio.get(
        '/prints/$id',
      );

      if (result.statusCode == 200) {
        final data = result.data['data'];
        return Printer(
          id: data['id'],
          name: data['attributes']['name'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> addPrinter({
    required Printer printer,
    bool isOffset = false,
  }) async {
    try {
      final result = await dio.post(
        '/prints',
        data: {
          "data": {
            "name": printer.name,
            "jenis": isOffset ? "Offset" : "POD",
          }
        },
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> updatePrinter({
    required Printer printer,
  }) async {
    try {
      final result = await dio.put(
        '/prints/${printer.id}',
        data: {
          "data": {
            "name": printer.name,
          }
        },
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePrinter({
    required String id,
  }) async {
    try {
      final result = await dio.delete(
        '/prints/$id',
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
