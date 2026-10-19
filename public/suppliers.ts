"use strict";

// TODO: Bundle scripts, make them map()

import { NextFunction, Request, Response } from 'express';
import { findAll } from "../model/mysqlQuery";
import {escapeHTML} from "../helper/espaceHTML";

interface SupplierRow {
    supplier_id: number;
    supplier_name: string;
}

export default async function suppliersPage( _request : Request ) : Promise<string> {
    const suppliers: SupplierRow[] = await findAll(
        "SELECT supplier_id, supplier_name FROM suppliers ORDER BY supplier_id" // TODO: Dynamic order by
    );

    const rows = suppliers.length
        ? suppliers.map(supplier => `
            <tr>
                <td>${Number( supplier.supplier_id )}</td>
                <td>${escapeHTML( supplier.supplier_name )}</td>
                <td>
                    <form class="supplier-edit-form" data-id="${Number(supplier.supplier_id)}">
                        <input
                            type="text"
                            name="supplier_name"
                            value="${ escapeHTML( supplier.supplier_name ) }"
                            required
                        >
                        <button type="submit">Save</button>
                        <span role="status"></span>
                    </form>
                    <form class="supplier-delete-form" data-id="${ Number( supplier.supplier_id ) }">
                        <button type="submit">Delete</button>
                        <span role="status"></span>
                    </form>
                </td>
            </tr>
        `).join( '' )
        : '<tr><td colspan="3">No suppliers found.</td></tr>';

    return `<!doctype html>
            <html lang="en">
            <head><meta charset="UTF-8"><title>Suppliers</title></head>
            <body>
                <h1>Suppliers</h1>
                
                <form id="supplier-form">
                    <label>
                        Supplier name
                        <input type="text" name="supplier_name" required>
                    </label>
                    <button type="submit">Add supplier</button>
                    <p id="supplier-message" role="status"></p>
                </form>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                             <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>${ rows }</tbody>
                </table>
            </body>
            </html>`;
}