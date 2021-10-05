class DeviceInfo {
  String deviceName;
  String deviceVersion;
  String identifier;
  String appType;
  String deviceType;
  String browser;
  String browserVersion;
  String ipAddress;

  DeviceInfo({this.deviceName,this.deviceVersion,this.identifier,this.appType,this.browser,this.browserVersion,this.deviceType,this.ipAddress});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    deviceVersion = json['deviceVersion'];
    identifier = json['identifier'];
    appType = json['appType'];
    deviceType = json['deviceType'];
    browser = json['browser'];
    browserVersion = json['browserVersion'];
    ipAddress = json['ipAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = this.deviceName;
    data['deviceVersion'] = this.deviceVersion;
    data['identifier'] = this.identifier;
    data['appType'] = this.appType;
    data['deviceType'] = this.deviceType;
    data['browser'] = this.browser;
    data['browserVersion'] = this.browserVersion;
    data['ipAddress'] = this.ipAddress;
    return data;
  }
}
