//two separate animation functions, when aimDown completes, calls aimUp and loops through
function animUp() {
     $("#box").animate({
         top: "0px" //animated begins at 0px
     }, 3000, "linear", animDown); //loops through - length of animation and type (swing or linear)
 }

 function animDown() {
     $("#box").animate({
         top: "560px" //ends at 250px from top
     }, 4000, "linear", animUp);
 }

 $(document).ready(function () {
     animDown();
 });
