import 'package:json_annotation/json_annotation.dart';

enum Company {
  @JsonValue("Sitronics")
  sitronics,
  @JsonValue("my.eCars")
  myecars,
  @JsonValue(3)
  itcharge,
  @JsonValue(4)
  rushydro,
  @JsonValue(5)
  mostransport,
  @JsonValue(6)
  zevs,
  @JsonValue(7)
  evtime,
  @JsonValue(8)
  touchStation,
  @JsonValue(9)
  nsp,
  @JsonValue(10)
  portalEnergy,
  @JsonValue(11)
  rosseti,
  @JsonValue(12)
  chargeNet,
  @JsonValue(13)
  punktE,
  @JsonValue(14)
  v4d
}

extension CompanyName on Company {
  String get title {
    switch (this) {
      case Company.sitronics:
        return "Sitroncis";
      case Company.myecars:
        return "my.eCars";
      case Company.itcharge:
        return "IT.Charge";
      case Company.rushydro:
        return "Русгидро";
      case Company.mostransport:
        return "Мостранспорт";
      case Company.zevs:
        return "ZEVS";
      case Company.evtime:
        return "EVTime";
      case Company.touchStation:
        return "TOUCH Station";
      case Company.nsp:
        return "Non Stop Power";
      case Company.portalEnergy:
        return "Portal Energy";
      case Company.rosseti:
        return "Россети";
      case Company.chargeNet:
        return "ChargeNet";
      case Company.punktE:
        return "PunktE";
      case Company.v4d:
        return "V4D";
    }
  }
}
