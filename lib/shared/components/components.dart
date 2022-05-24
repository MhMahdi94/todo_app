import 'package:flutter/material.dart';
import 'package:flutter_application_3/shared/cubit/cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appTextFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  required String label,
  required IconData iconData,
  void Function(String)? onChange,
  required String? Function(String?) validate,
  void Function()? onTap,
  bool isPassword = false,
}) {
  return Padding(
    padding: EdgeInsets.all(8.0.r),
    child: TextFormField(
      controller: controller,
      keyboardType: inputType,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validate,
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(
          iconData,
        ),
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

Widget AppButton({required String label, required void Function()? onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget buildTaskItem({Map? model, context}) {
  AppCubit cubit = AppCubit.get(context);
  return Container(
    width: double.infinity,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model!['title'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    '${model['date']}  -  ${model['time']}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.updateDatainDatabase(
                  id: model['id'],
                  status: 'done',
                );
              },
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.updateDatainDatabase(
                  id: model['id'],
                  status: 'archived',
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.blueAccent,
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.deleteDatainDatabase(id: model['id']);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget tasksBuilder({required tasks}) {
  return ListView.separated(
      itemBuilder: (context, index) {
        return buildTaskItem(model: tasks[index], context: context);
      },
      separatorBuilder: (context, index) {
        return Container();
      },
      itemCount: tasks.length);
}
