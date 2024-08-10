import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_and_travel/bloc/transaction/transaction_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/pages/history_detail_page.dart';

class HistoryPage extends StatelessWidget {
  // Konstruktor untuk HistoryPage
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengembalikan Scaffold yang berisi appBar dan body
    return Scaffold(
      appBar: AppBar(
        // Mengatur judul appBar
        title: const Text('Riwayat Pemesanan'),
      ),
      body: RefreshIndicator(
        // Fungsi untuk meng-refresh data ketika user menggesek ke bawah
        onRefresh: () async {
          // Menambahkan event untuk mengambil data transaksi ketika di-refresh
          context.read<TransactionBloc>().add(const GetTransactionsEvent());
        },
        child: BlocConsumer<TransactionBloc, TransactionState>(
          // Mengkonsumsi state dan event dari TransactionBloc
          listener: (context, state) {
            // Menangani error jika terjadi kesalahan saat mengambil data transaksi
            // if (state is TransactionFailed) {
            //   context.showDialogError(state.message);
            // }
          },
          builder: (context, state) {
            // Menampilkan loading indicator jika sedang mengambil data
            if (state is TransactionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TransactionSuccess) {
              // Menampilkan daftar transaksi jika data berhasil diambil
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.data.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = state.data[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menampilkan tanggal transaksi
                      Text(
                        DateFormat('dd MMMM yyyy', 'id_ID')
                            .format(item.createdAt!),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Menampilkan detail transaksi
                      ListTile(
                        onTap: () =>
                            context.push(HistoryDetailPage(item: item)),
                        leading: Assets.pesanTiketCircle.image(),
                        title: Text(
                          item.jurusan!.nama!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Row(
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
                      ),
                    ],
                  );
                },
              );
            }
            // Menampilkan pesan jika tidak ada data transaksi
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.empty.image(width: 150.0),
                  const SizedBox(height: 20.0),
                  const Text('Riwayat pemesanan kosong..'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
