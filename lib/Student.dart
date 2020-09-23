class Student {
  String name, subject;
  double point;

  Student(this.name, this.subject, this.point);
}

//generate data
List<Student> generateStudents() {
  List<Student> students = List<Student>();
  students.add(Student('Lê Việt Thắng', 'Flutter', 7));
  students.add(Student('Lê Thắng Việt', 'Flutter', 8));
  students.add(Student('Việt Thắng Lê', 'Flutter', 9));
  return students;
}
