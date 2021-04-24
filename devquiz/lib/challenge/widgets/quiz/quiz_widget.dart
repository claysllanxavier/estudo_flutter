import 'package:devquiz/challenge/widgets/awnser/answer_widget.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/shared/models/answer_model.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class QuizWiget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onsSelected;

  const QuizWiget({Key? key, required this.question, required this.onsSelected})
      : super(key: key);

  @override
  _QuizWigetState createState() => _QuizWigetState();
}

class _QuizWigetState extends State<QuizWiget> {
  int? indexSelected = -1;

  AnswerModel answer(index) => widget.question.answers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 64),
          Text(
            widget.question.title,
            style: AppTextStyles.heading,
          ),
          SizedBox(height: 24),
          for (var i = 0; i < widget.question.answers.length; i++)
            AnswerWidget(
              answer: answer(i),
              isSelected: indexSelected == i,
              isDisabled: indexSelected != -1,
              onTap: (value) {
                indexSelected = i;
                setState(() {});
                Future.delayed(Duration(seconds: 1))
                    .then((_) => widget.onsSelected(value));
              },
            ),
        ],
      ),
    );
  }
}
