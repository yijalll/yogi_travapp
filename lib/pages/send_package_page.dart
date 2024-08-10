import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/district_response.dart';
import 'package:tour_and_travel/models/province_response.dart';
import 'package:tour_and_travel/models/regency_model.dart';
import 'package:tour_and_travel/models/send_package_request.dart';
import 'package:tour_and_travel/models/village_response.dart';
import 'package:tour_and_travel/pages/send_package_create_page.dart';
import 'package:tour_and_travel/services/open_api_service.dart';
import 'package:tour_and_travel/widgets/custom_dropdown.dart';
import 'package:tour_and_travel/widgets/custom_text_field.dart';
import 'package:tour_and_travel/widgets/dotted_divider.dart';

class SendPackagePage extends StatefulWidget {
  const SendPackagePage({super.key});

  @override
  State<SendPackagePage> createState() => _SendPackagePageState();
}

class _SendPackagePageState extends State<SendPackagePage> {
  final senderProvinsiController = TextEditingController();
  final senderKotaController = TextEditingController();
  final senderKecamatanController = TextEditingController();
  final senderKelurahanController = TextEditingController();
  final senderAlamatController = TextEditingController();

  final receiverProvinsiController = TextEditingController();
  final receiverKotaController = TextEditingController();
  final receiverKecamatanController = TextEditingController();
  final receiverKelurahanController = TextEditingController();
  final receiverAlamatController = TextEditingController();

  late final OpenApiService openApiService;

  final provinceInitial = ProvinceResponse(id: "0", name: "Pilih");
  final regencyInitial =
      RegencyResponse(id: "0", name: "Pilih", provinceId: "0");
  final districtInitial =
      DistrictResponse(id: "0", name: "Pilih", regencyId: "0");
  final villageInitial =
      VillageResponse(id: "0", name: "Pilih", districtId: "0");

  List<ProvinceResponse> senderProvinces = [];
  List<RegencyResponse> senderRegencies = [];
  List<DistrictResponse> senderDistricts = [];
  List<VillageResponse> senderVillages = [];

  List<ProvinceResponse> receiverProvinces = [];
  List<RegencyResponse> receiverRegencies = [];
  List<DistrictResponse> receiverDistricts = [];
  List<VillageResponse> receiverVillages = [];

  @override
  void initState() {
    senderProvinces = [provinceInitial];
    senderRegencies = [];
    senderDistricts = [];
    senderVillages = [];

    receiverProvinces = [provinceInitial];
    receiverRegencies = [];
    receiverDistricts = [];
    receiverVillages = [];

    openApiService = OpenApiService();
    super.initState();
    init();
  }

  void init() async {
    senderProvinces = await openApiService.getProvinces();
    receiverProvinces = await openApiService.getProvinces();
    setState(() {});
  }

  @override
  void dispose() {
    senderProvinsiController.dispose();
    senderKotaController.dispose();
    senderKecamatanController.dispose();
    senderKelurahanController.dispose();
    senderAlamatController.dispose();
    receiverProvinsiController.dispose();
    receiverKotaController.dispose();
    receiverKecamatanController.dispose();
    receiverKelurahanController.dispose();
    receiverAlamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pengaturan Alamat'),
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
                      'Alamat Pengirim',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomDropdown<ProvinceResponse>(
                  value: null,
                  items: senderProvinces,
                  label: 'Provinsi',
                  itemLabel: (value) => value.name,
                  onChanged: (value) async {
                    if (value != null) {
                      senderProvinsiController.text = value.name;
                      senderRegencies =
                          await openApiService.getRegencies(value.id);
                      senderProvinces = [value];
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                if (senderRegencies.isNotEmpty)
                  CustomDropdown<RegencyResponse>(
                    value: null,
                    items: senderRegencies,
                    label: 'Kota/Kabupaten',
                    itemLabel: (value) => value.name,
                    onChanged: (value) async {
                      if (value != null) {
                        senderKotaController.text = value.name;
                        senderDistricts =
                            await openApiService.getDistricts(value.id);
                        senderRegencies = [value];
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                if (senderDistricts.isNotEmpty)
                  CustomDropdown<DistrictResponse>(
                    value: null,
                    items: senderDistricts,
                    label: 'Kecamatan',
                    itemLabel: (value) => value.name,
                    onChanged: (value) async {
                      if (value != null) {
                        senderKecamatanController.text = value.name;
                        senderVillages =
                            await openApiService.getVillages(value.id);
                        senderDistricts = [value];
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                if (senderVillages.isNotEmpty)
                  CustomDropdown<VillageResponse>(
                    value: null,
                    items: senderVillages,
                    label: 'Kelurahan',
                    itemLabel: (value) => value.name,
                    onChanged: (value) async {
                      if (value != null) {
                        senderKelurahanController.text = value.name;
                        senderVillages = [value];
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                if (senderVillages.isNotEmpty)
                  CustomTextField(
                    controller: senderAlamatController,
                    label: 'Alamat',
                    hintText: 'Masukkan alamat anda',
                    maxLines: 5,
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
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
                      'Alamat Penerima',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomDropdown<ProvinceResponse>(
                  value: null,
                  items: receiverProvinces,
                  label: 'Provinsi',
                  itemLabel: (value) => value.name,
                  onChanged: (value) async {
                    if (value != null) {
                      receiverProvinsiController.text = value.name;
                      receiverRegencies =
                          await openApiService.getRegencies(value.id);
                      receiverProvinces = [value];
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                if (receiverRegencies.isNotEmpty)
                  CustomDropdown<RegencyResponse>(
                    value: null,
                    items: receiverRegencies,
                    label: 'Kota/Kabupaten',
                    itemLabel: (value) => value.name,
                    onChanged: (value) async {
                      if (value != null) {
                        receiverKotaController.text = value.name;
                        receiverDistricts =
                            await openApiService.getDistricts(value.id);
                        receiverRegencies = [value];
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                if (receiverDistricts.isNotEmpty)
                  CustomDropdown<DistrictResponse>(
                    value: null,
                    items: receiverDistricts,
                    label: 'Kecamatan',
                    itemLabel: (value) => value.name,
                    onChanged: (value) async {
                      if (value != null) {
                        receiverKecamatanController.text = value.name;
                        receiverVillages =
                            await openApiService.getVillages(value.id);
                        receiverDistricts = [value];
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                if (receiverVillages.isNotEmpty)
                  CustomDropdown<VillageResponse>(
                    value: null,
                    items: receiverVillages,
                    label: 'Kelurahan',
                    itemLabel: (value) => value.name,
                    onChanged: (value) async {
                      if (value != null) {
                        receiverKelurahanController.text = value.name;
                        receiverVillages = [value];
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                if (receiverVillages.isNotEmpty)
                  CustomTextField(
                    controller: receiverAlamatController,
                    label: 'Alamat',
                    hintText: 'Masukkan alamat anda',
                    maxLines: 5,
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
            if (senderProvinsiController.text.isEmpty ||
                senderKotaController.text.isEmpty ||
                senderKecamatanController.text.isEmpty ||
                senderKelurahanController.text.isEmpty ||
                senderAlamatController.text.isEmpty ||
                receiverProvinsiController.text.isEmpty ||
                receiverKotaController.text.isEmpty ||
                receiverKecamatanController.text.isEmpty ||
                receiverKelurahanController.text.isEmpty ||
                receiverAlamatController.text.isEmpty) {
              context.showDialogError("Field wajib diisi semua");
              return;
            }
            final request = SendPackageRequest(
              isi: "NULL",
              pengirim: Pen(
                nama: "NULL",
                telp: "NULL",
                alamat: senderAlamatController.text,
                provinsi: senderProvinsiController.text,
                kotaKab: senderKotaController.text,
                kecamatan: senderKecamatanController.text,
                kelurahan: senderKelurahanController.text,
              ),
              penerima: Pen(
                nama: "NULL",
                telp: "NULL",
                alamat: receiverAlamatController.text,
                provinsi: receiverProvinsiController.text,
                kotaKab: receiverKotaController.text,
                kecamatan: receiverKecamatanController.text,
                kelurahan: receiverKelurahanController.text,
              ),
            );
            context.push(SendPackageCreatePage(request: request));
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
              'Lanjutkan',
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
