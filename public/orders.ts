"use strict";

import { Request } from 'express';
import {findAll} from "../model/mysqlQuery";
import {escapeHTML} from "../helper/espaceHTML";

    // TODO: Query?
    const STATUSES = [ 'pending', 'received', 'cancelled' ];

    const dateOrNull = ( value: unknown ) =>
        typeof value === 'string' && /^\d{4}-\d{2}-\d{2}$/.test( value ) ? value : null;

    function ucFirstLetter( value : string ) {
        return String( value ).charAt( 0 ).toUpperCase() + String( value ).slice( 1 );
    }

export default async function ordersPage( request : Request ) : Promise<string> {
    const supplier_id = Number( request.params.supplier_id ) || null;
    const status = STATUSES.includes( String( request.query.status ) )
        ? String( request.query.status )
        : null;

    const from = dateOrNull( request.query.from );
    const to = dateOrNull( request.query.to );

    const suppliers = await findAll( "SELECT supplier_id, supplier_name FROM suppliers ORDER BY supplier_name" );

    const orders = await findAll(
        `SELECT o.supplier_order_id, o.issued_at, o.expected_arrival_at, o.status, s.supplier_name
         FROM supplier_orders o
         JOIN suppliers s ON s.supplier_id = o.supplier_id
         WHERE ( ? IS NULL OR o.supplier_id = ? )
           AND ( ? IS NULL OR o.status = ? )
           AND ( ? IS NULL OR o.issued_at >= ? )
           AND ( ? IS NULL OR o.issued_at < DATE_ADD( ?, INTERVAL 1 DAY ) )
         ORDER BY o.issued_at DESC, o.supplier_order_id DESC`,
        [ supplier_id, supplier_id, status, status, from, from, to, to ]
    );

    const supplierOptions = suppliers.map( ( supplier: any ) =>
        `<option value="${ Number( supplier.supplier_id ) }" ${ supplier.supplier_id === supplier_id ? 'selected' : '' }>${ escapeHTML( supplier.supplier_name ) }</option>`
    ).join( '' );

    const statusOptions = STATUSES.map( supplier =>
        `<option value="${ supplier }" ${ supplier === status ? 'selected' : '' }>${ ucFirstLetter( supplier ) }</option>`
    ).join( '' );

    const rows = orders.length
        ? orders.map( ( order : any ) => `
            <tr>
                <td><a href="/restock/orders/${ Number( order.supplier_order_id ) }">#${ Number( order.supplier_order_id ) }</a></td>
                <td>${ escapeHTML( order.supplier_name ) }</td>
                <td>${ escapeHTML( String( order.issued_at ) ) }</td>
                <td>${ escapeHTML( String( order.expected_arrival_at ?? '' ) ) }</td>
                <td>${ escapeHTML( order.status ) }</td>
            </tr>`).join( '' )
        : '<tr><td colspan="5">No orders found.</td></tr>';

    return `<!doctype html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <title>Supplier orders</title>
            </head>
            <body>
                <h1>Supplier orders</h1>
                <form method="get" action="/restock/orders">
                    <select name="supplier_id">
                        <option value="">All suppliers</option>
                        ${ supplierOptions }
                    </select>
                    <select name="status">
                        <option value="">All statuses</option>
                        ${ statusOptions }
                    </select>
                    <input type="date" name="from" value="${ from ?? '' }">
                    <input type="date" name="to" value="${ to ?? '' }">
                    <button type="submit">Filter</button>
                    <a href="/restock/orders">Reset</a>
                </form>
                <table>
                    <thead>
                        <tr>
                            <th>Order</th>
                            <th>Supplier</th>
                            <th>Issued</th>
                            <th>Expected</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>${ rows }</tbody>
                </table>
            </body>
            </html>`;
}