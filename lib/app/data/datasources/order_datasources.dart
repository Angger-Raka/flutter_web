import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web/app/data/models/models.dart';
import 'package:flutter_web/constant.dart';

class OrderDatasources {
  final Dio dio;

  OrderDatasources({required this.dio});

  Future<bool> updateOrder(
    String id,
    Order order,
  ) async {
    try {
      final result = await dio.put(
        '/orders/$id',
        data: {
          "data": {
            "tanggal_masuk": order.tanggalMasuk,
            "tanggal_selesai": order.tanggalSelesai,
            "pengorder": order.pengorder,
            "judul": order.judul,
            "oplah_soft_cover": order.oplahSoftCover,
            "oplah_hard_cover": order.oplahHardCover,
            "oplah_cover_lidah": order.oplahCoverLidah,
            "ukuran": order.ukuran,
            "kertas_isi": order.kertasIsi,
            "kertas_cover": order.kertasCover,
            "cetak_isi": order.cetakIsi,
            "cetak_cover": order.cetakCover,
            "laminasi_cover": order.laminasiCover,
            "finishing_cover": order.finishingCover,
          }
        },
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<List<Order>> getAllOrder() async {
    try {
      List<Order> orders = [];

      const additionalParams =
          '&filters[jenis][\$eq]=${isOffset ? 'Offset' : 'POD'}';

      final result = await dio.get(
        '/orders?populate[processes][populate]=steps&sort=tanggal_selesai:asc$additionalParams',
      );

      if (result.statusCode == 200) {
        var listData = result.data['data'] as List<dynamic>;
        for (var element in listData) {
          final attributes = element['attributes'];
          final processes = attributes['processes']['data'] as List<dynamic>;
          var order = Order(
            id: element['id'],
            tanggalMasuk: attributes['tanggal_masuk'],
            tanggalSelesai: attributes['tanggal_selesai'],
            judul: attributes['judul'],
            pengorder: attributes['pengorder'],
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
            processes: processes.map((element) {
              final attributes = element['attributes'];
              final steps = attributes['steps']['data'] as List<dynamic>;
              return Process(
                id: element['id'],
                namaProses: attributes['nama_proses'],
                statusProses: attributes['status_proses'],
                steps: steps.map((element) {
                  final attributes = element['attributes'];
                  return Step(
                    id: element['id'],
                    namaStep: attributes['nama_step'],
                    statusStep: attributes['status_step'],
                  );
                }).toList(),
              );
            }).toList(),
          );

          orders.add(order);
        }
        return orders;
      } else {
        throw Exception('Failed to get all order');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> deleteOrder(String id) async {
    try {
      final response = await dio.delete('/orders/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addOrder(
    RequestAddOrder requestAddOrder,
  ) async {
    try {
      print(
        'addOrder - requestAddOrder: ${requestAddOrder.toMap()}',
      );

      final result = await dio.post(
        '/orders',
        data: {
          "data": requestAddOrder.toMap(),
        },
      );

      print(
        'addOrder - statusCode: ${result.statusCode} - data: ${result.data}',
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
