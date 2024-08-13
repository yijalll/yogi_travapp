import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/core/num_ext.dart';
import 'package:tour_and_travel/models/ticket_response.dart';
import 'package:tour_and_travel/pages/payment_page.dart';
import 'package:tour_and_travel/services/auth_service.dart';
import 'package:tour_and_travel/widgets/custom_dropdown.dart';
import 'package:tour_and_travel/widgets/custom_text_field.dart';
import 'package:tour_and_travel/widgets/dotted_divider.dart';

class CreateOrderPage extends StatefulWidget {
  final Ticket item;
  const CreateOrderPage({super.key, required this.item});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final contactDaruratController = TextEditingController();

  final genders = ['Laki-Laki', 'Perempuan'];

  @override
  void initState() {
    super.initState();
    genderController.text = genders.first;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await AuthService().getUserFromLocal();
    if (user != null && user.data != null) {
      setState(() {
        nameController.text = user.data!.name ?? '';
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    contactDaruratController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
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
                      'Nama Kendaraan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.item.mobil!.namaMobil!,
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
                      'Jambi > ${widget.item.kota!.namaKota!}',
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
                      widget.item.harga!.currencyFormatRp,
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
                      DateFormat('dd MMMM yyyy', 'id_ID')
                          .format(widget.item.tanggal!),
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
                      widget.item.jam!,
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
          const SizedBox(height: 16.0),
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
                      'Informasi Penumpang',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: nameController,
                  label: 'Nama Penumpang',
                  hintText: 'Nama Lengkap',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                CustomDropdown<String>(
                  value: genders.first,
                  items: genders,
                  label: 'Jenis Kelamin',
                  itemLabel: (value) => value,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        genderController.text = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: phoneNumberController,
                  label: 'Nomor Telepone',
                  hintText: 'Contoh: 081212345678',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: addressController,
                  label: 'Alamat',
                  hintText: 'Masukkan alamat anda',
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: contactDaruratController,
                  label: 'Kontak Darurat (No Telepone)',
                  hintText: 'Masukkan nomor kontak darurat anda',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
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
            if (nameController.text.isEmpty ||
                genderController.text.isEmpty ||
                phoneNumberController.text.isEmpty ||
                addressController.text.isEmpty ||
                contactDaruratController.text.isEmpty) {
              context.showDialogError("Ada inputan yang masih kosong!");
              return;
            }
            context.push(PaymentPage(
              item: widget.item,
              name: nameController.text,
              gender: genderController.text,
              phoneNumber: phoneNumberController.text,
              address: addressController.text,
              contactDarurat: contactDaruratController.text,
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
              'Pesan Sekarang',
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
