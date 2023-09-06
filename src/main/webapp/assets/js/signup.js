
let pass_close_img=document.getElementById("pass_close")
let pass_open_img=document.getElementById("pass_open")

let pass1_input = document.getElementById("password")
let pass2_input = document.getElementById("cpassword")

pass_close_img.addEventListener("click",e=>{
  pass_close_img.style.display="none"
  pass_open_img.style.display="block"
pass1_input.type="text"
pass2_input.type="text"
})
pass_open_img.addEventListener("click",e=>{
  pass_close_img.style.display="block"
  pass_open_img.style.display="none"
pass1_input.type="password"
pass2_input.type="password"
})