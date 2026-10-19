"use strict";

/* base case */
/* recursive add + 1 to item id, on add to cart button */
/* render case*/
/* item cart POST submission shape:  */
export default function() { return `
        const foldCart = partIds =>
            partIds.reduce( ( cart, partId ) =>
            cart.some( item => item.part_id === partId )
              ? cart.map( item => item.part_id === partId ? { ...item, quantity: item.quantity + 1 } : item ) 
              : [ ...cart, { part_id: partId, quantity: 1 } ], 
            [] );
        
        const renderCart = ( cart, cartList ) => {
        cartList.innerHTML = cart.map( item => {
        const part = parts.find( p => p.part_id === item.part_id );
            return '<li>' + part.part_name + ' - ' + item.quantity +
                '<input type="hidden" name="quantity[' + item.part_id + ']" value="' + item.quantity + '">' +
              '</li>';
            } ).join( '' );
        };
        
        const cartList = document.querySelector( '#cart' );
        const addedPartIds = [];
        
        document.querySelector( '#add-to-cart' ).addEventListener( 'click', () => {
            if ( !partSelect.value ) return;
            addedPartIds.push( Number( partSelect.value ) );
            renderCart( foldCart( addedPartIds ), cartList );
        } );
    `
}