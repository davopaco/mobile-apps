import 'package:quiz2/a_lista_articulos.dart';
import 'package:quiz2/items_provider.dart';
import 'package:quiz2/model/item.dart';

class ListaArticulos extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getAllItems();

  @override
  final String title = "Lista de Artículos";

  ListaArticulos({super.key});
}
