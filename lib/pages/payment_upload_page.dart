import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_and_travel/bloc/transaction/transaction_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/ticket_response.dart';
import 'package:tour_and_travel/models/transaction_request.dart';

class PaymentUploadPage extends StatefulWidget {
  final Ticket item;
  final String name;
  final String gender;
  final String phoneNumber;
  final String address;
  final String contactDarurat;

  const PaymentUploadPage({
    super.key,
    required this.item,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.address,
    required this.contactDarurat,
  });

  @override
  State<PaymentUploadPage> createState() => _PaymentUploadPageState();
}

class _PaymentUploadPageState extends State<PaymentUploadPage> {
  XFile? _image;

  Future<void> _choosePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Upload Bukti Pembayaran'),
      ),
      body: InkWell(
        onTap: _choosePhoto,
        child: Center(
          child: _image == null
              ? Assets.icUpload.image(height: 100.0)
              : Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.gray)),
        ),
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionFailed) {
              context.showDialogError(state.message);
            } else if (state is TransactionSuccess) {
              context.popToRoot();
              context.showDialogSuccess('Berhasil dipesan.');
            }
          },
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const SizedBox(
                height: 50.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ElevatedButton(
              onPressed: _image == null
                  ? null
                  : () {
                      final request = TransactionRequest(
                        jurusanId: widget.item.id!,
                        nama: widget.name,
                        telp: widget.phoneNumber,
                        jk: widget.gender,
                        ispaid: 0,
                        alamat: widget.address,
                        kontakDarurat: widget.contactDarurat,
                        file: File(_image!.path),
                      );
                      context
                          .read<TransactionBloc>()
                          .add(CreateTransactionEvent(request));
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
                  'Selesai',
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
