"use strict";

import buildOrderFilters from "../components/addToCart/buildOrderFilters";
import addToCartHandler from "../components/addToCart/addToCartHandler";
import renderCartHandler from "../components/cart/renderCartHandler";
import { findAll } from "../model/mysqlQuery";
import { Parts } from "../types/types";
import { Request } from 'express';

export default async function orderPage( request : Request ) {

      const parts : Parts[] = await findAll(
          `SELECT p.part_id, p.part_name, p.part_type FROM parts p JOIN suppliers s ON s.supplier_id = p.supplier_id WHERE s.supplier_id = ? ORDER BY p.part_type, p.part_name`,
         [ Number( request.params.supplier_id ) ] );

      return `
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <title>Order</title>
      </head>
      <body>
        <h1>Hello from node!</h1>
        <form method="POST" action="" id="addToCart">
            
            ${ buildOrderFilters( parts ) }
        
        <button type="button" id="add-to-cart">Add to cart</button>
        <ul id="cart"></ul>
        
        <button type="submit">Payment</button>
        </form>
      </body>
      <script type="module">
        ${ addToCartHandler( parts ) }
        ${ renderCartHandler() }
      </script>
      </html>
      `

}