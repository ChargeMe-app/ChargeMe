enum Asset {
  Parking,
  WC,
  addPhoto,
  appleMail,
  camping,
  caravanMainSocket,
  chademo,
  charging,
  checkmarkRounded,
  chevronDown,
  chevronRight,
  clock,
  commando3pin,
  css,
  dining,
  directionRight,
  evParking,
  gLogo,
  grocery,
  hiking,
  home64,
  homeIcon,
  icon,
  inRepair64,
  info,
  infoRounded,
  j1772,
  lodging,
  mapMarker,
  nema1450,
  park,
  phone,
  pin,
  pinWithPlus,
  publicFast64,
  publicGrey64,
  publicStandard64,
  settings,
  shopping,
  star,
  starRounded,
  telegramLogo,
  teslaRoadster,
  test_photo,
  threeDots,
  threePhase,
  type2,
  type3,
  valetParking,
  waitingForCharge,
  wall,
  wallAuNz,
  wallEuro,
  wifi,
  xmarkRounded,
}

extension AssetPath on Asset {
  String get path {
    switch (this) {
      case Asset.Parking:
        return "assets/icons/common/Parking.svg";
      case Asset.WC:
        return "assets/icons/amenities/WC.png";
      case Asset.addPhoto:
        return "assets/icons/common/addPhoto.svg";
      case Asset.appleMail:
        return "assets/icons/other/appleMail.png";
      case Asset.camping:
        return "assets/icons/amenities/camping.png";
      case Asset.caravanMainSocket:
        return "assets/icons/plugs/caravanMainSocket.png";
      case Asset.chademo:
        return "assets/icons/plugs/chademo.png";
      case Asset.charging:
        return "assets/icons/common/charging.svg";
      case Asset.checkmarkRounded:
        return "assets/icons/common/checkmarkRounded.svg";
      case Asset.chevronDown:
        return "assets/icons/common/chevronDown.svg";
      case Asset.chevronRight:
        return "assets/icons/common/chevronRight.svg";
      case Asset.clock:
        return "assets/icons/common/clock.svg";
      case Asset.commando3pin:
        return "assets/icons/plugs/commando3pin.png";
      case Asset.css:
        return "assets/icons/plugs/css.png";
      case Asset.dining:
        return "assets/icons/amenities/dining.png";
      case Asset.directionRight:
        return "assets/icons/common/directionRight.svg";
      case Asset.evParking:
        return "assets/icons/amenities/evParking.png";
      case Asset.gLogo:
        return "assets/icons/other/gLogo.png";
      case Asset.grocery:
        return "assets/icons/amenities/grocery.png";
      case Asset.hiking:
        return "assets/icons/amenities/hiking.png";
      case Asset.home64:
        return "assets/icons/markers/home64.png";
      case Asset.homeIcon:
        return "assets/icons/common/homeIcon.svg";
      case Asset.icon:
        return "assets/app_icon/icon.png";
      case Asset.inRepair64:
        return "assets/icons/markers/inRepair64.png";
      case Asset.info:
        return "assets/icons/common/info.svg";
      case Asset.infoRounded:
        return "assets/icons/common/infoRounded.svg";
      case Asset.j1772:
        return "assets/icons/plugs/j1772.png";
      case Asset.lodging:
        return "assets/icons/amenities/lodging.png";
      case Asset.mapMarker:
        return "assets/icons/markers/mapMarker.png";
      case Asset.nema1450:
        return "assets/icons/plugs/nema1450.png";
      case Asset.park:
        return "assets/icons/amenities/park.png";
      case Asset.phone:
        return "assets/icons/common/phone.png";
      case Asset.pin:
        return "assets/icons/common/pin.svg";
      case Asset.pinWithPlus:
        return "assets/icons/common/pinWithPlus.png";
      case Asset.publicFast64:
        return "assets/icons/markers/publicFast64.png";
      case Asset.publicGrey64:
        return "assets/icons/markers/publicGrey64.png";
      case Asset.publicStandard64:
        return "assets/icons/markers/publicStandard64.png";
      case Asset.settings:
        return "assets/icons/common/settings.svg";
      case Asset.shopping:
        return "assets/icons/amenities/shopping.png";
      case Asset.star:
        return "assets/icons/common/star.svg";
      case Asset.starRounded:
        return "assets/icons/common/starRounded.svg";
      case Asset.telegramLogo:
        return "assets/icons/other/telegramLogo.png";
      case Asset.teslaRoadster:
        return "assets/icons/plugs/teslaRoadster.png";
      case Asset.test_photo:
        return "assets/temporary/test_photo.jpeg";
      case Asset.threeDots:
        return "assets/icons/common/threeDots.png";
      case Asset.threePhase:
        return "assets/icons/plugs/threePhase.png";
      case Asset.type2:
        return "assets/icons/plugs/type2.png";
      case Asset.type3:
        return "assets/icons/plugs/type3.png";
      case Asset.valetParking:
        return "assets/icons/amenities/valetParking.png";
      case Asset.waitingForCharge:
        return "assets/icons/common/waitingForCharge.svg";
      case Asset.wall:
        return "assets/icons/plugs/wall.png";
      case Asset.wallAuNz:
        return "assets/icons/plugs/wallAuNz.png";
      case Asset.wallEuro:
        return "assets/icons/plugs/wallEuro.png";
      case Asset.wifi:
        return "assets/icons/amenities/wifi.png";
      case Asset.xmarkRounded:
        return "assets/icons/common/xmarkRounded.svg";
    }
  }
}
