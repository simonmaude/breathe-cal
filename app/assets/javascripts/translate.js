function googleTranslateElementInit() {
     new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.HORIZONTAL}, 'google_translate_element');
}
    
function getLanguageSelected(className) {
    var c = document.cookie.split('; '),
    cookies = {}, i, C;
    
    for (i = c.length - 1; i >= 0; i--) {
        C = c[i].split('=');
        cookies[C[0]] = C[1];
        }
    
        return cookies[className];
}
    
// alert(getLanguageSelected('googtrans').substring(4, 6));    
