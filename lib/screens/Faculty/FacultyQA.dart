import 'package:flutter/material.dart';
import 'package:school_management_system/models/QaModal.dart';
import 'package:school_management_system/widgets/Faculty/customScafold.dart';
import 'package:school_management_system/widgets/Faculty/QAWidget.dart';

class FacultyQA extends StatefulWidget {
  static final id = '/FacultyQA';

  @override
  State<FacultyQA> createState() => _FacultyQAState();
}

class _FacultyQAState extends State<FacultyQA> {
  List QA = [
    QaModal(title: "Adding Two Number",doubt: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form There are many variations of passages of Lorem Ipsum available There are many variations of passages of Lorem Ipsum available",sub: "Maths"),
    QaModal(title: "Doubt In Preposition",doubt: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form",sub: "English"),
    QaModal(title: "Adding Two Number",doubt: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form",sub: "Hindi"),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScafold(
      title: "Q & A",
      body: Padding(
        padding:EdgeInsets.only(top: 8.0),
        child: ListView.builder(
            itemCount: QA.length,
            itemBuilder: (context, index) {
              return QAWidget(title: QA[index].title,sub: QA[index].sub,doubt: QA[index].doubt,);
            }),
      ),
    );
  }
}
