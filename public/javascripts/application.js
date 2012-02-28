function getScrollY() {
  var scrOfY = 0;
  if( typeof( window.pageYOffset ) == 'number' ) {
    //Netscape compliant
    scrOfY = window.pageYOffset;
  } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
    //DOM compliant
    scrOfY = document.body.scrollTop;
  } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
    //IE6 standards compliant mode
    scrOfY = document.documentElement.scrollTop;
  }
  return scrOfY;
}

function centralizaDivCarregando() {
	jQuery('#carregando').css('display','block');
	jQuery('#carregando').css('top',getScrollY());
	jQuery('#carregando').css('left',screen.availWidth/2 - 150);
}

function retiraDivCarregando() {
	jQuery('#carregando').css('display','none');
}
