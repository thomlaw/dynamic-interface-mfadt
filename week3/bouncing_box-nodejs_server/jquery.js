//two separate animation functions, when aimDown completes, calls aimUp and loops through
function animUp() {
     $("#box").animate({
         top: "0px" //animated begins at 0px
     }, 1200, "swing", animDown); //loops through - length of animation and type (swing or linear)
 }

 function animDown() {
     $("#box").animate({
         top: "250px" //ends at 250px from top
     }, 800, "swing", animUp);
 }

 $(document).ready(function () {
     animUp();
 });
