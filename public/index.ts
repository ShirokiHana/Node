"use strict";

import { Request } from 'express';
import { findAll } from "../model/mysqlQuery";
import { Supplier } from "../types/types";

const page =  0;
const suppliers : Supplier[] = await findAll( `SELECT supplier_id, supplier_name FROM suppliers LIMIT 5 OFFSET ${ page }` );

// SELECT SUPPLIER PAGE, PRG REQUEST DATA TO LIST, CART PAGE
export default function supplierPage( _request : Request ) {
    return `
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <title>Order</title>
      </head>
      <body>
        <form method="POST" action="">
        
        <label for="">
          Supplier:
          <select name="supplier_id" id="supplier_id">
            ${ suppliers.map( entry => `<option value="${ entry.supplier_id }">${ entry.supplier_name }</option>` ).join( '' ) }
          </select>
        </label>
        
        <button type="submit">Make order</button>
        </form>
      </body>
      <script type="module" src="">
      
      </script>
      </html>
      `

}