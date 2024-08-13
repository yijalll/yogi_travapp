import 'package:flutter/material.dart'; // Import library untuk membuat aplikasi Flutter
import 'package:flutter_bloc/flutter_bloc.dart'; // Import library untuk menggunakan Flutter Bloc
import 'package:intl/intl.dart'; // Import library untuk mengatur format tanggal dan waktu
import 'package:tour_and_travel/bloc/get_tickets/get_tickets_bloc.dart'; // Import library untuk mengatur logika bisnis tiket
import 'package:tour_and_travel/core/assets.gen.dart'; // Import library untuk mengatur aset aplikasi
import 'package:tour_and_travel/core/build_context_ext.dart'; // Import library untuk memperluas konteks build
import 'package:tour_and_travel/core/colors.dart'; // Import library untuk mengatur warna aplikasi
import 'package:tour_and_travel/core/num_ext.dart'; // Import library untuk memperluas fungsi numerik
import 'package:tour_and_travel/pages/create_order_page.dart'; // Import library untuk halaman buat pesanan

class TicketListPage extends StatefulWidget {
  const TicketListPage({super.key});

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    context.read<GetTicketsBloc>().add(const DoGetTicketsEvent());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Daftar Tiket'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GetTicketsBloc>().add(const DoGetTicketsEvent());
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan tujuan',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            ListTile(
              tileColor:
                  AppColors.white, // Mengatur warna latar belakang list tile
              title: const Text('Tanggal Hari Ini'), // Mengatur judul list tile
              subtitle: Text(
                DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(
                    DateTime.now()), // Mengatur format tanggal dan waktu
              ),
            ),
            const SizedBox(height: 8.0), // Mengatur jarak antar widget
            BlocConsumer<GetTicketsBloc, GetTicketsState>(
              listener: (context, state) {
                // Menangani error jika terjadi kesalahan saat mendapatkan tiket
                if (state is GetTicketsFailed) {
                  context.showDialogError(state.message);
                }
              },
              builder: (context, state) {
                // Menampilkan loading indicator jika sedang mengambil data
                if (state is GetTicketsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetTicketsSuccess) {
                  final filteredData = state.data
                      .where((item) => item.kota!.namaKota!
                          .toLowerCase()
                          .contains(_searchQuery))
                      .toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredData.length,
                    separatorBuilder: (context, index) => const SizedBox(
                        height: 2.0), // Mengatur jarak antar item
                    itemBuilder: (context, index) {
                      final item = filteredData[index];
                      return ListTile(
                        onTap: () {
                          // Menavigasi ke halaman buat pesanan ketika item diklik
                          context.push(CreateOrderPage(
                            item: item,
                          ));
                        },
                        tileColor: AppColors
                            .white, // Mengatur warna latar belakang list tile
                        leading: Assets.icBus.image(), // Mengatur gambar bus
                        title: Text(
                            item.mobil!.namaMobil!), // Mengatur judul mobil
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Jambi > ${item.kota!.namaKota!} '), // Mengatur rute
                            Text(DateFormat('dd MMMM yyyy', 'id_ID').format(item
                                .tanggal!)), // Mengatur tanggal keberangkatan
                            Text(
                                'Jam Keberangkatan > ${item.jam!}'), // Mengatur jam keberangkatan
                          ],
                        ),
                        trailing: RichText(
                          text: TextSpan(
                            text: item.harga!
                                .currencyFormatRp, // Mengatur format harga
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColors.yellow,
                            ),
                            children: const [
                              TextSpan(
                                text: '/seat', // Mengatur satuan harga
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
                // Menampilkan tombol refresh jika tidak ada data atau terjadi error
                return Center(
                  child: IconButton(
                    onPressed: () => context.read<GetTicketsBloc>().add(
                        const DoGetTicketsEvent()), // Menambahkan event untuk mendapatkan tiket
                    icon: const Icon(Icons.refresh), // Mengatur icon refresh
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
