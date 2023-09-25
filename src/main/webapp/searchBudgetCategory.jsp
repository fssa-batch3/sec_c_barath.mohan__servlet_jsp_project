<%@page import="com.fssa.proplan.model.User"%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<%
User user = (User) session.getAttribute("currentuser");
%>
<script>

let searchInput = document.querySelector("#search");
console.log(searchInput.value);
searchInput.addEventListener("keyup", getCategoryDetails);

function getCategoryDetails() {
	console.log("Triggered Function");
	let value=searchInput.value;
	let url = "./CategorySearch";
	axios.get(
		url,
		{
			params: {
				searchValue: value,
				userEmail: "<%=user.getEmailId()%>"
			}
		}
	)
		.then(response => {
			appendDiv(response.data);
			console.log(response.data);
		})

		.catch(error => {
			console.log(error);
		})
}
let categories_data = document.querySelector(".categories_data");
function appendDiv(details){
	console.log("append div function");
	categories_data.innerHTML="";
	details.forEach(e=>{
		let amountSpentBarHeight=0;
		console.log(e["categoryName"]);
		 amountSpentBarHeight = (e["amountSpent"] / e["budgetAmount"]) * 180;
		let barHeight = 180;
		let budgetAmountBarHeight = barHeight;
		if (amountSpentBarHeight > barHeight) {
			budgetAmountBarHeight -= (amountSpentBarHeight - barHeight);
			amountSpentBarHeight = barHeight;

		}
		categories_data.innerHTML+=`
			<div class="cateogory_details">
			<h3>\${e["categoryName"]}</h3>
			<p>
				Budget - <span class="budget_amount"> &#8377;\${e["budgetAmount"]}
					/-
				</span>
			</p>
			<p>
				Spent - <span class="spent_amount">&#8377; \${e["amountSpent"]}
					/-
				</span>
			</p>
			<div class="category_chart">
				<div class="chart_div">
					<p>Budget</p>

					<div class="expenses_allowed"
						style=" height:\${budgetAmountBarHeight}px;"></div>
				</div>
				<div class="chart_div">
					<p>Expense</p>

					<div class="expenses_spent"
						style="height:\${amountSpentBarHeight}px;"></div>
				</div>
			</div>

		</div>
		`
	})

}
</script>