
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/policy_agreement.dart';
import 'package:sense_flutter_application/screens/widgets/common/policy_content.dart';

class PolicyNotifier extends StateNotifier<List<PolicyAgreement>> {
  
  PolicyNotifier() : super([]) {
    init();
  }

  init() {
    super.state = [
      // PolicyAgreement(
      //     title: '전체동의',
      // ),
      PolicyAgreement(
        title: '14세 이상입니다. ',
        isRequired: true,
      ),
      PolicyAgreement(
        title: '센스 이용약관 ',
        isRequired: true,
        content: const PolicyContent(
          title: '제1조 목적',
          content: '이 약관은 주식회사 러너스(이하 “회사”라 함)가 운영하는 이벤트 생성 및 광고 플랫폼 센스(sens.im) (이하 '
            '“플랫폼”이라 한다)에서 제공하는 큐레이션 및 중개, 판매 서비스(이하 “서비스”라 함)를 이용함에 있어 “회사”와'
            '“이용자”의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.'
        ),
      ),
        PolicyAgreement(
          title: '개인정보처리동의 ',
          isRequired: true,
          content: const PolicyContent(title: '제1조 목적', content: '이 약관은 주식회사 러너스(이하 “회사”라 함)가 운영하는 이벤트 생성 및 광고 플랫폼 센스(sens.im) (이하 “플랫폼”이라 한다)에서 제공하는 큐레이션 및 중개, 판매 서비스(이하 “서비스”라 함)를 이용함에 있어 “회사”와 “이용자”의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.'),
        ),
        PolicyAgreement(
          title: '개인정보처리방침 ',
          isRequired: true,
          content: const PolicyContent(title: '제1조 목적', content: '이 약관은 주식회사 러너스(이하 “회사”라 함)가 운영하는 이벤트 생성 및 광고 플랫폼 센스(sens.im) (이하 “플랫폼”이라 한다)에서 제공하는 큐레이션 및 중개, 판매 서비스(이하 “서비스”라 함)를 이용함에 있어 “회사”와 “이용자”의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.'),
        ),
        PolicyAgreement(
          title: '마케팅 정보 수신동의 (선택)',
          content: const PolicyContent(title: '제1조 목적', content: '이 약관은 주식회사 러너스(이하 “회사”라 함)가 운영하는 이벤트 생성 및 광고 플랫폼 센스(sens.im) (이하 “플랫폼”이라 한다)에서 제공하는 큐레이션 및 중개, 판매 서비스(이하 “서비스”라 함)를 이용함에 있어 “회사”와 “이용자”의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.'),
        )
    ];
  }

  List<PolicyAgreement> all() {
    return state.toList();
  }

  List<PolicyAgreement> noContentItems() {
    return state.where((e) => e.content == null).toList();
  }

  List<PolicyAgreement> withContentItems() {
    return state.where((e) => e.content != null).toList();
  }

  void toggle(PolicyAgreement value) {
    state = state.map((e) {
      if (e.id == value.id) {
        e.isSelected = !e.isSelected;
      }
      return e;
    }).toList();
  }

  void toggleAll(bool toggle) {
    // Check if all items are selected
    // final bool areAllSelected = value.every((e) => e.isSelected);

    // print(areAllSelected);

    // Map over the items and set isSelected based on the condition above
    state = state.map((e) {
      // print('is_selected: ${e.isSelected}');
      // If all items are selected, we deselect them, and vice versa.
      if (e.isRequired) {
        // print('is_selected: ${!areAllSelected}');
        e.isSelected = !toggle;
      }
      return e;
    }).toList();
  }
}

final policyAgreementProvider = StateNotifierProvider<PolicyNotifier, List<PolicyAgreement>>((ref) {
  return PolicyNotifier();
});

final hasAllAgreedProvider = Provider<bool>((ref) {
  return ref.watch(policyAgreementProvider).where((element) => element.isRequired).toList().every((element) => element.isSelected);
});



final expandIdProvider = StateProvider<int?>((ref) => null);