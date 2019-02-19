class InstallBasicInfoEntity {
	String aboutus;
	String userinstructions;

	InstallBasicInfoEntity({this.aboutus, this.userinstructions});

	InstallBasicInfoEntity.fromJson(Map<String, dynamic> json) {
		aboutus = json['AboutUs'];
		userinstructions = json['UserInstructions'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['AboutUs'] = this.aboutus;
		data['UserInstructions'] = this.userinstructions;
		return data;
	}
}
