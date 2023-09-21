
// showing budget form ny click the button

let create_budget = document.getElementById("create_budget")
let create_budget_div = document.querySelector(".budget")
if (create_budget) {

	create_budget.addEventListener("click", e => {
		console.log("df");

		create_budget_div.classList.add("view")

		// backgroundblur()
	})
}



// Each category value--------------


//  NeW BUDGET FORM-----------------

let next_step = document.querySelectorAll(".next_step")
let budget_set = document.querySelector(".budget_set")
let category_create_sec = document.querySelector(".category_create_sec")
let expenses_change_value = document.getElementById("expenses_change_value")
let savings_change_value = document.getElementById("savings_change_value")
let budget_range = document.getElementById("budget_range").value
let pre_value
let ex_percentage
let sav_value
let sav_percentage
let monthly_income
let monthly_income_input = document.getElementById("monthly_income")
next_step[0].addEventListener("click", e => {

	monthly_income = document.getElementById("monthly_income").value

	if (monthly_income > 0) {
		pre_value = (budget_range / 100) * monthly_income
		ex_percentage = ((pre_value / monthly_income) * 100).toFixed(0)
		sav_value = Number(monthly_income) - Number(pre_value)
		sav_percentage = 100 - Number(ex_percentage)
		console.log(sav_value, sav_percentage, "uytfd");
		expenses_change_value.innerHTML = `
        ${ex_percentage}% / ${pre_value} /-
        `
		savings_change_value.innerHTML = `
        ${sav_percentage}% / ${sav_value} /-
        `
		budget_set.classList.add("view")
		next_step[0].classList.add("not_view")
		monthly_income_input.disabled = true
	}
	else {
		swal("Sorry!", "Enter Valid Monthly income", "error");

	}

})

let budget_range_input = document.getElementById("budget_range")
budget_range_input.addEventListener("change", e => {
	let budget_range = document.getElementById("budget_range").value

	pre_value = (budget_range / 100) * monthly_income
	ex_percentage = ((pre_value / monthly_income) * 100).toFixed(0)
	sav_value = Number(monthly_income) - Number(pre_value)
	sav_percentage = 100 - Number(ex_percentage)
	console.log(sav_value, sav_percentage, "uytfd");
	expenses_change_value.innerHTML = `
    ${ex_percentage}% / ${pre_value} /-
    `
	savings_change_value.innerHTML = `
    ${sav_percentage}% / ${sav_value} /-
    `
})
let remaining_amount = document.getElementById("remaining_amount")

next_step[1].addEventListener("click", e => {
	budget_range_input.disabled = true
	category_create_sec.classList.add("view")
	next_step[1].classList.add("not_view")
	remaining_amount.innerHTML = `${pre_value} /-`
})

let add_category_button = document.getElementById("add_category")
let category_create = document.querySelector(".category_create")
add_category_button.addEventListener("click", e => {
	let category_budget = document.querySelectorAll(".budget_value")
	let total_expense_value = 0
	category_budget.forEach(e => {
		total_expense_value += Number(e.value)
	})
	console.log(total_expense_value);
	if (total_expense_value > pre_value) {
		swal("Oops", "The categorised amount overtakes allowed expense amount", "warning")
	}
	else {
		remaining_amount.innerHTML = `${pre_value - total_expense_value} /-`
		let div = `
    <div class="create_category_feild">
                    <input type="text" class="budget_category" placeholder="ex,Shopping.." name="categoryName">
                    <input type="number" class="budget_value" placeholder="ex,4000/-..." name="categoryBudget">
                </div>
    `
		category_create.insertAdjacentHTML('beforeend', div);

	}

})


document.querySelector(".budget").addEventListener("submit", e => {
	let category_budget = document.querySelectorAll(".budget_value")
	let total_expense_value = 0
	category_budget.forEach(e => {
		total_expense_value += Number(e.value)
	})
	if (total_expense_value > pre_value) {
		swal("Oops", "The categorised amount overtakes allowed expense amount", "warning")
		e.preventDefault();
	}

	monthly_income_input.disabled = false;
	budget_range_input.disabled = false;

})


