import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import '../../../providers/auth/policy_provider.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_checkbox.dart';


class SignupPolicyAgreement extends ConsumerWidget {
  
  // Constructor
  const SignupPolicyAgreement({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
      
    bool hasAllAgreed() {
      return ref.watch(hasAllAgreedProvider);
    }

    final int ?expandId = ref.watch(expandIdProvider); 
    final expandedPolicy = ref.watch(policyAgreementProvider)
      .where((element) => element.content != null)
      .toList();
    final noExpandPolicy = ref.watch(policyAgreementProvider)
      .where((element) 
        => element.content == null)
        .toList()
        .map((e) 
          => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: 
                CustomCheckbox(
                  isChecked: e.isSelected,
                  onChanged: () {
                    ref.read(policyAgreementProvider.notifier).toggle(e);
                  },
                  child: RichText(
                    text:
                      TextSpan(
                        style: const TextStyle(color: Color(0XFF555555)),
                        children: [
                          TextSpan(text: e.title),
                          if(e.isRequired) TextSpan(
                            text: '(필수)',
                            style: TextStyle(color: primaryColor[50], fontWeight: FontWeight.w500),
                          ) 
                        ]
                      ),
                  )
                ),
            )
          ).toList();

    return Column(
      children: [
        // Select All
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          child:
            CustomCheckbox(
              isChecked: hasAllAgreed(),
              onChanged: () {
                ref.read(policyAgreementProvider.notifier).toggleAll(
                  expandedPolicy.where((element) => element.isRequired).every((element) => element.isSelected)
                );
              },
              child: const Text('전체동의', style: TextStyle(color: Color(0XFF555555)))
            )
        ),

        ...noExpandPolicy,
        ExpansionPanelList(
          elevation: 0,
          dividerColor: Colors.transparent,
          materialGapSize: 0,
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (int index, bool value) {
            ref.read(expandIdProvider.notifier).state = value ? index : null;
          },
          children: expandedPolicy.map((policy) {
            return 
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return 
                    CustomCheckbox(
                      isChecked: policy.isSelected,
                      onChanged: () {
                        ref.read(policyAgreementProvider.notifier).toggle(policy);
                      },
                      child: RichText(
                        text: 
                          TextSpan(
                            style: const TextStyle(color: Color(0XFF555555)),
                            children: 
                              [ 
                                TextSpan(text: policy.title),
                                if (policy.isRequired) TextSpan(
                                  text: '(필수)',
                                  style: TextStyle(color: primaryColor[50], fontWeight: FontWeight.w500),
                                ),
                              ]
                            ),
                        )
                    );
          },
          body: ListTile(
            title: policy.content,
          ),
          isExpanded: expandedPolicy.indexOf(policy) == expandId,
        );
      }).toList(),
    )
      ],
    );
  }

}


// ExpansionPanel(
//     headerBuilder: (BuildContext context, bool isExpanded) {
    // return Container(
    //   alignment: AlignmentDirectional.centerStart,
    //   padding: const EdgeInsets.all(8),
    //   child: Row(children: [
    //     CustomCheckbox(label: '센스 이용약관 (필수)', isChecked: true, onChanged: () {})
    //   ],),
    // );
//   },
//   body: Container(
//     decoration: BoxDecoration(
//       color: Color(0xFFF6F6F6),
//       borderRadius: BorderRadius.circular(4),
//     ),
//     padding: const EdgeInsets.all(20),
//     child: Column(
//       children: <Widget>[
//         Container(
//           alignment: Alignment.centerLeft,
//           margin: EdgeInsets.only(bottom: 8),
//           child: Text(
//             'Content of the panel',
//             textAlign: TextAlign.start,
//           ),
//         ),
//         Text(
//           '이 약관은 주식회사 러너스(이하 “회사”라 함)가 운영하는 이벤트 생성 및 광고 플랫폼 센스(sens.im) (이하 “플랫폼”이라 한다)에서 제공하는 큐레이션 및 중개, 판매 서비스(이하 “서비스”라 함)를 이용함에 있어 “회사”와 “이용자”의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.',
//         ),
//       ],
//     ),
//   ),
//   isExpanded: false,
// ),