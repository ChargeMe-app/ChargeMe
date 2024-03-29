import 'package:json_annotation/json_annotation.dart';

enum Manufacturer {
  nissan,
  tesla,
  chevrolet,
  mitsubishi,
  ford,
  toyota,
  honda,
  smart,
  bmw,
  audi,
  mercedes,
  kia,
  volkswagen,
  porsche,
  volvo,
  hyundai,
  byd,
  opel,
  jac,
  other
}

enum VehicleType {
  @JsonValue(0)
  unknown,
  @JsonValue(1)
  nissanLeaf,
  @JsonValue(2)
  chevroletVolt,
  @JsonValue(4)
  teslaModelS,
  @JsonValue(5)
  mitsubishiIMiev,
  @JsonValue(7)
  fordFocusElectric,
  @JsonValue(9)
  priusPlugInhybrid,
  @JsonValue(13)
  fordFusionEnergi,
  @JsonValue(14)
  toyotaRav4Ev,
  @JsonValue(15)
  hondaAccordPlugIn,
  @JsonValue(16)
  smartFortwoEd,
  @JsonValue(17)
  chevroletSparkEv,
  @JsonValue(18)
  bmwI3,
  @JsonValue(20)
  fiat500e,
  @JsonValue(22)
  cadillacElr,
  @JsonValue(23)
  eGolf,
  @JsonValue(24)
  audiA3ETron,
  @JsonValue(33)
  mercedesB250e,
  @JsonValue(34)
  kiaSoulEv,
  @JsonValue(36)
  opelAmpera,
  @JsonValue(38)
  zoe,
  @JsonValue(40)
  kangooZE,
  @JsonValue(41)
  twizy,
  @JsonValue(42)
  bydE6,
  @JsonValue(44)
  outlanderPlugInhybrid,
  @JsonValue(46)
  porscheCayenneSEHybrid,
  @JsonValue(49)
  x5Xdrive40ePlugInhybrid,
  @JsonValue(50)
  a3SportbackETron,
  @JsonValue(51)
  xc90RechargePlugInhybrid,
  @JsonValue(52)
  teslaModelX,
  @JsonValue(53)
  nissanENv200,
  @JsonValue(54)
  chevroletVoltGen2,
  @JsonValue(57)
  nissanLeaf2016,
  @JsonValue(59)
  bmw330ePlugInhybrid,
  @JsonValue(61)
  mercedesC350ePlugInhybrid,
  @JsonValue(63)
  chevroletBoltEv,
  @JsonValue(64)
  toyotaPriusPrime,
  @JsonValue(65)
  volvoV60RechargePlugInhybrid,
  @JsonValue(68)
  hyundaiIoniqElectric,
  @JsonValue(74)
  hondaClarityPlugInhybrid,
  @JsonValue(75)
  teslaModel3,
  @JsonValue(77)
  eGolf2017,
  @JsonValue(78)
  soulEv2018,
  @JsonValue(80)
  nissanLeaf2017,
  @JsonValue(81)
  nissanLeaf2018,
  @JsonValue(82)
  bmw225xePlugInhybrid,
  @JsonValue(86)
  bmwI32018,
  @JsonValue(88)
  jaguarIPace,
  @JsonValue(89)
  hyundaiKonaElectric2019,
  @JsonValue(90)
  volvoV90PlugInhybrid,
  @JsonValue(91)
  nissanLeaf2019,
  @JsonValue(99)
  other,
  @JsonValue(113)
  xiaopengXpengG3,
  @JsonValue(133)
  lifan330,
  @JsonValue(135)
  bydYuan,
  @JsonValue(152)
  geelyLynkAndCo01,
  @JsonValue(154)
  changanBenniEStar,
  @JsonValue(156)
  mercedesE350e,
  @JsonValue(163)
  opelAmperaE,
  @JsonValue(172)
  mercedesSls,
  @JsonValue(175)
  bydTang,
  @JsonValue(206)
  mercedesBClass,
  @JsonValue(207)
  bydDenza,
  @JsonValue(221)
  mclarenP1,
  @JsonValue(234)
  smartEqForfour,
  @JsonValue(239)
  bjevEuSeries,
  @JsonValue(245)
  mercedesAECell,
  @JsonValue(250)
  jacIev7s,
  @JsonValue(255)
  mitsubishiMinicabMiev,
  @JsonValue(257)
  bydQin,
  @JsonValue(261)
  bydQinPro,
  @JsonValue(265)
  smartFortwoEdW453,
  @JsonValue(274)
  songPro,
  @JsonValue(288)
  nissanSylphy,
  @JsonValue(290)
  lrRangeRover,
  @JsonValue(305)
  jacIev7s2,
  @JsonValue(307)
  mercedesC300e,
  @JsonValue(318)
  ladaElKalina,
  @JsonValue(329)
  cheryEq,
  @JsonValue(331)
  kiaNiroEv2019,
  @JsonValue(332)
  audiETron2019,
  @JsonValue(334)
  harleyDavidsonLivewire,
  @JsonValue(336)
  volkswagenEGolf2018,
  @JsonValue(337)
  volkswagenEGolf2019,
  @JsonValue(338)
  porscheTaycan2020,
  @JsonValue(339)
  kiaSoulEv2019,
  @JsonValue(343)
  zeroDsr,
  @JsonValue(345)
  hondaE2020,
  @JsonValue(346)
  mercedesEqc400,
  @JsonValue(347)
  kiaSoulEv2020,
  @JsonValue(352)
  teslaModelY,
  @JsonValue(360)
  peugeotE2008,
  @JsonValue(366)
  volvoS60RechargePlugInhybrid2019,
  @JsonValue(368)
  landRoverRangeRoverSportPlugInhybrid2020,
  @JsonValue(370)
  toyotaPriusPrime2020,
  @JsonValue(375)
  miniCooperSe2020,
  @JsonValue(376)
  miniCountrymanPlugInhybrid2020,
  @JsonValue(377)
  bmwI32019,
  @JsonValue(378)
  bmwI32020,
  @JsonValue(384)
  polestar2,
  @JsonValue(387)
  chevroletBoltEv2020,
  @JsonValue(388)
  kiaNiroEv2020,
  @JsonValue(389)
  hyundaiKonaElectric2020,
  @JsonValue(390)
  hyundaiIoniqElectric2020,
  @JsonValue(391)
  hyundaiIoniqElectric2019,
  @JsonValue(394)
  audiETronsportback,
  @JsonValue(396)
  eGoLife,
  @JsonValue(398)
  fordMustangMachE2021,
  @JsonValue(399)
  toyotaRav4Prime2021,
  @JsonValue(400)
  nissanLeaf2020,
  @JsonValue(401)
  bmwCEvolution,
  @JsonValue(403)
  skodaSuperbIv,
  @JsonValue(406)
  audiA7PlugInhybrid,
  @JsonValue(407)
  miniCooperSe2021,
  @JsonValue(410)
  volkswagenId3,
  @JsonValue(412)
  volkswagenEGolf2020,
  @JsonValue(413)
  mercedesGlc300e,
  @JsonValue(414)
  hyundaiKonaElectric2021,
  @JsonValue(419)
  mazdaMx30,
  @JsonValue(420)
  volvoV60RechargePlugInhybrid2020,
  @JsonValue(428)
  mercedesEqv,
  @JsonValue(434)
  bmw330ePlugInhybrid2020,
  @JsonValue(440)
  smartEqFortwo,
  @JsonValue(441)
  bentleyBentaygaHybrid,
  @JsonValue(446)
  volkswagenELavida,
  @JsonValue(452)
  volkswagenId4,
  @JsonValue(453)
  mercedesGle350PlugInhybrid,
  @JsonValue(460)
  volkswagenPassatSportscombiGtePlugInhybrid,
  @JsonValue(465)
  porscheTaycan2021,
  @JsonValue(468)
  avtovazLadaEllada,
  @JsonValue(469)
  mercedesGla250e,
  @JsonValue(472)
  nissanLeaf2021,
  @JsonValue(473)
  audiETron2020,
  @JsonValue(474)
  audiETron2021,
  @JsonValue(475)
  bydEv360,
  @JsonValue(476)
  audiETrongt2021,
  @JsonValue(478)
  aiwaysU52021,
  @JsonValue(484)
  landRoverRangeRoverPlugInhybrid2021,
  @JsonValue(488)
  renaultMeganeETechplugInhybrid,
  @JsonValue(492)
  audiETrongt2022,
  @JsonValue(504)
  audiQ4ETron2021,
  @JsonValue(508)
  audiETronsportback2021,
  @JsonValue(524)
  cupraFormentorPlugInhybrid,
  @JsonValue(526)
  kiaNiroEv2021,
  @JsonValue(549)
  bmwI32021,
  @JsonValue(566)
  bmwIx2021,
  @JsonValue(567)
  bmwI4Edrive402022,
  @JsonValue(569)
  hondaE2021,
  @JsonValue(578)
  gacAionS,
  @JsonValue(581)
  jeepRenegade4xePlugInhybrid2021,
  @JsonValue(598)
  nissanLeaf2022,
  @JsonValue(599)
  lucidMotorsLucidAir,
  @JsonValue(600)
  citroenEJumpy,
  @JsonValue(616)
  volvoXc40Recharge2021,
  @JsonValue(622)
  volvoXc90RechargePlugInhybrid2021,
  @JsonValue(623)
  volvoXc90RechargePlugInhybrid2022,
  @JsonValue(625)
  volvoXc60RechargePlugInhybrid2021,
  @JsonValue(630)
  volvoS90RechargePlugInhybrid2021,
  @JsonValue(631)
  volvoS90RechargePlugInhybrid2022,
  @JsonValue(655)
  bydHan,
  @JsonValue(657)
  mercedesEqa300,
  @JsonValue(659)
  mercedesEqs450Plus,
  @JsonValue(660)
  geelyGeometryC,
  @JsonValue(668)
  skywellEt5,
  @JsonValue(669)
  porscheTaycan2022,
  @JsonValue(671)
  hozonNezhaU,
}

extension Namings on VehicleType {
  String get fullName {
    switch (this) {
      case VehicleType.unknown:
        return "Unknown";
      case VehicleType.nissanLeaf:
        return "Nissan LEAF";
      case VehicleType.chevroletVolt:
        return "Chevrolet Volt";
      case VehicleType.teslaModelS:
        return "Tesla Model S";
      case VehicleType.mitsubishiIMiev:
        return "Mitsubishi i-MiEV";
      case VehicleType.fordFocusElectric:
        return "Ford Focus Electric";
      case VehicleType.priusPlugInhybrid:
        return "Prius Plug-In Hybrid";
      case VehicleType.fordFusionEnergi:
        return "Ford Fusion Energi";
      case VehicleType.toyotaRav4Ev:
        return "Toyota RAV4 EV";
      case VehicleType.hondaAccordPlugIn:
        return "Honda Accord Plug-In";
      case VehicleType.smartFortwoEd:
        return "Smart Fortwo ED";
      case VehicleType.chevroletSparkEv:
        return "Chevrolet Spark EV";
      case VehicleType.bmwI3:
        return "BMW i3";
      case VehicleType.fiat500e:
        return "Fiat 500e";
      case VehicleType.cadillacElr:
        return "Cadillac ELR";
      case VehicleType.eGolf:
        return "e-Golf";
      case VehicleType.audiA3ETron:
        return "Audi A3 e-tron";
      case VehicleType.mercedesB250e:
        return "Mercedes B250e";
      case VehicleType.kiaSoulEv:
        return "Kia Soul EV";
      case VehicleType.opelAmpera:
        return "Opel Ampera";
      case VehicleType.zoe:
        return "ZOE";
      case VehicleType.kangooZE:
        return "Kangoo Z.E.";
      case VehicleType.twizy:
        return "Twizy";
      case VehicleType.bydE6:
        return "BYD e6";
      case VehicleType.outlanderPlugInhybrid:
        return "Outlander Plug-In Hybrid";
      case VehicleType.porscheCayenneSEHybrid:
        return "Porsche Cayenne S E-Hybrid";
      case VehicleType.x5Xdrive40ePlugInhybrid:
        return "X5 xDrive40e Plug-In Hybrid";
      case VehicleType.a3SportbackETron:
        return "A3 Sportback e-tron";
      case VehicleType.xc90RechargePlugInhybrid:
        return "xC90 Recharge Plug-In Hybrid";
      case VehicleType.teslaModelX:
        return "Tesla Model X";
      case VehicleType.nissanENv200:
        return "Nissan e-NV200";
      case VehicleType.chevroletVoltGen2:
        return "Chevrolet Volt Gen2";
      case VehicleType.nissanLeaf2016:
        return "Nissan LEAF 2016";
      case VehicleType.bmw330ePlugInhybrid:
        return "BMW 330e Plug-In Hybrid";
      case VehicleType.mercedesC350ePlugInhybrid:
        return "Mercedes C350e Plug-in Hybrid";
      case VehicleType.chevroletBoltEv:
        return "Chevrolet Bolt EV";
      case VehicleType.toyotaPriusPrime:
        return "Toyota Prius Prime";
      case VehicleType.volvoV60RechargePlugInhybrid:
        return "Volvo V60 Recharge Plug-In Hybrid";
      case VehicleType.hyundaiIoniqElectric:
        return "Hyundai Ioniq Electric";
      case VehicleType.hondaClarityPlugInhybrid:
        return "Honda Clarity Plug-In Hybrid";
      case VehicleType.teslaModel3:
        return "Tesla Model 3";
      case VehicleType.eGolf2017:
        return "e-Golf 2017";
      case VehicleType.soulEv2018:
        return "Soul EV 2018";
      case VehicleType.nissanLeaf2017:
        return "Nissan LEAF 2017";
      case VehicleType.nissanLeaf2018:
        return "Nissan LEAF 2018";
      case VehicleType.bmw225xePlugInhybrid:
        return "BMW 225xe Plug-In Hybrid";
      case VehicleType.bmwI32018:
        return "BMW i3 2018";
      case VehicleType.jaguarIPace:
        return "Jaguar I-PACE";
      case VehicleType.hyundaiKonaElectric2019:
        return "Hyundai Kona Electric 2019";
      case VehicleType.volvoV90PlugInhybrid:
        return "Volvo V90 Plug-In Hybrid";
      case VehicleType.nissanLeaf2019:
        return "Nissan LEAF 2019";
      case VehicleType.other:
        return "Other";
      case VehicleType.xiaopengXpengG3:
        return "Xiaopeng XPeng G3";
      case VehicleType.lifan330:
        return "Lifan 330";
      case VehicleType.bydYuan:
        return "BYD Yuan";
      case VehicleType.geelyLynkAndCo01:
        return "Geely Lynk and Co 01";
      case VehicleType.changanBenniEStar:
        return "Changan Benni E-Star";
      case VehicleType.mercedesE350e:
        return "Mercedes E350e";
      case VehicleType.opelAmperaE:
        return "Opel Ampera-e";
      case VehicleType.mercedesSls:
        return "Mercedes SLS";
      case VehicleType.bydTang:
        return "BYD Tang";
      case VehicleType.mercedesBClass:
        return "Mercedes B-Class";
      case VehicleType.bydDenza:
        return "BYD Denza";
      case VehicleType.mclarenP1:
        return "McLaren P1";
      case VehicleType.smartEqForfour:
        return "Smart EQ Forfour";
      case VehicleType.bjevEuSeries:
        return "BJEV EU-Series";
      case VehicleType.mercedesAECell:
        return "Mercedes A E-Cell";
      case VehicleType.jacIev7s:
        return "JAC iEV7S";
      case VehicleType.mitsubishiMinicabMiev:
        return "Mitsubishi Minicab MiEV";
      case VehicleType.bydQin:
        return "BYD Qin";
      case VehicleType.bydQinPro:
        return "BYD Qin Pro";
      case VehicleType.smartFortwoEdW453:
        return "Smart Fortwo ED W453";
      case VehicleType.songPro:
        return "Song Pro";
      case VehicleType.nissanSylphy:
        return "Nissan Sylphy";
      case VehicleType.lrRangeRover:
        return "LR Range Rover";
      case VehicleType.jacIev7s2:
        return "JaC iEV7S";
      case VehicleType.mercedesC300e:
        return "Mercedes C300e";
      case VehicleType.ladaElKalina:
        return "Lada EL Kalina";
      case VehicleType.cheryEq:
        return "Chery eQ";
      case VehicleType.kiaNiroEv2019:
        return "Kia Niro EV 2019";
      case VehicleType.audiETron2019:
        return "Audi e-tron 2019";
      case VehicleType.harleyDavidsonLivewire:
        return "Harley Davidson LiveWire";
      case VehicleType.volkswagenEGolf2018:
        return "Volkswagen e-Golf 2018";
      case VehicleType.volkswagenEGolf2019:
        return "Volkswagen e-Golf 2019";
      case VehicleType.porscheTaycan2020:
        return "Porsche Taycan 2020";
      case VehicleType.kiaSoulEv2019:
        return "Kia Soul EV 2019";
      case VehicleType.zeroDsr:
        return "Zero DSR";
      case VehicleType.hondaE2020:
        return "Honda e 2020";
      case VehicleType.mercedesEqc400:
        return "Mercedes EQC400";
      case VehicleType.kiaSoulEv2020:
        return "Kia Soul EV 2020";
      case VehicleType.teslaModelY:
        return "Tesla Model Y";
      case VehicleType.peugeotE2008:
        return "Peugeot e-2008";
      case VehicleType.volvoS60RechargePlugInhybrid2019:
        return "Volvo S60 Recharge Plug-In Hybrid 2019";
      case VehicleType.landRoverRangeRoverSportPlugInhybrid2020:
        return "Land Rover Range Rover Sport Plug-In Hybrid 2020";
      case VehicleType.toyotaPriusPrime2020:
        return "Toyota Prius Prime 2020";
      case VehicleType.miniCooperSe2020:
        return "Mini Cooper SE 2020";
      case VehicleType.miniCountrymanPlugInhybrid2020:
        return "Mini Countryman Plug-In Hybrid 2020";
      case VehicleType.bmwI32019:
        return "BMW i3 2019";
      case VehicleType.bmwI32020:
        return "BMW i3 2020";
      case VehicleType.polestar2:
        return "Polestar 2";
      case VehicleType.chevroletBoltEv2020:
        return "Chevrolet Bolt EV 2020";
      case VehicleType.kiaNiroEv2020:
        return "Kia Niro EV 2020";
      case VehicleType.hyundaiKonaElectric2020:
        return "Hyundai Kona Electric 2020";
      case VehicleType.hyundaiIoniqElectric2020:
        return "Hyundai Ioniq Electric 2020";
      case VehicleType.hyundaiIoniqElectric2019:
        return "Hyundai Ioniq Electric 2019";
      case VehicleType.audiETronsportback:
        return "Audi e-tron Sportback";
      case VehicleType.eGoLife:
        return "e.GO Life";
      case VehicleType.fordMustangMachE2021:
        return "Ford Mustang Mach-E 2021";
      case VehicleType.toyotaRav4Prime2021:
        return "Toyota RAV4 Prime 2021";
      case VehicleType.nissanLeaf2020:
        return "Nissan LEAF 2020";
      case VehicleType.bmwCEvolution:
        return "BMW C-Evolution";
      case VehicleType.skodaSuperbIv:
        return "Skoda SUPERB IV";
      case VehicleType.audiA7PlugInhybrid:
        return "Audi A7 Plug-In Hybrid";
      case VehicleType.miniCooperSe2021:
        return "Mini Cooper SE 2021";
      case VehicleType.volkswagenId3:
        return "Volkswagen ID.3";
      case VehicleType.volkswagenEGolf2020:
        return "Volkswagen e-Golf 2020";
      case VehicleType.mercedesGlc300e:
        return "Mercedes GLC300e";
      case VehicleType.hyundaiKonaElectric2021:
        return "Hyundai Kona Electric 2021";
      case VehicleType.mazdaMx30:
        return "Mazda MX-30";
      case VehicleType.volvoV60RechargePlugInhybrid2020:
        return "Volvo V60 Recharge Plug-In Hybrid 2020";
      case VehicleType.mercedesEqv:
        return "Mercedes EQV";
      case VehicleType.bmw330ePlugInhybrid2020:
        return "BMW 330e Plug-In Hybrid 2020";
      case VehicleType.smartEqFortwo:
        return "Smart EQ Fortwo";
      case VehicleType.bentleyBentaygaHybrid:
        return "Bentley Bentayga Hybrid";
      case VehicleType.volkswagenELavida:
        return "Volkswagen e-Lavida";
      case VehicleType.volkswagenId4:
        return "Volkswagen ID.4";
      case VehicleType.mercedesGle350PlugInhybrid:
        return "Mercedes GLE350 Plug-In Hybrid";
      case VehicleType.volkswagenPassatSportscombiGtePlugInhybrid:
        return "Volkswagen Passat Sportscombi GTE Plug-In Hybrid";
      case VehicleType.porscheTaycan2021:
        return "Porsche Taycan 2021";
      case VehicleType.avtovazLadaEllada:
        return "AvtoVAZ Lada Ellada";
      case VehicleType.mercedesGla250e:
        return "Mercedes GLA250e";
      case VehicleType.nissanLeaf2021:
        return "Nissan LEAF 2021";
      case VehicleType.audiETron2020:
        return "Audi e-tron 2020";
      case VehicleType.audiETron2021:
        return "Audi e-tron 2021";
      case VehicleType.bydEv360:
        return "BYD EV360";
      case VehicleType.audiETrongt2021:
        return "Audi e-tron GT 2021";
      case VehicleType.aiwaysU52021:
        return "Aiways U5 2021";
      case VehicleType.landRoverRangeRoverPlugInhybrid2021:
        return "Land Rover Range Rover Plug-In Hybrid 2021";
      case VehicleType.renaultMeganeETechplugInhybrid:
        return "Renault Megane E-Tech Plug-In Hybrid";
      case VehicleType.audiETrongt2022:
        return "Audi e-tron GT 2022";
      case VehicleType.audiQ4ETron2021:
        return "Audi Q4 e-tron 2021";
      case VehicleType.audiETronsportback2021:
        return "Audi e-tron Sportback 2021";
      case VehicleType.cupraFormentorPlugInhybrid:
        return "Cupra Formentor Plug-In Hybrid";
      case VehicleType.kiaNiroEv2021:
        return "Kia Niro EV 2021";
      case VehicleType.bmwI32021:
        return "BMW i3 2021";
      case VehicleType.bmwIx2021:
        return "BMW iX 2021";
      case VehicleType.bmwI4Edrive402022:
        return "BMW i4 eDrive40 2022";
      case VehicleType.hondaE2021:
        return "Honda e 2021";
      case VehicleType.gacAionS:
        return "GAC Aion S";
      case VehicleType.jeepRenegade4xePlugInhybrid2021:
        return "Jeep Renegade 4xe Plug-In Hybrid 2021";
      case VehicleType.nissanLeaf2022:
        return "Nissan LEAF 2022";
      case VehicleType.lucidMotorsLucidAir:
        return "Lucid Motors Lucid Air";
      case VehicleType.citroenEJumpy:
        return "Citroën e-Jumpy";
      case VehicleType.volvoXc40Recharge2021:
        return "Volvo XC40 Recharge 2021";
      case VehicleType.volvoXc90RechargePlugInhybrid2021:
        return "Volvo XC90 Recharge Plug-In Hybrid 2021";
      case VehicleType.volvoXc90RechargePlugInhybrid2022:
        return "Volvo XC90 Recharge Plug-In Hybrid 2022";
      case VehicleType.volvoXc60RechargePlugInhybrid2021:
        return "Volvo XC60 Recharge Plug-in Hybrid 2021";
      case VehicleType.volvoS90RechargePlugInhybrid2021:
        return "Volvo S90 Recharge Plug-In Hybrid 2021";
      case VehicleType.volvoS90RechargePlugInhybrid2022:
        return "Volvo S90 Recharge Plug-In Hybrid 2022";
      case VehicleType.bydHan:
        return "BYD Han";
      case VehicleType.mercedesEqa300:
        return "Mercedes EQA 300";
      case VehicleType.mercedesEqs450Plus:
        return "Mercedes EQS 450+";
      case VehicleType.geelyGeometryC:
        return "Geely Geometry C";
      case VehicleType.skywellEt5:
        return "Skywell ET5";
      case VehicleType.porscheTaycan2022:
        return "Porsche Taycan 2022";
      case VehicleType.hozonNezhaU:
        return "Hozon Nezha U";
    }
  }
}

extension ManufacturerByType on VehicleType {
  Manufacturer get manufacturer {
    switch (this) {
      case VehicleType.nissanLeaf:
        return Manufacturer.nissan;
      case VehicleType.chevroletVolt:
        return Manufacturer.chevrolet;
      case VehicleType.teslaModelS:
        return Manufacturer.tesla;
      case VehicleType.mitsubishiIMiev:
        return Manufacturer.mitsubishi;
      case VehicleType.fordFocusElectric:
        return Manufacturer.ford;
      case VehicleType.priusPlugInhybrid:
        return Manufacturer.toyota;
      case VehicleType.fordFusionEnergi:
        return Manufacturer.ford;
      case VehicleType.toyotaRav4Ev:
        return Manufacturer.toyota;
      case VehicleType.hondaAccordPlugIn:
        return Manufacturer.honda;
      case VehicleType.smartFortwoEd:
        return Manufacturer.smart;
      case VehicleType.chevroletSparkEv:
        return Manufacturer.chevrolet;
      case VehicleType.bmwI3:
        return Manufacturer.bmw;
      case VehicleType.fiat500e:
        return Manufacturer.other;
      case VehicleType.cadillacElr:
        return Manufacturer.other;
      case VehicleType.eGolf:
        return Manufacturer.volkswagen;
      case VehicleType.audiA3ETron:
        return Manufacturer.audi;
      case VehicleType.mercedesB250e:
        return Manufacturer.mercedes;
      case VehicleType.kiaSoulEv:
        return Manufacturer.kia;
      case VehicleType.opelAmpera:
        return Manufacturer.opel;
      case VehicleType.zoe:
        return Manufacturer.other;
      case VehicleType.kangooZE:
        return Manufacturer.other;
      case VehicleType.twizy:
        return Manufacturer.other;
      case VehicleType.bydE6:
        return Manufacturer.byd;
      case VehicleType.outlanderPlugInhybrid:
        return Manufacturer.mitsubishi;
      case VehicleType.porscheCayenneSEHybrid:
        return Manufacturer.porsche;
      case VehicleType.x5Xdrive40ePlugInhybrid:
        return Manufacturer.other;
      case VehicleType.a3SportbackETron:
        return Manufacturer.other;
      case VehicleType.xc90RechargePlugInhybrid:
        return Manufacturer.volvo;
      case VehicleType.teslaModelX:
        return Manufacturer.tesla;
      case VehicleType.nissanENv200:
        return Manufacturer.nissan;
      case VehicleType.chevroletVoltGen2:
        return Manufacturer.chevrolet;
      case VehicleType.nissanLeaf2016:
        return Manufacturer.nissan;
      case VehicleType.bmw330ePlugInhybrid:
        return Manufacturer.bmw;
      case VehicleType.mercedesC350ePlugInhybrid:
        return Manufacturer.mercedes;
      case VehicleType.chevroletBoltEv:
        return Manufacturer.chevrolet;
      case VehicleType.toyotaPriusPrime:
        return Manufacturer.toyota;
      case VehicleType.volvoV60RechargePlugInhybrid:
        return Manufacturer.volvo;
      case VehicleType.hyundaiIoniqElectric:
        return Manufacturer.hyundai;
      case VehicleType.hondaClarityPlugInhybrid:
        return Manufacturer.honda;
      case VehicleType.teslaModel3:
        return Manufacturer.tesla;
      case VehicleType.eGolf2017:
        return Manufacturer.volkswagen;
      case VehicleType.soulEv2018:
        return Manufacturer.kia;
      case VehicleType.nissanLeaf2017:
        return Manufacturer.nissan;
      case VehicleType.nissanLeaf2018:
        return Manufacturer.nissan;
      case VehicleType.bmw225xePlugInhybrid:
        return Manufacturer.bmw;
      case VehicleType.bmwI32018:
        return Manufacturer.bmw;
      case VehicleType.jaguarIPace:
        return Manufacturer.other;
      case VehicleType.hyundaiKonaElectric2019:
        return Manufacturer.hyundai;
      case VehicleType.volvoV90PlugInhybrid:
        return Manufacturer.volvo;
      case VehicleType.nissanLeaf2019:
        return Manufacturer.nissan;
      case VehicleType.other:
        return Manufacturer.other;
      case VehicleType.xiaopengXpengG3:
        return Manufacturer.other;
      case VehicleType.lifan330:
        return Manufacturer.other;
      case VehicleType.bydYuan:
        return Manufacturer.byd;
      case VehicleType.geelyLynkAndCo01:
        return Manufacturer.other;
      case VehicleType.changanBenniEStar:
        return Manufacturer.other;
      case VehicleType.mercedesE350e:
        return Manufacturer.mercedes;
      case VehicleType.opelAmperaE:
        return Manufacturer.opel;
      case VehicleType.mercedesSls:
        return Manufacturer.mercedes;
      case VehicleType.bydTang:
        return Manufacturer.byd;
      case VehicleType.mercedesBClass:
        return Manufacturer.mercedes;
      case VehicleType.bydDenza:
        return Manufacturer.byd;
      case VehicleType.mclarenP1:
        return Manufacturer.other;
      case VehicleType.smartEqForfour:
        return Manufacturer.smart;
      case VehicleType.bjevEuSeries:
        return Manufacturer.other;
      case VehicleType.mercedesAECell:
        return Manufacturer.mercedes;
      case VehicleType.jacIev7s:
        return Manufacturer.jac;
      case VehicleType.mitsubishiMinicabMiev:
        return Manufacturer.mitsubishi;
      case VehicleType.bydQin:
        return Manufacturer.byd;
      case VehicleType.bydQinPro:
        return Manufacturer.byd;
      case VehicleType.smartFortwoEdW453:
        return Manufacturer.smart;
      case VehicleType.songPro:
        return Manufacturer.other;
      case VehicleType.nissanSylphy:
        return Manufacturer.nissan;
      case VehicleType.lrRangeRover:
        return Manufacturer.other;
      case VehicleType.jacIev7s2:
        return Manufacturer.jac;
      case VehicleType.mercedesC300e:
        return Manufacturer.mercedes;
      case VehicleType.ladaElKalina:
        return Manufacturer.other;
      case VehicleType.cheryEq:
        return Manufacturer.other;
      case VehicleType.kiaNiroEv2019:
        return Manufacturer.kia;
      case VehicleType.audiETron2019:
        return Manufacturer.audi;
      case VehicleType.harleyDavidsonLivewire:
        return Manufacturer.other;
      case VehicleType.volkswagenEGolf2018:
        return Manufacturer.volkswagen;
      case VehicleType.volkswagenEGolf2019:
        return Manufacturer.volkswagen;
      case VehicleType.porscheTaycan2020:
        return Manufacturer.porsche;
      case VehicleType.kiaSoulEv2019:
        return Manufacturer.kia;
      case VehicleType.zeroDsr:
        return Manufacturer.other;
      case VehicleType.hondaE2020:
        return Manufacturer.honda;
      case VehicleType.mercedesEqc400:
        return Manufacturer.mercedes;
      case VehicleType.kiaSoulEv2020:
        return Manufacturer.kia;
      case VehicleType.teslaModelY:
        return Manufacturer.tesla;
      case VehicleType.peugeotE2008:
        return Manufacturer.other;
      case VehicleType.volvoS60RechargePlugInhybrid2019:
        return Manufacturer.volvo;
      case VehicleType.landRoverRangeRoverSportPlugInhybrid2020:
        return Manufacturer.other;
      case VehicleType.toyotaPriusPrime2020:
        return Manufacturer.toyota;
      case VehicleType.miniCooperSe2020:
        return Manufacturer.other;
      case VehicleType.miniCountrymanPlugInhybrid2020:
        return Manufacturer.other;
      case VehicleType.bmwI32019:
        return Manufacturer.bmw;
      case VehicleType.bmwI32020:
        return Manufacturer.bmw;
      case VehicleType.polestar2:
        return Manufacturer.other;
      case VehicleType.chevroletBoltEv2020:
        return Manufacturer.chevrolet;
      case VehicleType.kiaNiroEv2020:
        return Manufacturer.kia;
      case VehicleType.hyundaiKonaElectric2020:
        return Manufacturer.hyundai;
      case VehicleType.hyundaiIoniqElectric2020:
        return Manufacturer.hyundai;
      case VehicleType.hyundaiIoniqElectric2019:
        return Manufacturer.hyundai;
      case VehicleType.audiETronsportback:
        return Manufacturer.audi;
      case VehicleType.eGoLife:
        return Manufacturer.other;
      case VehicleType.fordMustangMachE2021:
        return Manufacturer.ford;
      case VehicleType.toyotaRav4Prime2021:
        return Manufacturer.toyota;
      case VehicleType.nissanLeaf2020:
        return Manufacturer.nissan;
      case VehicleType.bmwCEvolution:
        return Manufacturer.bmw;
      case VehicleType.skodaSuperbIv:
        return Manufacturer.other;
      case VehicleType.audiA7PlugInhybrid:
        return Manufacturer.audi;
      case VehicleType.miniCooperSe2021:
        return Manufacturer.other;
      case VehicleType.volkswagenId3:
        return Manufacturer.volkswagen;
      case VehicleType.volkswagenEGolf2020:
        return Manufacturer.volkswagen;
      case VehicleType.mercedesGlc300e:
        return Manufacturer.mercedes;
      case VehicleType.hyundaiKonaElectric2021:
        return Manufacturer.hyundai;
      case VehicleType.mazdaMx30:
        return Manufacturer.other;
      case VehicleType.volvoV60RechargePlugInhybrid2020:
        return Manufacturer.volvo;
      case VehicleType.mercedesEqv:
        return Manufacturer.mercedes;
      case VehicleType.bmw330ePlugInhybrid2020:
        return Manufacturer.bmw;
      case VehicleType.smartEqFortwo:
        return Manufacturer.smart;
      case VehicleType.bentleyBentaygaHybrid:
        return Manufacturer.other;
      case VehicleType.volkswagenELavida:
        return Manufacturer.volkswagen;
      case VehicleType.volkswagenId4:
        return Manufacturer.volkswagen;
      case VehicleType.mercedesGle350PlugInhybrid:
        return Manufacturer.mercedes;
      case VehicleType.volkswagenPassatSportscombiGtePlugInhybrid:
        return Manufacturer.volkswagen;
      case VehicleType.porscheTaycan2021:
        return Manufacturer.porsche;
      case VehicleType.avtovazLadaEllada:
        return Manufacturer.other;
      case VehicleType.mercedesGla250e:
        return Manufacturer.mercedes;
      case VehicleType.nissanLeaf2021:
        return Manufacturer.nissan;
      case VehicleType.audiETron2020:
        return Manufacturer.audi;
      case VehicleType.audiETron2021:
        return Manufacturer.audi;
      case VehicleType.bydEv360:
        return Manufacturer.byd;
      case VehicleType.audiETrongt2021:
        return Manufacturer.audi;
      case VehicleType.aiwaysU52021:
        return Manufacturer.other;
      case VehicleType.landRoverRangeRoverPlugInhybrid2021:
        return Manufacturer.other;
      case VehicleType.renaultMeganeETechplugInhybrid:
        return Manufacturer.other;
      case VehicleType.audiETrongt2022:
        return Manufacturer.audi;
      case VehicleType.audiQ4ETron2021:
        return Manufacturer.audi;
      case VehicleType.audiETronsportback2021:
        return Manufacturer.audi;
      case VehicleType.cupraFormentorPlugInhybrid:
        return Manufacturer.other;
      case VehicleType.kiaNiroEv2021:
        return Manufacturer.kia;
      case VehicleType.bmwI32021:
        return Manufacturer.bmw;
      case VehicleType.bmwIx2021:
        return Manufacturer.bmw;
      case VehicleType.bmwI4Edrive402022:
        return Manufacturer.bmw;
      case VehicleType.hondaE2021:
        return Manufacturer.honda;
      case VehicleType.gacAionS:
        return Manufacturer.other;
      case VehicleType.jeepRenegade4xePlugInhybrid2021:
        return Manufacturer.other;
      case VehicleType.nissanLeaf2022:
        return Manufacturer.nissan;
      case VehicleType.lucidMotorsLucidAir:
        return Manufacturer.other;
      case VehicleType.citroenEJumpy:
        return Manufacturer.other;
      case VehicleType.volvoXc40Recharge2021:
        return Manufacturer.volvo;
      case VehicleType.volvoXc90RechargePlugInhybrid2021:
        return Manufacturer.volvo;
      case VehicleType.volvoXc90RechargePlugInhybrid2022:
        return Manufacturer.volvo;
      case VehicleType.volvoXc60RechargePlugInhybrid2021:
        return Manufacturer.volvo;
      case VehicleType.volvoS90RechargePlugInhybrid2021:
        return Manufacturer.volvo;
      case VehicleType.volvoS90RechargePlugInhybrid2022:
        return Manufacturer.volvo;
      case VehicleType.bydHan:
        return Manufacturer.byd;
      case VehicleType.mercedesEqa300:
        return Manufacturer.mercedes;
      case VehicleType.mercedesEqs450Plus:
        return Manufacturer.mercedes;
      case VehicleType.geelyGeometryC:
        return Manufacturer.other;
      case VehicleType.skywellEt5:
        return Manufacturer.other;
      case VehicleType.porscheTaycan2022:
        return Manufacturer.porsche;
      case VehicleType.hozonNezhaU:
        return Manufacturer.other;
      case VehicleType.unknown:
        return Manufacturer.other;
    }
  }
}

extension IntValue on VehicleType {
  int get value {
    switch (this) {
      case VehicleType.unknown:
        return 0;
      case VehicleType.nissanLeaf:
        return 1;
      case VehicleType.chevroletVolt:
        return 2;
      case VehicleType.teslaModelS:
        return 4;
      case VehicleType.mitsubishiIMiev:
        return 5;
      case VehicleType.fordFocusElectric:
        return 7;
      case VehicleType.priusPlugInhybrid:
        return 9;
      case VehicleType.fordFusionEnergi:
        return 13;
      case VehicleType.toyotaRav4Ev:
        return 14;
      case VehicleType.hondaAccordPlugIn:
        return 15;
      case VehicleType.smartFortwoEd:
        return 16;
      case VehicleType.chevroletSparkEv:
        return 17;
      case VehicleType.bmwI3:
        return 18;
      case VehicleType.fiat500e:
        return 20;
      case VehicleType.cadillacElr:
        return 22;
      case VehicleType.eGolf:
        return 23;
      case VehicleType.audiA3ETron:
        return 24;
      case VehicleType.mercedesB250e:
        return 33;
      case VehicleType.kiaSoulEv:
        return 34;
      case VehicleType.opelAmpera:
        return 36;
      case VehicleType.zoe:
        return 38;
      case VehicleType.kangooZE:
        return 40;
      case VehicleType.twizy:
        return 41;
      case VehicleType.bydE6:
        return 42;
      case VehicleType.outlanderPlugInhybrid:
        return 44;
      case VehicleType.porscheCayenneSEHybrid:
        return 46;
      case VehicleType.x5Xdrive40ePlugInhybrid:
        return 49;
      case VehicleType.a3SportbackETron:
        return 50;
      case VehicleType.xc90RechargePlugInhybrid:
        return 51;
      case VehicleType.teslaModelX:
        return 52;
      case VehicleType.nissanENv200:
        return 53;
      case VehicleType.chevroletVoltGen2:
        return 54;
      case VehicleType.nissanLeaf2016:
        return 57;
      case VehicleType.bmw330ePlugInhybrid:
        return 59;
      case VehicleType.mercedesC350ePlugInhybrid:
        return 61;
      case VehicleType.chevroletBoltEv:
        return 63;
      case VehicleType.toyotaPriusPrime:
        return 64;
      case VehicleType.volvoV60RechargePlugInhybrid:
        return 65;
      case VehicleType.hyundaiIoniqElectric:
        return 68;
      case VehicleType.hondaClarityPlugInhybrid:
        return 74;
      case VehicleType.teslaModel3:
        return 75;
      case VehicleType.eGolf2017:
        return 77;
      case VehicleType.soulEv2018:
        return 78;
      case VehicleType.nissanLeaf2017:
        return 80;
      case VehicleType.nissanLeaf2018:
        return 81;
      case VehicleType.bmw225xePlugInhybrid:
        return 82;
      case VehicleType.bmwI32018:
        return 86;
      case VehicleType.jaguarIPace:
        return 88;
      case VehicleType.hyundaiKonaElectric2019:
        return 89;
      case VehicleType.volvoV90PlugInhybrid:
        return 90;
      case VehicleType.nissanLeaf2019:
        return 91;
      case VehicleType.other:
        return 99;
      case VehicleType.xiaopengXpengG3:
        return 113;
      case VehicleType.lifan330:
        return 133;
      case VehicleType.bydYuan:
        return 135;
      case VehicleType.geelyLynkAndCo01:
        return 152;
      case VehicleType.changanBenniEStar:
        return 154;
      case VehicleType.mercedesE350e:
        return 156;
      case VehicleType.opelAmperaE:
        return 163;
      case VehicleType.mercedesSls:
        return 172;
      case VehicleType.bydTang:
        return 175;
      case VehicleType.mercedesBClass:
        return 206;
      case VehicleType.bydDenza:
        return 207;
      case VehicleType.mclarenP1:
        return 221;
      case VehicleType.smartEqForfour:
        return 234;
      case VehicleType.bjevEuSeries:
        return 239;
      case VehicleType.mercedesAECell:
        return 245;
      case VehicleType.jacIev7s:
        return 250;
      case VehicleType.mitsubishiMinicabMiev:
        return 255;
      case VehicleType.bydQin:
        return 257;
      case VehicleType.bydQinPro:
        return 261;
      case VehicleType.smartFortwoEdW453:
        return 265;
      case VehicleType.songPro:
        return 274;
      case VehicleType.nissanSylphy:
        return 288;
      case VehicleType.lrRangeRover:
        return 290;
      case VehicleType.jacIev7s2:
        return 305;
      case VehicleType.mercedesC300e:
        return 307;
      case VehicleType.ladaElKalina:
        return 318;
      case VehicleType.cheryEq:
        return 329;
      case VehicleType.kiaNiroEv2019:
        return 331;
      case VehicleType.audiETron2019:
        return 332;
      case VehicleType.harleyDavidsonLivewire:
        return 334;
      case VehicleType.volkswagenEGolf2018:
        return 336;
      case VehicleType.volkswagenEGolf2019:
        return 337;
      case VehicleType.porscheTaycan2020:
        return 338;
      case VehicleType.kiaSoulEv2019:
        return 339;
      case VehicleType.zeroDsr:
        return 343;
      case VehicleType.hondaE2020:
        return 345;
      case VehicleType.mercedesEqc400:
        return 346;
      case VehicleType.kiaSoulEv2020:
        return 347;
      case VehicleType.teslaModelY:
        return 352;
      case VehicleType.peugeotE2008:
        return 360;
      case VehicleType.volvoS60RechargePlugInhybrid2019:
        return 366;
      case VehicleType.landRoverRangeRoverSportPlugInhybrid2020:
        return 368;
      case VehicleType.toyotaPriusPrime2020:
        return 370;
      case VehicleType.miniCooperSe2020:
        return 375;
      case VehicleType.miniCountrymanPlugInhybrid2020:
        return 376;
      case VehicleType.bmwI32019:
        return 377;
      case VehicleType.bmwI32020:
        return 378;
      case VehicleType.polestar2:
        return 384;
      case VehicleType.chevroletBoltEv2020:
        return 387;
      case VehicleType.kiaNiroEv2020:
        return 388;
      case VehicleType.hyundaiKonaElectric2020:
        return 389;
      case VehicleType.hyundaiIoniqElectric2020:
        return 390;
      case VehicleType.hyundaiIoniqElectric2019:
        return 391;
      case VehicleType.audiETronsportback:
        return 394;
      case VehicleType.eGoLife:
        return 396;
      case VehicleType.fordMustangMachE2021:
        return 398;
      case VehicleType.toyotaRav4Prime2021:
        return 399;
      case VehicleType.nissanLeaf2020:
        return 400;
      case VehicleType.bmwCEvolution:
        return 401;
      case VehicleType.skodaSuperbIv:
        return 403;
      case VehicleType.audiA7PlugInhybrid:
        return 406;
      case VehicleType.miniCooperSe2021:
        return 407;
      case VehicleType.volkswagenId3:
        return 410;
      case VehicleType.volkswagenEGolf2020:
        return 412;
      case VehicleType.mercedesGlc300e:
        return 413;
      case VehicleType.hyundaiKonaElectric2021:
        return 414;
      case VehicleType.mazdaMx30:
        return 419;
      case VehicleType.volvoV60RechargePlugInhybrid2020:
        return 420;
      case VehicleType.mercedesEqv:
        return 428;
      case VehicleType.bmw330ePlugInhybrid2020:
        return 434;
      case VehicleType.smartEqFortwo:
        return 440;
      case VehicleType.bentleyBentaygaHybrid:
        return 441;
      case VehicleType.volkswagenELavida:
        return 446;
      case VehicleType.volkswagenId4:
        return 452;
      case VehicleType.mercedesGle350PlugInhybrid:
        return 453;
      case VehicleType.volkswagenPassatSportscombiGtePlugInhybrid:
        return 460;
      case VehicleType.porscheTaycan2021:
        return 465;
      case VehicleType.avtovazLadaEllada:
        return 468;
      case VehicleType.mercedesGla250e:
        return 469;
      case VehicleType.nissanLeaf2021:
        return 472;
      case VehicleType.audiETron2020:
        return 473;
      case VehicleType.audiETron2021:
        return 474;
      case VehicleType.bydEv360:
        return 475;
      case VehicleType.audiETrongt2021:
        return 476;
      case VehicleType.aiwaysU52021:
        return 478;
      case VehicleType.landRoverRangeRoverPlugInhybrid2021:
        return 484;
      case VehicleType.renaultMeganeETechplugInhybrid:
        return 488;
      case VehicleType.audiETrongt2022:
        return 492;
      case VehicleType.audiQ4ETron2021:
        return 504;
      case VehicleType.audiETronsportback2021:
        return 508;
      case VehicleType.cupraFormentorPlugInhybrid:
        return 524;
      case VehicleType.kiaNiroEv2021:
        return 526;
      case VehicleType.bmwI32021:
        return 549;
      case VehicleType.bmwIx2021:
        return 566;
      case VehicleType.bmwI4Edrive402022:
        return 567;
      case VehicleType.hondaE2021:
        return 569;
      case VehicleType.gacAionS:
        return 578;
      case VehicleType.jeepRenegade4xePlugInhybrid2021:
        return 581;
      case VehicleType.nissanLeaf2022:
        return 598;
      case VehicleType.lucidMotorsLucidAir:
        return 599;
      case VehicleType.citroenEJumpy:
        return 600;
      case VehicleType.volvoXc40Recharge2021:
        return 616;
      case VehicleType.volvoXc90RechargePlugInhybrid2021:
        return 622;
      case VehicleType.volvoXc90RechargePlugInhybrid2022:
        return 623;
      case VehicleType.volvoXc60RechargePlugInhybrid2021:
        return 625;
      case VehicleType.volvoS90RechargePlugInhybrid2021:
        return 630;
      case VehicleType.volvoS90RechargePlugInhybrid2022:
        return 631;
      case VehicleType.bydHan:
        return 655;
      case VehicleType.mercedesEqa300:
        return 657;
      case VehicleType.mercedesEqs450Plus:
        return 659;
      case VehicleType.geelyGeometryC:
        return 660;
      case VehicleType.skywellEt5:
        return 668;
      case VehicleType.porscheTaycan2022:
        return 669;
      case VehicleType.hozonNezhaU:
        return 671;
    }
  }
}
