"use strict";

// Stage data array.
// Stage // option
export default function( data : string[], option : string, selected : string ) {
    return `
        <label>
            <select name="${ option }" id="${ option }">
                ${ data.map( ( element ) => 
                    `<option value="${ element }" ${ selected === element ? 'selected' : '' }>${ element }</option>` 
                    ).join( '' )
                }
            </select>
        </label>
    `
}