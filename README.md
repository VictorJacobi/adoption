# Adoption
***

Adoption is a Flutter package that makes it easy to perform navigation, and also helps to display dialog and bottom sheet without context. With Adoption, you can easily keep your code minimal and get outstanding results in your flutter app.

## Installation
To use Adoption in your Flutter project, add adoption as a dependency in your pubspec.yaml file.

```py
dependencies:
  get_it: ^7.2.0
  adoption:
    path: "path to package directory"
```
Then run flutter pub get.
## Usage
To use Adoption, you will need a service locator (either get_it or riverpod) in this case I'll be using get_it.


Here is an example of how to use Adoption:

```js
import 'package:adoption/adoption.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService(navigatorKey: locator<NavigationService>().navigatorKey));
locator.registerLazySingleton(() => DialogService(navigatorKey: locator<NavigationService>().navigatorKey));

}
```
The next step is to set up your bottom sheet and dialog ui like:
```js
void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    BottomSheetType.basic: ({String? title, String? description}) { return
  const SizedBox();
      },
    BottomSheetType.Generic: ({String? title, String? description}) =>
    const SizedBox(),
    BottomSheetType.generateToken: ({String? title, String? description}) => GenerateToken(title: title,description: description,),

  };

  bottomSheetService.setCustomSheetBuilders(builders,);
}
/// Note that you can have as many bottom sheet as you like. Also similar for dialog.

enum BottomSheetType{
  basic,
  Generic,
  generateToken,
}

```
After you have registered all of the services as a lazy singleton, you then call the function in the main file like this:
```js
void main() async{
  setupLocator();
  setupBottomSheetUi();
  setupDialogUi();
  runApp(const child: MyApp());
}
```
Then in the UI you can just call:
```js
  locator<BottomSheetService>().showCustomSheet(variant: BottomSheetType.generateToken,title: 'gdgsgs',description: 'dhsdbdchdjscvadsucvad');
locator<NavigationService>().push(routeWidget);
    locator<DialogService>().showCustomDialog(variant: DialogType.basic,title: 'gdgsgs',description: 'dhsdbdchdjscvadsucvad');

//Note that the title and subtitle are optional.
          
```
## Contributing

We welcome contributions to Adoption! If you have an idea for a new feature or have found a bug, please open an issue or submit a pull request.

## License
Adoption is released under the MIT License.

