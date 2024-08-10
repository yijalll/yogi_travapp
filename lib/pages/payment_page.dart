import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/core/num_ext.dart';
import 'package:tour_and_travel/models/ticket_response.dart';
import 'package:tour_and_travel/pages/payment_upload_page.dart';
import 'package:tour_and_travel/widgets/dotted_divider.dart';

class PaymentPage extends StatelessWidget {
  final Ticket item;
  final String name;
  final String gender;
  final String phoneNumber;
  final String address;
  final String contactDarurat;

  const PaymentPage({
    super.key,
    required this.item,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.address,
    required this.contactDarurat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray),
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Assets.icTask.image(width: 24.0),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Detail Pesanan Anda',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text(
                      'Nama Kendaraan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.mobil!.namaMobil!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Text(
                      'Tujuan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Jambi > ${item.kota!.namaKota!}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Text(
                      'Harga',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.harga!.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Text(
                      'Tanggal Keberangakatan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('dd MMMM yyyy', 'id_ID').format(item.tanggal!),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Text(
                      'Jam Keberangakatan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.jam!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            tileColor: AppColors.white,
            leading: Assets.icPayment.image(),
            title: const Text('BRI'),
            subtitle: const Text('0020-01-015803-53-4'),
          ),
          const SizedBox(height: 2.0),
          ListTile(
            tileColor: AppColors.white,
            leading: Assets.icPayment.image(),
            title: const Text('BCA'),
            subtitle: const Text('787-112-1242'),
          ),
          const SizedBox(height: 2.0),
          ListTile(
            tileColor: AppColors.white,
            leading: Assets.icPayment.image(),
            title: const Text('BSI'),
            subtitle: const Text('712-508-6319'),
          ),
          const SizedBox(height: 2.0),
          ListTile(
            tileColor: AppColors.white,
            leading: Assets.icPayment.image(),
            title: const Text('DANA'),
            subtitle: const Text('0812-8685-9046'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.gray)),
        ),
        child: ElevatedButton(
          onPressed: () {
            context.push(PaymentUploadPage(
              item: item,
              name: name,
              gender: gender,
              phoneNumber: phoneNumber,
              address: address,
              contactDarurat: contactDarurat,
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Upload Bukti Pembayaran',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
