function backgroundblur() {
  document.querySelector("header").style.filter = "blur(2.5px)";
  document.querySelector(".left_side").style.filter = "blur(2.5px)";
  document.querySelector(".right_side").style.filter = "blur(2.5px)";
  document.querySelector(".center_side").style.filter = "blur(2.5px)";
}

//      Viewing Income form with categories

//const add_income = document.getElementById("add_income");

//add_income.addEventListener("click", (e) => {
  //const form1 = document.getElementsByClassName("add_income_form");
  //form1[0].classList.add("view");
  //backgroundblur();
//});


// Viewing Expense form with categories

const add_expense = document.getElementById("add_expense");

add_expense.addEventListener("click", (e) => {
  const form1 = document.getElementsByClassName("add_expense_form");
  form1[0].classList.add("view");
  backgroundblur();
});