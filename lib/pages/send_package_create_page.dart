import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_and_travel/bloc/send_package/send_package_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/send_package_request.dart';
import 'package:tour_and_travel/widgets/custom_dropdown.dart';
import 'package:tour_and_travel/widgets/custom_text_field.dart';
import 'package:tour_and_travel/widgets/dotted_divider.dart';

class SendPackageCreatePage extends StatefulWidget {
  final SendPackageRequest request;
  const SendPackageCreatePage({super.key, required this.request});

  @override
  State<SendPackageCreatePage> createState() => _SendPackageCreatePageState();
}

class _SendPackageCreatePageState extends State<SendPackageCreatePage> {
  final packages = ['Dokumen', 'Makanan', 'Barang'];
  final isiPaketController = TextEditingController();

  final senderNameController = TextEditingController();
  final senderPhoneController = TextEditingController();

  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();

  @override
  void initState() {
    isiPaketController.text = packages.first;
    super.initState();
  }

  @override
  void dispose() {
    isiPaketController.dispose();
    senderNameController.dispose();
    senderPhoneController.dispose();
    receiverNameController.dispose();
    receiverPhoneController.dispose();
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
                      'Informasi Data Paket',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomDropdown<String>(
                  value: packages.first,
                  items: packages,
                  label: 'Isi Paket',
                  itemLabel: (value) => value,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        isiPaketController.text = value;
                      });
                    }
                  },
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
                      'Informasi Data Pengirim',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: senderNameController,
                  label: 'Nama Pengirim',
                  hintText: 'Contoh: Yosrizal Fadli',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: senderPhoneController,
                  label: 'No Telepone',
                  hintText: 'Contoh: 081212345678',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
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
                      'Informasi Data Penerima',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: receiverNameController,
                  label: 'Nama Pengirim',
                  hintText: 'Contoh: Yosrizal Fadli',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: receiverPhoneController,
                  label: 'No Telepone',
                  hintText: 'Contoh: 081212345678',
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
        child: BlocConsumer<SendPackageBloc, SendPackageState>(
          listener: (context, state) {
            if (state is SendPackageFailed) {
              context.showDialogError(state.message);
            } else if (state is SendPackageSuccess) {
              context.popToRoot();
              context.showDialogSuccess('Berhasil dipesan.');
            }
          },
          builder: (context, state) {
            if (state is SendPackageLoading) {
              return const SizedBox(
                height: 50.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ElevatedButton(
              onPressed: () {
                if (isiPaketController.text.isEmpty ||
                    senderNameController.text.isEmpty ||
                    senderPhoneController.text.isEmpty ||
                    receiverNameController.text.isEmpty ||
                    receiverPhoneController.text.isEmpty) {
                  context.showDialogError("Field wajib diisi semua");
                  return;
                }
                context
                    .read<SendPackageBloc>()
                    .add(DoSendPackageEvent(widget.request.copyWith(
                      isi: isiPaketController.text,
                      pengirim: widget.request.pengirim.copyWith(
                        nama: senderNameController.text,
                        telp: senderPhoneController.text,
                      ),
                      penerima: widget.request.penerima.copyWith(
                        nama: receiverNameController.text,
                        telp: receiverPhoneController.text,
                      ),
                    )));
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
            );
          },
        ),
      ),
    );
  }
}
