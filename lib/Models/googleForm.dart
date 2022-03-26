class GoogleFormModel {
  String name = '';
  int age;
  int std;
  double percentage;
  String medium = '';
  String FG = '';
  String address = '';
  int contact;
  String school = '';
  int total;
  String publishedDate;
  String reportUrl;
  String aadharUrl;
  String subjects;
  bool approval;
  String email;

  GoogleFormModel(this.name, this.age, this.std, this.percentage, this.medium, this.FG, this.address, this.contact, this.school, this.publishedDate, this.email, this.subjects, this.total, this.aadharUrl, this.reportUrl);

  String toParams() => "?name=$name&age=$age&standard=$std&percentage=$percentage&medium=$medium&fg=$FG&address=$address&contact=$contact&school=$school&date=$publishedDate&email=$email&subjects=$subjects&total=$total&aadharUrl=$aadharUrl&reportUrl=$reportUrl";

}