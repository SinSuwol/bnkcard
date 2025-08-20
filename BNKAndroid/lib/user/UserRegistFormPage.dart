import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bnkandroid/postcode_search_page.dart';
import 'CardListPage.dart';

const kPrimaryRed = Color(0xffB91111);

class UserRegistFormPage extends StatefulWidget {
  final String role;
  final Map<String, String> agreedTerms;

  const UserRegistFormPage({
    super.key,
    required this.role,
    required this.agreedTerms,
  });

  @override
  State<UserRegistFormPage> createState() => _UserRegistFormPageState();
}

class _UserRegistFormPageState extends State<UserRegistFormPage> {
  // 아이디 메시지
  String usernameMsg = '';
  Color usernameMsgColor = Colors.red;

  // 비밀번호 메시지 상태 변수
  String passwordMsg = '';
  Color passwordMsgColor = Colors.red;

  // 비밀번호확인 메시지 상태 변수
  String passwordCheckMsg = '';
  Color passwordCheckMsgColor = Colors.red;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController rrnFrontController = TextEditingController();
  final TextEditingController rrnBackController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController extraAddressController = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();

  bool usernameChecked = false;

  // 아이디 중복확인
  Future<void> checkUsername() async {
    final username = usernameController.text.trim();
    if (username.isEmpty) {
      setState(() {
        usernameMsg = "아이디를 입력해주세요.";
        usernameMsgColor = Colors.red;
        usernameChecked = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.0.229:8090/user/api/regist/check-username"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": username},
      );
      final res = json.decode(response.body);
      setState(() {
        usernameMsg = res['msg'];
        usernameMsgColor = res['valid'] == true ? Colors.green : Colors.red;
        usernameChecked = res['valid'] == true;
      });
    } catch (e) {
      setState(() {
        usernameMsg = "서버와 통신 중 오류 발생";
        usernameMsgColor = Colors.red;
        usernameChecked = false;
      });
    }
  }

  // 비밀번호 유효성 검사
  bool isPasswordValid(String pw) {
    final pwRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,12}$',
    );
    return pwRegex.hasMatch(pw);
  }

  // 회원가입 제출
  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (!usernameChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("아이디 중복 확인을 해주세요.")),
      );
      return;
    }

    Map<String, dynamic> data = {
      "name": nameController.text.trim(),
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
      "passwordCheck": passwordCheckController.text.trim(),
      "rrnFront": rrnFrontController.text.trim(),
      "rrnBack": rrnBackController.text.trim(),
      "zipCode": zipCodeController.text.trim(),
      "address1": address1Controller.text.trim(),
      "extraAddress": extraAddressController.text.trim(),
      "address2": address2Controller.text.trim(),
      "role": widget.role,
      //"agreedTerms": widget.agreedTerms,
    };

    try {
      final response = await http.post(
        Uri.parse("http://192.168.0.229:8090/user/api/regist/submit"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      final result = json.decode(response.body);
      if (response.statusCode == 200 && result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['msg'])),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CardListPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['msg'] ?? "회원가입 실패")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("서버와 통신 중 오류 발생")),
      );
    }
  }

  // 주소 검색 버튼 눌렀을 때
  void searchAddress() async {
    final result = await Navigator.push<Map<String, dynamic>?>(
      context,
      MaterialPageRoute(builder: (_) => const PostcodeSearchPage()),
    );

    if (result != null) {
      setState(() {
        zipCodeController.text = (result['zonecode'] ?? '').toString();
        address1Controller.text = (result['roadAddress'] ?? '').toString().isNotEmpty
            ? (result['roadAddress'] ?? '')
            : (result['jibunAddress'] ?? '');
        extraAddressController.text = (result['extraAddress'] ?? '').toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("회원가입",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("정보를 입력해 주세요.",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 20),

                  // 성명
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "성명(실명)"),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "성명을 입력해주세요.";
                      if (!RegExp(r'^[가-힣]{2,20}$').hasMatch(value)) {
                        return "성명은 한글 2~20자여야 합니다.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // 아이디 + 중복확인
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: usernameController,
                              decoration: const InputDecoration(labelText: "아이디"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "아이디를 입력해주세요.";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: checkUsername,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryRed,
                            ),
                            child: const Text("중복확인",
                                style: TextStyle(fontSize: 13, color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        usernameMsg,
                        style: TextStyle(color: usernameMsgColor, fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // 비밀번호
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "비밀번호"),
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          passwordMsg = "비밀번호를 입력해주세요.";
                          passwordMsgColor = Colors.red;
                        } else if (!isPasswordValid(value)) {
                          passwordMsg = "영문, 숫자, 특수문자 포함 8~12자리여야 합니다.";
                          passwordMsgColor = Colors.red;
                        } else {
                          passwordMsg = "사용 가능한 비밀번호입니다.";
                          passwordMsgColor = Colors.green;
                        }
                        // 비밀번호 변경되면 확인 메시지 초기화
                        passwordCheckMsg = '';
                      });
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    passwordMsg,
                    style: TextStyle(color: passwordMsgColor, fontSize: 12),
                  ),

                  const SizedBox(height: 10),

                  // 비밀번호 확인
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: passwordCheckController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: "비밀번호 확인"),
                        onChanged: (value) {
                          setState(() {
                            if (value != passwordController.text) {
                              passwordCheckMsg = "비밀번호가 일치하지 않습니다.";
                              passwordCheckMsgColor = Colors.red;
                            } else {
                              passwordCheckMsg = "비밀번호가 일치합니다.";
                              passwordCheckMsgColor = Colors.green;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(passwordCheckMsg,
                          style: TextStyle(color: passwordCheckMsgColor, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 주민등록번호
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: rrnFrontController,
                          decoration:
                          const InputDecoration(labelText: "주민등록번호 앞자리"),
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "주민등록번호 앞자리를 입력해주세요.";
                            }
                            if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                              return "6자리 숫자만 입력해주세요.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: rrnBackController,
                          decoration:
                          const InputDecoration(labelText: "주민등록번호 뒷자리"),
                          maxLength: 7,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "주민등록번호 뒷자리를 입력해주세요.";
                            }
                            if (!RegExp(r'^\d{7}$').hasMatch(value)) {
                              return "7자리 숫자만 입력해주세요.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 주소 + 주소 찾기 버튼
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: zipCodeController,
                          decoration: const InputDecoration(labelText: "우편번호"),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: searchAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryRed,
                        ),
                        child: const Text("검색", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: address1Controller,
                    decoration: const InputDecoration(labelText: "주소"),
                    readOnly: true,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: extraAddressController,
                    decoration: const InputDecoration(labelText: "참고주소"),
                    readOnly: true,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: address2Controller,
                    decoration: const InputDecoration(labelText: "상세주소"),
                  ),
                  const SizedBox(height: 20),

                  // 회원가입 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text("회원가입",
                          style:
                          TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 취소 버튼
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () => Navigator.pop(context),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.grey[200],
                  //       padding: const EdgeInsets.symmetric(vertical: 16),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(24),
                  //       ),
                  //     ),
                  //     child: const Text("취소",
                  //         style: TextStyle(fontSize: 16, color: Colors.black)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
