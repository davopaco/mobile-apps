import Item from "../model/item/Item";
import axios from "axios";
import { Articles } from "../model/interfaces/APIItem";

export default class ItemRepository {
  public async getAllItems(): Promise<Item[]> {
    try {
      const response = await axios.get(
        "https://api.npoint.io/88abc1f40845fe530fd4"
      );

      const articulos: Articles = response.data;
      const items: Item[] = [];

      articulos.articulos.forEach((articulo) => {
        items.push(
          new Item(
            articulo.precio,
            articulo.articulo,
            articulo.descuento,
            articulo.urlimagen,
            articulo.valoracion,
            articulo.calificaciones,
            articulo.calificaciones
          )
        );
      });

      return items;
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async getSaleItems(): Promise<Item[]> {
    try {
      const allItems = await this.getAllItems();
      const saleItems: Item[] = [];

      allItems.forEach((item) => {
        if (parseInt(item.getDiscount()) > 0) {
          saleItems.push(item);
        }
      });

      return saleItems;
    } catch (error) {
      console.error(error);
      return [];
    }
  }
}
