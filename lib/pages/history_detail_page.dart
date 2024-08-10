import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/transaction_history_response.dart';
import 'package:tour_and_travel/widgets/dotted_divider.dart';

class HistoryDetailPage extends StatelessWidget {
  final TransactionHistory item;
  const HistoryDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
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
                      'Tujuan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.jurusan!.nama!,
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
                      'Nama Penumpang',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.user!.nama!,
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
                      'Nomor Telepone',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.user!.telp!,
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
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.user!.jk!,
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
                      'Alamat',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.user!.alamat!,
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
                      'Kontak Darurat',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.user!.kontakDarurat!,
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
                      'Tanggal Transaksi',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('dd MMMM yyyy', 'id_ID')
                          .format(item.createdAt!),
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
                      'Status Transaksi',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          item.paidStatusIcon,
                          color: item.paidStatusColor,
                          size: 18.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          item.paidStatus,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
