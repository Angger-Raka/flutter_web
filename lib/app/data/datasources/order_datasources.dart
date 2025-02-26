import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web/app/data/models/models.dart';
import 'package:flutter_web/constant.dart';

class OrderDatasources {
  final Dio dio;

  OrderDatasources({required this.dio});

  Future<bool> updateOrder({
    required String id,
    required Order order,
    required int clientId,
  }) async {
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
            "phone_number": order.phoneNumber,
            "finishing_cover": order.finishingCover,
            "is_active": order.isActive,
            "client": clientId,
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

  Future<Order> getOrder({
    required String orderId,
    bool isOffset = false,
  }) async {
    try {
      return Order();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Order>> getAllOrder({
    bool isOffset = false,
  }) async {
    try {
      List<Order> orders = [];

      String additionalParams =
          '&filters[jenis][\$eq]=${isOffset ? 'Offset' : 'POD'}';

      print('additionalParams: $additionalParams');
      final result = await dio.get(
        '/orders?populate[client]=*&populate[processes][populate]=steps&sort=tanggal_selesai:asc$additionalParams',
      );

      if (result.statusCode == 200) {
        var listData = result.data['data'] as List<dynamic>;
        print('listData: $listData');
        for (var element in listData) {
          final attributes = element['attributes'];
          final processes = attributes['processes']['data'] as List<dynamic>;
          final client = attributes['client']['data'] as Map<String, dynamic>;

          var order = Order(
            id: element['id'],
            idClient: attributes['client']['data']['id'] as int?,
            tanggalMasuk: attributes['tanggal_masuk'],
            tanggalSelesai: attributes['tanggal_selesai'],
            judul: attributes['judul'],
            pengorder: attributes['client']['data']['attributes']['name'],
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
            processes: processes.map((element) {
              final attributes = element['attributes'];
              final steps = attributes['steps']['data'] as List<dynamic>;
              return Process(
                id: element['id'],
                namaProses: attributes['nama_proses'],
                statusProses: attributes['status_proses'],
                steps: steps.map((element) {
                  final attributes = element['attributes'];
                  return Stage(
                    id: element['id'],
                    namaStep: attributes['nama_step'],
                    statusStep: attributes['status_step'],
                  );
                }).toList(),
              );
            }).toList(),
            client: Client(
              id: client['id'],
              name: client['attributes']['name'],
              address: client['attributes']['address'],
              phone: client['attributes']['phone'],
            ),
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
