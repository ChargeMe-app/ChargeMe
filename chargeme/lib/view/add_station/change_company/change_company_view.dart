import 'package:chargeme/components/helpers/limitator.dart';
import 'package:chargeme/components/telegram_bot/telegram_bot.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/company.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeCompanyView extends StatefulWidget {
  @override
  _ChangeCompanyView createState() => _ChangeCompanyView();
}

class _ChangeCompanyView extends State<ChangeCompanyView> {
  final _controller = TextEditingController();
  final _limitator = LimitatorCooldown(exponential: true);
  List<Company> get sortedCompanies {
    final companies = Company.values.toList();
    companies.sort((a, b) => a.title.compareTo(b.title));
    return companies;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddStationViewModel>(
        builder: (context, addStationVM, child) => Scaffold(
            appBar: AppBar(
              title: Text("Company"),
              backgroundColor: ColorPallete.violetBlue,
              actions: [
                CupertinoButton(
                    child:
                        Center(child: Text(L10n.reset.str, style: const TextStyle(color: Colors.white, fontSize: 16))),
                    onPressed: () => addStationVM.company = null)
              ],
            ),
            body: ListView(children: [
              const SizedBox(height: 12),
              Text("Выберите оператора, через приложение которого запускается зарядная сессия",
                  textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(height: 0.5, color: ColorPallete.violetBlue),
              Column(
                  children: List.generate(sortedCompanies.length, (i) {
                final company = sortedCompanies[i];
                final isSelected = addStationVM.company == company;
                return Container(
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: ColorPallete.violetBlue))),
                    child: ListTile(
                        title: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [Text(company.title)]),
                        trailing: isSelected
                            ? const SizedBox(width: 24, child: Icon(CupertinoIcons.check_mark))
                            : Container(width: 24),
                        selected: isSelected,
                        selectedColor: ColorPallete.violetBlue,
                        onTap: () {
                          addStationVM.company = company;
                        }));
              })),
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(children: [
                    Text(
                        "Если нужного оператора нет в списке, напишите его название ниже и отправьте нам. Мы добавим его в список уже в следующем обновлении :)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        maxLength: 64,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Имя компании или ссылка на приложение",
                        )),
                    const SizedBox(height: 12),
                    SimpleButton(
                        color: ColorPallete.violetBlue,
                        text: L10n.send.str,
                        onPressed: () {
                          _limitator.tryExec(() {
                            TelegramBot.shared.sendFeedback("[Request Operator]: ${_controller.text}", []);
                            setState(() {
                              _controller.text = "";
                            });
                          });
                        })
                  ])),
            ])));
  }
}
