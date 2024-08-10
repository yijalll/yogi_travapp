import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_and_travel/bloc/get_tickets/get_tickets_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/core/num_ext.dart';
import 'package:tour_and_travel/pages/create_order_page.dart';

class TicketListPage extends StatelessWidget {
  const TicketListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetTicketsBloc>().add(const DoGetTicketsEvent());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Daftar Tiket'),
      ),
      body: ListView(
        children: [
          ListTile(
            tileColor: AppColors.white,
            title: const Text('Tanggal Hari Ini'),
            subtitle: Text(
              DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now()),
            ),
          ),
          const SizedBox(height: 8.0),
          BlocConsumer<GetTicketsBloc, GetTicketsState>(
            listener: (context, state) {
              if (state is GetTicketsFailed) {
                context.showDialogError(state.message);
              }
            },
            builder: (context, state) {
              if (state is GetTicketsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetTicketsSuccess) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.data.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 2.0),
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return ListTile(
                      onTap: () {
                        context.push(CreateOrderPage(
                          item: item,
                        ));
                      },
                      tileColor: AppColors.white,
                      leading: Assets.icBus.image(),
                      title: Text(item.mobil!.namaMobil!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jambi > ${item.kota!.namaKota!} '),
                          Text(item.jam!),
                        ],
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          text: item.harga!.currencyFormatRp,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColors.yellow,
                          ),
                          children: const [
                            TextSpan(
                              text: '/seat',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: IconButton(
                  onPressed: () => context
                      .read<GetTicketsBloc>()
                      .add(const DoGetTicketsEvent()),
                  icon: const Icon(Icons.refresh),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
