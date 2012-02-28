/**
 * @author fernando
 */
jQuery(function() {
    jQuery(".pagination a").live("click", function() {
        jQuery(".pagination").html("<div style='text-align:center;'><img src='../images/indicator.gif' /></div>");
        jQuery.setFragment({ "page" : jQuery.queryString(this.href).page });
        return false;
    });

    jQuery.fragmentChange(true);
    jQuery(document).bind("fragmentChange.page", function() {
        jQuery.getScript(jQuery.queryString(document.location.href, { "page" : jQuery.fragment().page }));
    });

    if (jQuery.fragment().page) {
        jQuery(document).trigger("fragmentChange.page");
    }

});