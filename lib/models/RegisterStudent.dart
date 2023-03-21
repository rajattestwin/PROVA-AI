// ignore_for_file: file_names

class RegisterStudent {
  String? name, deviceToken, email, phone, state, course, avatarIdx;

  RegisterStudent({
    this.name,
    this.deviceToken,
    this.email,
    this.phone,
    this.state,
    this.course,
    this.avatarIdx,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['device_token'] = deviceToken;
    data['email_id'] = email;
    data['phone_number'] = phone;
    data['state'] = state;
    data['course'] = course;
    data['avatar'] = avatarIdx;
    return data;
  }
}
