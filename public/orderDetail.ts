"use strict";

import { Request } from 'express';
import { findAll, findBy } from "../model/mysqlQuery";
import { escapeHTML } from "../helper/espaceHTML";
import { NotFoundError } from "../lib/errors";

const STATUSES = [ 'pending', 'received', 'cancelled' ];

export default async function orderDetailPage( request : Request ) : Promise<string> {
    const id = Number( request.params.id );

    if ( !Number.isInteger( id ) || id <= 0 )
        throw new NotFoundError( 'Order not found' );

    const order = await findBy(
        `SELECT o.supplier_order_id, o.issued_at, o.expected_arrival_at, o.status, s.supplier_name
         FROM supplier_orders o
         JOIN suppliers s ON s.supplier_id = o.supplier_id
         WHERE o.supplier_order_id = ?`,
        String( id )
    );

    const items = await findAll(
        `SELECT p.part_name, i.quantity, i.unit_price
         FROM supplier_order_items i
         JOIN parts p ON p.part_id = i.part_id
         WHERE i.supplier_order_id = ?
         ORDER BY i.supplier_order_item_id`,
        [ id ]
    );

    const total = items.reduce( ( sum : number, item : any ) => sum + item.quantity * Number( item.unit_price ), 0 );

    const rows = items.length
        ? items.map( ( item : any ) => `
            <tr>
                <td>${ escapeHTML( item.part_name ) }</td>
                <td>${ Number( item.quantity ) }</td>
                <td>${ Number( item.unit_price ).toFixed( 2 ) }€</td>
                <td>${ ( item.quantity * Number( item.unit_price ) ).toFixed( 2 ) }€</td>
            </tr>`).join( '' )
        : '<tr><td colspan="4">No items.</td></tr>';

    const statusOptions = STATUSES.map( status =>
        `<option value="${ status }" ${ status === order.status ? 'selected' : '' }>${ status }</option>`
    ).join( '' );

    return `<!doctype html>
            <html lang="en">
            <head><meta charset="UTF-8"><title>Supplier order #${ id }</title></head>
            <body>
                <h1>Supplier order #${ id }</h1>
                <p>Supplier: ${ escapeHTML( order.supplier_name ) }</p>
                <p>Issued: ${ escapeHTML( String( order.issued_at ) ) }</p>
                <p>Expected: ${ escapeHTML( String( order.expected_arrival_at ?? '' ) ) }</p>

                <form id="status-form" data-id="${ id }">
                    <label>Status
                        <select name="status">${ statusOptions }</select>
                    </label>
                    <button type="submit">Update</button>
                    <span role="status"></span>
                </form>

                <table>
                    <thead><tr><th>Part</th><th>Qty</th><th>Unit price</th><th>Subtotal</th></tr></thead>
                    <tbody>${ rows }</tbody>
                </table>
                <p>Total: ${ total.toFixed( 2 ) }€</p>
                <p><a href="/restock/orders">Back to orders</a></p>
            </body>
            </html>`;
}