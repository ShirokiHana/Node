"use strict";

import type { Parts } from "../../types/types";

export default function buildOrderFilters( data : Parts[], selected = data[ 0 ]?.part_type ) : string {

    const types = [ ...new Set( data.map( element => element.part_type ) ) ];
    const partOptions = data.filter( element => element.part_type === selected )

    return `
        <label>
            Type:
            <select id="part_type">
                ${ types.map( type => `<option value="${ type }" ${ type === selected ? 'selected' : '' }>${ type }</option>` )
                    .join( '' ) }
            </select>
        </label>

        <label>
            Part:
            <select name="part_id" id="part_id">
                ${ partOptions.map( element => `<option value="${ element.part_id }">${ element.part_name }</option>` )
                    .join( '' ) }
            </select>
        </label>
    `
}