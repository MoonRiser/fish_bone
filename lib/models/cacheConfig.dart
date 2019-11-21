class CacheConfig {
  CacheConfig();

  bool enable;
  num maxAge;
  num maxCount;

  factory CacheConfig.fromJson(Map<String, dynamic> json) {
    return CacheConfig()
      ..enable = json['enable'] as bool
      ..maxAge = json['maxAge'] as num
      ..maxCount = json['maxCount'] as num;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'enable': this.enable,
        'maxAge': this.maxAge,
        'maxCount': this.maxCount
      };
}
