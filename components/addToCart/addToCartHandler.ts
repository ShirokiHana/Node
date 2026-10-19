"use strict";

import { Parts } from "../../types/types";

export default function( parts : Parts[] ) { return `
    const parts = ${ JSON.stringify( parts ) };
    const typeSelect = document.querySelector( '#part_type' );
    const partSelect = document.querySelector( '#part_id' );
  
    const updateParts = () => {
          partSelect.innerHTML = parts
            .filter( part => part.part_type === typeSelect.value )
            .map( part => '<option value="' + part.part_id + '">' + part.part_name + '</option>' )
            .join( '' );
          };
  
    typeSelect.addEventListener( 'change', updateParts, false );
    updateParts();
    `
}
