import 'package:get/get.dart';

enum L10n {
  about,
  access,
  actions,
  addHomeCharger,
  addNewLocation,
  addPlug,
  addScreenshot,
  addStation,
  addStationType,
  addToFavourites,
  addVehicle,
  address,
  allCheckins,
  amenities,
  appTitle,
  areStationsInUse,
  badFormat,
  camping,
  chargeme,
  chargingNow,
  checkIn,
  checkins,
  choose,
  chooseAmenitiesPresentOnThisLocation,
  chooseLocation,
  chooseVehicle,
  close,
  comment,
  commentOnly,
  contactUs,
  coolStation,
  copiedToClipboard,
  costAndPricing,
  costDescription,
  couldNotCharge,
  create,
  deleteAccount,
  description,
  details,
  dining,
  done,
  duration,
  edit,
  editLocation,
  editStations,
  email,
  empty,
  emptyFavouritesSubtitle,
  emptyFavouritesTitle,
  enterAddress,
  enterCodeFromSms,
  enterDescription,
  enterName,
  enterPhoneNumber,
  enterSmsCode,
  enterValidPhoneNumber,
  enterYourPhoneNumber,
  evParking,
  favourites,
  forNext,
  free,
  getDirections,
  getSmsCode,
  goToProfile,
  grocery,
  hello,
  hiking,
  homeCharger,
  hours,
  hoursLowercased,
  isCheckedInHere,
  isThisLocationRestricted,
  joinChargemeCummunityForFree,
  limitOfPhotosReached,
  loading,
  location,
  locationComingSoon,
  locationIsActive,
  locationIsSuccessfullySet,
  locationOpenOrActive,
  lodging,
  logOut,
  longTapOnMapToPlaceAMarker,
  maxKwhh,
  minutes,
  myVehicle,
  name,
  nice,
  no,
  noAddedStations,
  open247,
  outlet,
  park,
  parking,
  phoneNumber,
  photosAdded,
  placesAdded,
  plugs,
  power,
  private,
  public,
  publish,
  register,
  removeFromFavourites,
  reportABug,
  requiresFee,
  restrooms,
  save,
  selectIcon,
  selectPlug,
  send,
  shopping,
  signIn,
  signInWithGoogle,
  station,
  stations,
  successfulltyCharged,
  successfullySet,
  targetlocation,
  theFormatIsOk,
  totalCheckins,
  unknownUser,
  unknownVehicle,
  unsuccessfullSignIn,
  update,
  valetParking,
  vehicle,
  waitingForCharge,
  wifi,
  withWord,
  workingHours,
  writeAnyCommentsOrSuggestionsDirectlyToDevelopers,
  yes,
  yourProfile,
  yourStatistics,
  yourStuff,
}

extension GetString on L10n {
  String get str {
    if (Get.deviceLocale?.languageCode == "ru") {
      switch (this) {
        case L10n.about:
          return "О приложении";
        case L10n.access:
          return "Доступ";
        case L10n.actions:
          return "Действия";
        case L10n.addHomeCharger:
          return "Добавить домашнюю зарядку";
        case L10n.addNewLocation:
          return "Новая локация";
        case L10n.addPlug:
          return "Добавить разъем";
        case L10n.addScreenshot:
          return "Добавить скриншот";
        case L10n.addStation:
          return "Добавить станцию";
        case L10n.addStationType:
          return "Добавить станцию";
        case L10n.addToFavourites:
          return "Добавить в избранное";
        case L10n.addVehicle:
          return "Добавить автомобиль";
        case L10n.address:
          return "Адрес";
        case L10n.allCheckins:
          return "Все чек-ины";
        case L10n.amenities:
          return "Удобства";
        case L10n.appTitle:
          return "ChargeMe";
        case L10n.areStationsInUse:
          return "Станции введены в эксплуатацию (не на ремонте)";
        case L10n.badFormat:
          return "Неверный формат";
        case L10n.camping:
          return "Кемпинг";
        case L10n.chargeme:
          return "ChargeMe";
        case L10n.chargingNow:
          return "Зарядка сейчас";
        case L10n.checkIn:
          return "Чек-ин";
        case L10n.checkins:
          return "Чек-ины";
        case L10n.choose:
          return "Выбрать";
        case L10n.chooseAmenitiesPresentOnThisLocation:
          return "Выберите удобсва на этой локации";
        case L10n.chooseLocation:
          return "Выбрать локацию";
        case L10n.chooseVehicle:
          return "Выбрать автомобиль";
        case L10n.close:
          return "Закрыть";
        case L10n.comment:
          return "Комментарий";
        case L10n.commentOnly:
          return "Оставить комментарий";
        case L10n.contactUs:
          return "Связаться с нами";
        case L10n.coolStation:
          return "";
        case L10n.copiedToClipboard:
          return "Скопировано в буфер обмена";
        case L10n.costAndPricing:
          return "Цена";
        case L10n.costDescription:
          return "Описание цены";
        case L10n.couldNotCharge:
          return "Не удалось зарядиться";
        case L10n.create:
          return "Создать";
        case L10n.deleteAccount:
          return "Удалить аккаунт";
        case L10n.description:
          return "Описание";
        case L10n.details:
          return "О станции";
        case L10n.dining:
          return "Питание";
        case L10n.done:
          return "Готово";
        case L10n.duration:
          return "Длительность";
        case L10n.edit:
          return "Редактировать";
        case L10n.editLocation:
          return "Редактировать локацию";
        case L10n.editStations:
          return "Редактировать станции";
        case L10n.email:
          return "Почта";
        case L10n.empty:
          return "Пусто";
        case L10n.emptyFavouritesSubtitle:
          return "Просматривайте карту, чтобы найти места и добавить их в избранное";
        case L10n.emptyFavouritesTitle:
          return "Список пуст.";
        case L10n.enterAddress:
          return "Введите адрес локации (либо он установится сам при установки геолокации)";
        case L10n.enterCodeFromSms:
          return "Введите код из SMS";
        case L10n.enterDescription:
          return "Введите описание для локации";
        case L10n.enterName:
          return "Введите название локации";
        case L10n.enterPhoneNumber:
          return "Введите номер телефона, по которому можно обратиться в случае поломки станций";
        case L10n.enterSmsCode:
          return "Введите SMS код";
        case L10n.enterValidPhoneNumber:
          return "Введите правильный номер телефона";
        case L10n.enterYourPhoneNumber:
          return "Введите ваш номер телефона";
        case L10n.evParking:
          return "Парковка для электромобилей";
        case L10n.favourites:
          return "Избранное";
        case L10n.forNext:
          return "в течение следующих";
        case L10n.free:
          return "Бесплатно";
        case L10n.getDirections:
          return "Построить маршрут";
        case L10n.getSmsCode:
          return "Получить SMS код";
        case L10n.goToProfile:
          return "Перейти в профиль";
        case L10n.grocery:
          return "Продукты";
        case L10n.hello:
          return "";
        case L10n.hiking:
          return "Место для прогулки";
        case L10n.homeCharger:
          return "Домашняя зарядка";
        case L10n.hours:
          return "Часы работы";
        case L10n.hoursLowercased:
          return "часов";
        case L10n.isCheckedInHere:
          return "зачек-инен здесь";
        case L10n.isThisLocationRestricted:
          return "Эта локация приватная";
        case L10n.joinChargemeCummunityForFree:
          return "Присоединиться к ChargeMe бесплатно";
        case L10n.limitOfPhotosReached:
          return "Достигнут лимит фотографий";
        case L10n.loading:
          return "Загрузка";
        case L10n.location:
          return "Геолокация";
        case L10n.locationComingSoon:
          return "Место будет доступно в будущем";
        case L10n.locationIsActive:
          return "Место активно";
        case L10n.locationIsSuccessfullySet:
          return "Локация успешно установлена";
        case L10n.locationOpenOrActive:
          return "Локация уже открыта/доступна";
        case L10n.lodging:
          return "Ночллег";
        case L10n.logOut:
          return "Выйти";
        case L10n.longTapOnMapToPlaceAMarker:
          return "Зажмите место на карте, чтобы поставить пин";
        case L10n.maxKwhh:
          return "Макс Квт/ч";
        case L10n.minutes:
          return "минут";
        case L10n.myVehicle:
          return "Мой автомобиль";
        case L10n.name:
          return "Название";
        case L10n.nice:
          return "Найс";
        case L10n.no:
          return "Нет";
        case L10n.noAddedStations:
          return "Нет станций";
        case L10n.open247:
          return "Круглосуточно";
        case L10n.outlet:
          return "Разъем";
        case L10n.park:
          return "Парк";
        case L10n.parking:
          return "Парковка";
        case L10n.phoneNumber:
          return "Номер телефона";
        case L10n.photosAdded:
          return "Добавлено фото";
        case L10n.placesAdded:
          return "Добавлено мест";
        case L10n.plugs:
          return "Разъемы";
        case L10n.power:
          return "Мощность";
        case L10n.private:
          return "Приватная";
        case L10n.public:
          return "Публичная";
        case L10n.publish:
          return "Опубликовать";
        case L10n.register:
          return "Зарегистрироваться";
        case L10n.removeFromFavourites:
          return "Удалить из избранного";
        case L10n.reportABug:
          return "Сообщить об ошибке";
        case L10n.requiresFee:
          return "Платно";
        case L10n.restrooms:
          return "Туалеты";
        case L10n.save:
          return "Сохранить";
        case L10n.selectIcon:
          return "Выберите иконку";
        case L10n.selectPlug:
          return "Выбрать разъем";
        case L10n.send:
          return "Отправить";
        case L10n.shopping:
          return "Магазины";
        case L10n.signIn:
          return "Войти";
        case L10n.signInWithGoogle:
          return "Войти с Google";
        case L10n.station:
          return "Станция";
        case L10n.stations:
          return "Станции";
        case L10n.successfulltyCharged:
          return "Успешная зарядка";
        case L10n.successfullySet:
          return "Успешно установлено";
        case L10n.targetlocation:
          return "";
        case L10n.theFormatIsOk:
          return "Подходящий формат";
        case L10n.totalCheckins:
          return "Количество чек-инов";
        case L10n.unknownUser:
          return "Неизвестно";
        case L10n.unknownVehicle:
          return "Неизвестно";
        case L10n.unsuccessfullSignIn:
          return "Неуспешный вход";
        case L10n.update:
          return "Обновить";
        case L10n.valetParking:
          return "Услуги парковщика";
        case L10n.vehicle:
          return "Автомобиль";
        case L10n.waitingForCharge:
          return "Жду зарядки";
        case L10n.wifi:
          return "Wi-Fi";
        case L10n.withWord:
          return "с";
        case L10n.workingHours:
          return "Часы работы";
        case L10n.writeAnyCommentsOrSuggestionsDirectlyToDevelopers:
          return "Пишите любые комментарии или предложения напрямую разработчикам";
        case L10n.yes:
          return "Да";
        case L10n.yourProfile:
          return "Ваш профиль";
        case L10n.yourStatistics:
          return "Ваша статистика";
        case L10n.yourStuff:
          return "О Вас";
      }
    } else {
      switch (this) {
        case L10n.about:
          return "About";
        case L10n.access:
          return "Access";
        case L10n.actions:
          return "Actions";
        case L10n.addHomeCharger:
          return "Add home charger";
        case L10n.addNewLocation:
          return "New location";
        case L10n.addPlug:
          return "Add plug";
        case L10n.addScreenshot:
          return "Add photo";
        case L10n.addStation:
          return "Add station";
        case L10n.addStationType:
          return "Add station type";
        case L10n.addToFavourites:
          return "Add to favourites";
        case L10n.addVehicle:
          return "Add vehicle";
        case L10n.address:
          return "Address";
        case L10n.allCheckins:
          return "All checkins";
        case L10n.amenities:
          return "Amenities";
        case L10n.appTitle:
          return "ChargeMe";
        case L10n.areStationsInUse:
          return "Are stations already in use (not under repair)?";
        case L10n.badFormat:
          return "Bad format";
        case L10n.camping:
          return "Camping";
        case L10n.chargeme:
          return "ChargeMe";
        case L10n.chargingNow:
          return "Charging now";
        case L10n.checkIn:
          return "Check in";
        case L10n.checkins:
          return "Checkins";
        case L10n.choose:
          return "Choose";
        case L10n.chooseAmenitiesPresentOnThisLocation:
          return "Choose amenities present on this location";
        case L10n.chooseLocation:
          return "Choose location";
        case L10n.chooseVehicle:
          return "Choose vehicle";
        case L10n.close:
          return "Close";
        case L10n.comment:
          return "Comment";
        case L10n.commentOnly:
          return "Comment only";
        case L10n.contactUs:
          return "Contact us";
        case L10n.coolStation:
          return "Cool station";
        case L10n.copiedToClipboard:
          return "Copied to clipboard";
        case L10n.costAndPricing:
          return "Cost and Pricing";
        case L10n.costDescription:
          return "Cost description";
        case L10n.couldNotCharge:
          return "Could not charge";
        case L10n.create:
          return "Create";
        case L10n.deleteAccount:
          return "Delete account";
        case L10n.description:
          return "Description";
        case L10n.details:
          return "Details";
        case L10n.dining:
          return "Dining";
        case L10n.done:
          return "Done";
        case L10n.duration:
          return "Duration";
        case L10n.edit:
          return "Edit";
        case L10n.editLocation:
          return "Edit location";
        case L10n.editStations:
          return "Edit stations";
        case L10n.email:
          return "Email";
        case L10n.empty:
          return "Empty";
        case L10n.emptyFavouritesSubtitle:
          return "Browse map to find places and add them to favourites";
        case L10n.emptyFavouritesTitle:
          return "The list is empty.";
        case L10n.enterAddress:
          return "Enter address of the location (or it will be automatically set when the geolocation is set)";
        case L10n.enterCodeFromSms:
          return "Enter code from SMS";
        case L10n.enterDescription:
          return "Enter description for the location";
        case L10n.enterName:
          return "Enter name of the location";
        case L10n.enterPhoneNumber:
          return "Enter phone number which could be used if stations are broken";
        case L10n.enterSmsCode:
          return "Enter SMS code";
        case L10n.enterValidPhoneNumber:
          return "Enter valid phone number";
        case L10n.enterYourPhoneNumber:
          return "Enter your phone number";
        case L10n.evParking:
          return "EV Parking";
        case L10n.favourites:
          return "Favourites";
        case L10n.forNext:
          return "for next";
        case L10n.free:
          return "Free";
        case L10n.getDirections:
          return "Get directions";
        case L10n.getSmsCode:
          return "Get SMS code";
        case L10n.goToProfile:
          return "Go to profile";
        case L10n.grocery:
          return "Grocery";
        case L10n.hello:
          return "hello";
        case L10n.hiking:
          return "Hiking";
        case L10n.homeCharger:
          return "Home charger";
        case L10n.hours:
          return "Hours";
        case L10n.hoursLowercased:
          return "hours";
        case L10n.isCheckedInHere:
          return "is checked in here";
        case L10n.isThisLocationRestricted:
          return "Is this location restricted";
        case L10n.joinChargemeCummunityForFree:
          return "Join ChargeMe cummunity for free";
        case L10n.limitOfPhotosReached:
          return "Limit of photos reached";
        case L10n.loading:
          return "Loading";
        case L10n.location:
          return "Location";
        case L10n.locationComingSoon:
          return "Location coming soon";
        case L10n.locationIsActive:
          return "Location is Active";
        case L10n.locationIsSuccessfullySet:
          return "Location is successfully set";
        case L10n.locationOpenOrActive:
          return "Location Open/Active";
        case L10n.lodging:
          return "Lodging";
        case L10n.logOut:
          return "Log out";
        case L10n.longTapOnMapToPlaceAMarker:
          return "Long tap on map to place a marker";
        case L10n.maxKwhh:
          return "Max kWh/h";
        case L10n.minutes:
          return "minutes";
        case L10n.myVehicle:
          return "My vehicle";
        case L10n.name:
          return "Name";
        case L10n.nice:
          return "Nice";
        case L10n.no:
          return "No";
        case L10n.noAddedStations:
          return "No added stations";
        case L10n.open247:
          return "Open 24/7";
        case L10n.outlet:
          return "Outlet";
        case L10n.park:
          return "Park";
        case L10n.parking:
          return "Parking";
        case L10n.phoneNumber:
          return "Phone number";
        case L10n.photosAdded:
          return "Photos added";
        case L10n.placesAdded:
          return "Places added";
        case L10n.plugs:
          return "Plugs";
        case L10n.power:
          return "Power";
        case L10n.private:
          return "Private";
        case L10n.public:
          return "Public";
        case L10n.publish:
          return "Publish";
        case L10n.register:
          return "Register";
        case L10n.removeFromFavourites:
          return "Remove from favourites";
        case L10n.reportABug:
          return "Report a bug";
        case L10n.requiresFee:
          return "Requires fee";
        case L10n.restrooms:
          return "Restrooms";
        case L10n.save:
          return "Save";
        case L10n.selectIcon:
          return "Select Icon";
        case L10n.selectPlug:
          return "Select plug";
        case L10n.send:
          return "Send";
        case L10n.shopping:
          return "Shopping";
        case L10n.signIn:
          return "Sign in";
        case L10n.signInWithGoogle:
          return "Sign in with Google";
        case L10n.station:
          return "Station";
        case L10n.stations:
          return "Stations";
        case L10n.successfulltyCharged:
          return "Successfullty charged";
        case L10n.successfullySet:
          return "Successfully set";
        case L10n.targetlocation:
          return "targetLocation";
        case L10n.theFormatIsOk:
          return "The format is OK";
        case L10n.totalCheckins:
          return "Total check-ins";
        case L10n.unknownUser:
          return "Unknown user";
        case L10n.unknownVehicle:
          return "Unknown vehicle";
        case L10n.unsuccessfullSignIn:
          return "Unsuccessfull sign in";
        case L10n.update:
          return "Update";
        case L10n.valetParking:
          return "Valet parking";
        case L10n.vehicle:
          return "Vehicle";
        case L10n.waitingForCharge:
          return "Waiting for charge";
        case L10n.wifi:
          return "Wi-Fi";
        case L10n.withWord:
          return "with";
        case L10n.workingHours:
          return "Working hours";
        case L10n.writeAnyCommentsOrSuggestionsDirectlyToDevelopers:
          return "Write any comments or suggestions directly to developers";
        case L10n.yes:
          return "Yes";
        case L10n.yourProfile:
          return "Your profile";
        case L10n.yourStatistics:
          return "Your statistics";
        case L10n.yourStuff:
          return "Your stuff";
      }
    }
  }
}