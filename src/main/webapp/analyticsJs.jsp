<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.fssa.proplan.model.Budget"%>
<%@page import="com.fssa.proplan.model.BudgetCategory"%>
<%@page import="java.util.ArrayList"%>
<script>

console.log("hgiv");
<%Budget budget = (Budget) session.getAttribute("budget");

double budgetAmount = 0;
ArrayList<BudgetCategory> budgetCategories = new ArrayList<BudgetCategory>();

if (budget != null) {
	budgetAmount = budget.getBudgetAmount();
	budgetCategories = (ArrayList) budget.getBudgetCategory();
}
Calendar cal = Calendar.getInstance();
String currentMonth = new SimpleDateFormat("MMMMMMMMMMM").format(cal.getTime());%>

//Viewing the income and expense details...while clicking----------------

const expense_details_div = document.querySelectorAll(
".expense_category_details"
);
const expense_category_header = document.querySelectorAll(
".expense_category_header"
);

expense_category_header.forEach((e, i) => {

e.addEventListener("click", (el) => {
 expense_details_div[i].classList.toggle("view");
});
});

const income_details_div = document.querySelectorAll(
".income_category_details"
);
const income_category_header = document.querySelectorAll(
".income_category_header"
);

income_category_header.forEach((e, i) => {

e.addEventListener("click", (el) => {

 income_details_div[i].classList.toggle("view");
});
});



const act_user = JSON.parse(localStorage.getItem("active_user"));

//Total graph in th analytics page----------

var xValues = [
"01/01",
"02/01",
"03/01",
"05/01",
"06/01",
"06/01",
"08/01",
"12/01",
"15/01",
"17/01",
"19/01",
"22/01",
"24/01",
"26/01",
"27/01",
"28/01",
];
var yValues = [
4000, 5000, 5000, 2500, 2000, 2000, 500, 1000, 2000, 1000, 1000, 2000, 2000,
1000, 2000, 0,
];
const zValues = [4000, 2000, 2500, 2000, 2000];
var barColors = [
"#f3d251",
"#f3d251",
"#f78787",
"#f78787",
"#f78787",
"#f78787",
"#f78787",
"#f78787",
"#f3d251",
"#f78787",
"#f78787",
"#f78787",
"#f3d251",
"#f78787",
"#f78787",
"#f78787",
];

new Chart("total_graph", {
type: "line",
data: {
 labels: xValues,
 datasets: [
   {
     // backgroundColor:"rgba(0,0,255,1.0)",
     borderColor: "#fe7676",
     data: yValues,
     fill: false,
   },
   {
     // backgroundColor:"rgba(0,0,255,1.0)",
     borderColor: "#f4cf28",
     data: zValues,
     fill: false,
   },
 ],
},
options: {
 legend: { display: false },
 title: {
   display: true,
   text: "Statistics on day to day Expenses - JAN 2023",
 },
},
});

//Category wise expense pie chart---------------

let categorynames = []
let categorybarColors = []
let categoryvalues=[]
<%
String[] chartColors =  {
"#a179bf",
"#fe7676",
"#f4cf28",
"#5dbeaa",
"#6fa6df",
"#603cb5",
"#0075a4",
"#ed7226",
"#c8a4b6",
"#a0a0a0",
"#1f7043",
"#72b037",
"#c1bb7f",
"#7e7e7c",
"#b9614c",
};

%>


<%int y = 0;
for (BudgetCategory budgetCategory : budgetCategories) {%>
categorynames.push("<%=budgetCategory.getCategoryName()%>");
categoryvalues.push(<%=budgetCategory.getAmountSpent()%>);
categorybarColors.push("<%=chartColors[y]%>");
<%y++;
}%>

console.log(categoryvalues,categorybarColors,categorynames);
new Chart("categorychart", {
type: "pie",
data: {
 labels: categorynames,
 datasets: [
   {
     backgroundColor: categorybarColors,
     data: categoryvalues,
   },
 ],
},
options: {
 legend: { display: false },
 title: {
   display: true,
   text: "Category wise expenses of <%=currentMonth%> 2023",
 },
},
});

//category list details  with different colors expense and income----------=================


const expense_category_details = document.querySelector(
  ".expense_category_chart .category_lists"
);

<%for (int i = 0; i < budgetCategories.size(); i++) {

%>
console.log("<%=chartColors[i]%>");
  expense_category_details.innerHTML += `
    <div class="category_list">
           <div class="category_color color_1" style="background-color:<%=chartColors[i]%>;"></div>
           <p><%=budgetCategories.get(i).getCategoryName()%> <span class="expense_category_value">&#8377; <%=budgetCategories.get(i).getAmountSpent()%> /-</span></p>
    </div>
    `;

<%}%>


</script>