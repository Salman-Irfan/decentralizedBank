import { dbank_backend } from "../../declarations/dbank_backend";

// we want to add event listener on current balance value change
window.addEventListener("load", async () => {
	// update balance from dbank_backend.check_balance
	const currentAmount = await dbank_backend.checkBalance();
	document.getElementById("value").innerText =
		Math.round(currentAmount * 100) / 100;
});

// add event listener on the form element
document.querySelector("form").addEventListener("submit", async (event) => {
	event.preventDefault();

	// handling button click
	const button = document.querySelector("#submit-btn");

	const inputAmount = parseFloat(
		document.getElementById("input-amount").value
	);
	const oututAmount = parseFloat(
		document.getElementById("withdrawal-amount").value
	);

	// disable button
	button.setAttribute("disabled", true);
	// function calls
  await dbank_backend.topUp(inputAmount);
  await dbank_backend.withdraw(oututAmount);
	// update the balance
	const currentAmount = await dbank_backend.checkBalance();
	document.getElementById("value").innerText =
		Math.round(currentAmount * 100) / 100;

	// reset input field to 0
	document.getElementById("input-amount").value = 0;
	document.getElementById("withdrawal-amount").value = 0;
	button.removeAttribute("disabled");
});
