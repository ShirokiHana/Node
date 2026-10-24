"use strict";

import { execute, findAll, findBy, partial } from "../model/mysqlQuery";
import express from "express";
import errorBubble from "../lib/errorBubble";
import {modifyRequestBody, reshapeSupplier} from "../middleware/reshapeData";
import validateId from "../middleware/validateId";
import {validateSupplier} from "../middleware/validateRequest";
import { NotFoundError } from "../lib/errors";

const supplierRouter = express.Router();

// --------Functions

const getSuppliers = partial(
    () => findAll( 'SELECT supplier_id, supplier_name FROM suppliers' )
);

const getSuppliersById = partial(
    request =>
        findBy( 'SELECT supplier_id, supplier_name FROM suppliers WHERE supplier_id = ?', request.params.id )
);

const createSupplier = partial(
    async ( { body } ) => {
        const { insertedId } = await execute(
            'INSERT INTO suppliers ( supplier_name ) VALUES ( ? )',
            [ body.supplier_name ]
        );

        return {
            supplier_id: insertedId,
            supplier_name: body.supplier_name
        }
    }, 201
)

const updateSupplier = partial(
    async ( { params, body } ) => {
        const supplier_id = Number( params.id );

        enforceValidSupplier( await execute(
            'UPDATE suppliers SET supplier_name = ? WHERE supplier_id = ?',
            [ body.supplier_name, supplier_id ]
        ) );

        return {
            supplier_id,
            supplier_name: body.supplier_name
        }
    }, 201
)

const deleteSupplier = partial(
    async ( { params } ) : Promise<void> => {

        enforceValidSupplier( await execute(
            'DELETE FROM suppliers WHERE supplier_id = ?',
            [ params.id ]
        ) );
    }, 204
)

const getSupplierParts = partial(
    (request) =>
        findAll(
            `SELECT part_id, part_name, part_type, price
             FROM parts
             WHERE supplier_id = ?
             ORDER BY part_type, part_name`,
            [ Number( request.params.id ) ]
        )
);

// --------Guards

// list comprehension guard
const enforceValidSupplier = ( result : { affectedRows : number } ) => {
    if ( result.affectedRows === 0 )
        throw new NotFoundError( 'Supplier not found' );
    return result;
}

// --------Helpers

const supplierBody = [
    modifyRequestBody( reshapeSupplier ), validateSupplier
];

// --------Routing

supplierRouter.route( '/' )
    .get( getSuppliers )
    .post( ...supplierBody, createSupplier )
;

supplierRouter.route( '/:id' )
    .get( validateId(), getSuppliersById )
    .put( validateId(), ...supplierBody, updateSupplier )
    .delete( validateId(), deleteSupplier )
;

supplierRouter.route('/:id/parts')
    .get( validateId(), getSupplierParts )
;

// --------Error Bubbling
supplierRouter.use( errorBubble );

export default supplierRouter;