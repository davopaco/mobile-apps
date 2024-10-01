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
      let i = 0;
      articulos.articulos.forEach((articulo) => {
        items.push(
          new Item({
            id: i++,
            name: articulo.articulo,
            price: articulo.precio,
            discount: articulo.descuento,
            imagePath: articulo.urlimagen,
            rating: articulo.valoracion,
            description: articulo.descripcion,
            ratingsQuantity: articulo.calificaciones,
          })
        );
      });

      return items;
    } catch (error) {
      console.error(error);
      return [];
    }
  }

  public async getSaleItems(items: Item[]): Promise<Item[]> {
    try {
      const saleItems: Item[] = [];

      items.forEach((item) => {
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
