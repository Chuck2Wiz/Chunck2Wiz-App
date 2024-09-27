import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/blocs/signup/signup_bloc.dart';
import '../../data/blocs/signup/signup_event.dart';
import '../../data/blocs/signup/signup_state.dart';
import '../../ui/util/base_page.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/data/repository/signup_repository.dart';
import 'package:chuck2wiz/ui/widget/favorite_dialog_widget.dart';

class SignUpPage extends BasePage<SignUpBloc, SignUpState> {
  static const double buttonHeight = 50.0;
  static const double inputBorderRadius = 5.0;
  static const TextStyle labelTextStyle = TextStyle(fontSize: 14);

  const SignUpPage({super.key});

  @override
  SignUpBloc createBloc(BuildContext context) => SignUpBloc(SignUpRepository());

  @override
  Color get backgroundColor => ColorDefines.primaryWhite;

  @override
  Widget buildContent(BuildContext context, SignUpState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNickField(context),
                    verticalSpace(),
                    _buildAgeField(context),
                    verticalSpace(),
                    _buildGenderField(context),
                    verticalSpace(),
                    _buildJobField(context),
                    verticalSpace(),
                    _buildFavoriteField(context),
                  ],
                ),
              ),
            ),
            _buildSubmitButton(state, context),
            verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget verticalSpace([double height = 16.0]) => SizedBox(height: height);

  Widget horizontalSpace([double width = 8.0]) => SizedBox(width: width);

  Widget _buildNickField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _buildFormField(
          label: '닉네임',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: buttonHeight,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '입력',
                    suffixText: '${state.nick.length} / 10',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(inputBorderRadius),
                    ),
                  ),
                  initialValue: state.nick,
                  onChanged: (value) => context.read<SignUpBloc>().add(NicknameChanged(value)),
                ),
              ),
            ],
          ),
          errorText: state.nickError ? '중복된 닉네임입니다.' : null,
        );
      },
    );
  }


  Widget _buildAgeField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _buildFormField(
          label: '나이',
          child: SizedBox(
            height: buttonHeight,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '입력',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(inputBorderRadius),
                ),
              ),
              initialValue: state.age.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                int? age = int.tryParse(value);
                if (age != null) {
                  context.read<SignUpBloc>().add(AgeChanged(age));
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildGenderField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _buildFormField(
          label: '성별',
          child: Row(
            children: [
              _buildGenderButton(context, '남성', state.gender),
              horizontalSpace(),
              _buildGenderButton(context, '여성', state.gender),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderButton(BuildContext context, String gender, String currentGender) {
    final isSelected = gender == currentGender;
    return Expanded(
      child: SizedBox(
        height: buttonHeight,
        child: ElevatedButton(
          onPressed: () => context.read<SignUpBloc>().add(GenderChanged(gender)),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? ColorDefines.mainColor : ColorDefines.primaryWhite,
            foregroundColor: isSelected ? ColorDefines.primaryWhite : ColorDefines.primaryBlack,
            side: BorderSide(color: isSelected ? ColorDefines.mainColor : ColorDefines.primaryGray),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(inputBorderRadius)),
          ),
          child: Text(gender),
        ),
      ),
    );
  }

  Widget _buildJobField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _buildFormField(
          label: '직업',
          child: SizedBox(
            height: buttonHeight,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(inputBorderRadius),
                ),
              ),
              value: state.job.isEmpty ? null : state.job,
              items: _buildJobItems(),
              onChanged: (value) => context.read<SignUpBloc>().add(JobChanged(value!)),
              validator: (value) => value == null ? '직업을 선택해주세요' : null,
            ),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<String>> _buildJobItems() {
    const jobs = ['학생', '주부', '회사원', '전문가', '기타'];
    return jobs.map((job) => DropdownMenuItem(
      value: job,
      child: Text(job, style: labelTextStyle, // 글씨 크기 설정
      ),
    )).toList();
  }

  Widget _buildFavoriteField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _buildFormField(
          label: '관심 분야 (최대 3개 선택 가능)',
          child: SizedBox(
            height: buttonHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () async {
                  final selectedFavorite = await showDialog<List<String>>(
                    context: context,
                    builder: (_) => FavoriteDialog(),
                  );
                  if (selectedFavorite != null) {
                    context.read<SignUpBloc>().add(FavoriteChanged(selectedFavorite));
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: ColorDefines.primaryGray),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.favorite.isEmpty ? '선택' : state.favorite.join(', '),
                    style: TextStyle(color: ColorDefines.primaryBlack),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(SignUpState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: state.isValid
            ? () => context.read<SignUpBloc>().add(FormSubmitted(
          userNum: state.userNum,
          nick: state.nick,
          age: state.age,
          gender: state.gender,
          job: state.job,
          favorite: state.favorite,
        ))
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: state.isValid
              ? ColorDefines.mainColor
              : ColorDefines.primaryGray,
          side: BorderSide(
              color: state.isValid
                  ? ColorDefines.mainColor
                  : ColorDefines.primaryGray),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(inputBorderRadius)),
        ),
        child: const Text(
          '완료',
          style: TextStyle(
              color: ColorDefines.primaryWhite,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required Widget child,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelTextStyle),
        verticalSpace(),
        child,
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(errorText, style: const TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}
