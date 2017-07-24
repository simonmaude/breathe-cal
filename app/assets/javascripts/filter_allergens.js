// show the checkboxes associated with the visible allergens after clicking on the anchor tag "Filter Allergens"

function showFilterCheckboxes() {
    $('#sidebar-favorite').hide();
    $('#sidebar-filter').show();
    window.fetchMarkers();
}

function filter() {
    filtered_allergens = {}
    $('.filter_checkbox:checked').each(function() {
        filtered_allergens[$(this).val()] = 1
    });
    window.fetchMarkers(filtered_allergens)
}
