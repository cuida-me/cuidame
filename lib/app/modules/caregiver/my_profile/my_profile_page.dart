import 'package:cuidame/app/configs/constants/spacements.dart';
import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/modules/caregiver/my_profile/controllers/my_profile_controller.dart';
import 'package:cuidame/app/shared/widgets/custom_app_bar.dart';
import 'package:cuidame/app/shared/widgets/custom_date_picker.dart';
import 'package:cuidame/app/shared/widgets/custom_dropdown.dart';
import 'package:cuidame/app/shared/widgets/custom_text_form_field.dart';
import 'package:cuidame/app/shared/widgets/primary_button.dart';
import 'package:cuidame/app/shared/widgets/profile_photo.dart';
import 'package:cuidame/app/shared/widgets/safe_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final controller = DependencesInjector.get<MyProfileController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: CustomAppBar(
        context: context,
        title: const Text('Voltar'),
        transparent: true,
      ),
      body: SafeArea(
        child: SafeScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacements.M),
            child: SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Spacements.S),
                  Obx(
                    () => ProfilePhoto(
                      onFile: controller.uploadProfilePhoto,
                      profilePhotoUrl: controller.avatar.value,
                      loading: controller.loadingProfilePhoto.value,
                    ),
                  ),
                  const SizedBox(height: Spacements.S),
                  Text(
                    'Alterar Foto',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: Spacements.XL),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    title: 'Nome',
                    hintText: 'Digite seu nome',
                    initialValue: controller.name.value,
                    onChanged: (value) {
                      controller.name.value = value.isNotEmpty ? value : null;
                    },
                    errorText: controller.validateName,
                  ),
                  const SizedBox(height: Spacements.M),
                  Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: CustomDatePicker(
                            title: 'Data de nascimento',
                            hintText: 'Selecione uma data',
                            initialDate: controller.dateOfBirth.value,
                            dateOnly: true,
                            disableFutureDate: true,
                            onChange: controller.onChangeDate,
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacements.S),
                      Obx(
                        () => Expanded(
                          child: CustomDropdown(
                            title: 'Sexo',
                            hintText: 'Selecione um Sexo',
                            onChanged: controller.onChangeGender,
                            items: [
                              CustomDropdownItem(
                                text: 'Masculino',
                                value: 0,
                              ),
                              CustomDropdownItem(
                                text: 'Feminino',
                                value: 1,
                              ),
                            ],
                            value: controller.gender.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shadowColor: AppColors.black,
                          backgroundColor: AppColors.lightGray,
                          elevation: 2,
                          shape: const CircleBorder(),
                        ),
                        onPressed: controller.signOut,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Spacements.S,
                            horizontal: Spacements.S,
                          ),
                          child: Icon(
                            Icons.exit_to_app,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacements.S),
                      Obx(
                        () => Expanded(
                          child: PrimaryButton(
                            onPressed: controller.formValidate ? controller.submit : null,
                            text: 'Salvar Alterações',
                            icon: Icons.save_outlined,
                            expanded: true,
                            loading: controller.loading.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacements.XS),
                  Material(
                    child: InkWell(
                      onTap: controller.deleteMyAccount,
                      child: Padding(
                        padding: const EdgeInsets.all(Spacements.XXS),
                        child: Text(
                          'Desejo excluir minha conta',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
