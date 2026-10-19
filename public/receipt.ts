"use strict";

import { Request } from 'express';
import mysqlConn from "../model/mysqlConn";
import { NotFoundError } from "../lib/errors";

export default async function receiptPage( request : Request ) {
    const connection = await mysqlConn.getConnection();

    const [ rows ] =  await connection.query( `SELECT so.supplier_order_id, COALESCE( SUM( i.quantity * i.unit_price ), 0 ) AS total FROM supplier_orders so LEFT JOIN supplier_order_items i ON i.supplier_order_id = so.supplier_order_id WHERE so.supplier_order_id = ? GROUP BY so.supplier_order_id`, [ request.params.id ] );

    connection.release();

    if ( ( rows as any[] ).length === 0 )
        throw new NotFoundError( 'Order not found' );

    return `
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <title>Receipt #${ request.params.id }</title>
      </head>
      <body>
        <p>✅</p>
        <p>Order #${ request.params.id } successful!</p>
        <p>Thank you!</p>
        <p>Total: ${ Number( rows[ 0 ].total ).toFixed( 2 ) }€</p>
      
        <div class="tenor-gif-embed" data-postid="11018268193256850941" data-share-method="host" data-aspect-ratio="0.56338" data-width="30%"><a href="https://tenor.com/view/horse-silly-tongue-horse-tongue-horse-silly-gif-11018268193256850941">Horse Silly GIF</a>from <a href="https://tenor.com/search/horse-gifs">Horse GIFs</a></div> <script type="text/javascript" async src="https://tenor.com/embed.js"></script>
      </body>
      </html>
      `

}