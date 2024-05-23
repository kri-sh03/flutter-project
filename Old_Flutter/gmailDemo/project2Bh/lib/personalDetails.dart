import 'package:flutter/material.dart';
import 'package:project2/style.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  String text = 'male';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.semiDark,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkSecondary,
                            AppColors.primary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/id.png',
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(' SELVAM',
                    style:
                        AppFont.body(textColor: AppColors.semiDark).secondary),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.semiDark,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkSecondary,
                            AppColors.primary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/dob-removebg-preview.png',
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text('23/12/2001',
                    style:
                        AppFont.body(textColor: AppColors.semiDark).secondary),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.semiDark,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkSecondary,
                            AppColors.primary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Image.asset(
                    text == 'male'
                        ? 'assets/images/maleiicon-removebg-preview.png'
                        : 'assets/images/female-removebg-preview.png',
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(text == 'male' ? 'Male' : 'Female',
                    style:
                        AppFont.body(textColor: AppColors.semiDark).secondary),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.semiDark,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkSecondary,
                            AppColors.primary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/mail-removebg-preview.png',
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text('abcd123@gmail.com',
                    style:
                        AppFont.body(textColor: AppColors.semiDark).secondary),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.semiDark,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkSecondary,
                            AppColors.primary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/home-removebg-preview.png',
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                    '57 VAISIYAR STREET TIYAGADURUGAM KALLAKURICHI TALUK VILUPPURAM TAMIL NADU 606206 INDIA',
                    style:
                        AppFont.body(textColor: AppColors.semiDark).secondary),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
