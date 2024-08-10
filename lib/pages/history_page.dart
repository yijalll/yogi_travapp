import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_and_travel/bloc/transaction/transaction_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/pages/history_detail_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pemesanan'),
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          // if (state is TransactionFailed) {
          //   context.showDialogError(state.message);
          // }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TransactionSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.data.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = state.data[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy', 'id_ID')
                          .format(item.createdAt!),
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListTile(
                      onTap: () => context.push(HistoryDetailPage(item: item)),
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
                      // subtitle: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(item.jurusan!.nama!),
                      //     const Text('-'),
                      //     Row(
                      //       children: [
                      //         const Icon(
                      //           Icons.check_circle,
                      //           color: AppColors.green,
                      //           size: 18.0,
                      //         ),
                      //         const SizedBox(width: 8.0),
                      //         Text(
                      //           item.paidStatus,
                      //           style: const TextStyle(
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // trailing: Text(
                      //   item.price.currencyFormatRp,
                      //   style: const TextStyle(
                      //     fontSize: 14.0,
                      //   ),
                      // ),
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            // child: IconButton(
            //   onPressed: () => context
            //       .read<TransactionBloc>()
            //       .add(const GetTransactionsEvent()),
            //   icon: const Icon(Icons.refresh),
            // ),
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
    );
  }
}
