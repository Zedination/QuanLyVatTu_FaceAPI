
<div class="body">
<style>
.body{
	font-family: 'Open Sans',sans-serif;
	background-color: black;
}
#container{
	width: 1000px;
	height: 550px;
	background-image: linear-gradient(rgba(0,0,0,0.3),rgba(0,0,0,0.3)), url(bgImg.jpg);
	margin: 20px auto;	
}
#calculator{
	width: 320px;
	height: 520px;
	background-color: #eaedef;
	margin: 0 auto;
	border-radius: 5px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	box-sizing: unset;
	-webkit-box-sizing: unset;
}
#result{
	height: 120px;
}
#history{
	text-align: right;
	height: 20px;
	margin: 0 20px;
	padding-top: 20px;
	font-size: 15px;
	color: #919191;
}
#output{
	text-align: right;
	height: 60px;
	margin: 10px 20px;
	font-size: 30px;
}
#keyboard{
	height: 400px;
}
.operator, .number, .empty{
	width: 50px;
	height: 50px;
	margin: 15px;
	float: left;
	border-radius: 50%;
	border-width: 0;
	font-weight: bold;
	font-size: 15px;
}
.number, .empty{
	background-color: #eaedef;
}
.number, .operator{
	cursor: pointer;
}
.operator:active, .number:active{
	font-size: 13px;
}
.operator:focus, .number:focus, .empty:focus{
	outline: 0;
}
.btc:nth-child(4){
	font-size: 20px;
	background-color: #20b2aa;
}
.btc:nth-child(8){
	font-size: 20px;
	background-color: #ffa500;
}
.btc:nth-child(12){
	font-size: 20px;
	background-color: #f08080;
}
.btc:nth-child(16){
	font-size: 20px;
	background-color: #7d93e0;
}
.btc:nth-child(20){
	font-size: 20px;
	background-color: #9477af;
}

</style>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:600,700" rel="stylesheet">
<style>

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
    width: 100%;
  height: 100%; 
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: auto; /* Could be more or less, depending on screen size */
}


/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
</style>
</head>
<body>
<div id="id01" class="modal">
  
  
    <div id="calculator" class="modal-content animate">
        <div id="result">
            <div id="history">
                <p id="history-value"></p>
            </div>
            <div id="output">
                <p id="output-value"></p>
            </div>
        </div>
        <div id="keyboard">
            <input type="button"class="operator btc" value="C" id="clear">
            <input type="button" class="operator btc" value="CE" id="backspace">
            <input type="button" class="operator btc" value="%" id="%">
            <input type="button" class="operator btc" value="&#247;" id="/">
            <input type="button" class="number btc" value="7" id="7">
            <input type="button" class="number btc" value="8" id="8">
            <input type="button" class="number btc" value="9" id="9">
            <input type="button" class="operator btc" value="&times;" id="*">
            <input type="button" class="number btc" value="4" id="4">
            <input type="button" class="number btc" value="5" id="5">
            <input type="button" class="number btc" value="6" id="6">
            <input type="button" class="operator btc" value="-" id="-">
            <input type="button" class="number btc" value="1" id="1">
            <input type="button" class="number btc" value="2" id="2">
            <input type="button" class="number btc" value="3" id="3">
            <input type="button" class="operator btc" value="+" id="+">
            <input type="button" class="empty btc" value="" id="empty">
            <input type="button" class="number btc" value="0" id="0">
            <input type="button" class="empty btc" value="" id="empty">
            <input type="button" class="operator btc" value="=" id="=">
        </div>
    </div>

</div>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
<script>
    function getHistory(){
	return document.getElementById("history-value").innerText;
}
function printHistory(num){
	document.getElementById("history-value").innerText=num;
}
function getOutput(){
	return document.getElementById("output-value").innerText;
}
function printOutput(num){
	if(num==""){
		document.getElementById("output-value").innerText=num;
	}
	else{
		document.getElementById("output-value").innerText=getFormattedNumber(num);
	}	
}
function getFormattedNumber(num){
	if(num=="-"){
		return "";
	}
	var n = Number(num);
	var value = n.toLocaleString("en");
	return value;
}
function reverseNumberFormat(num){
	return Number(num.replace(/,/g,''));
}
var operator = document.getElementsByClassName("operator");
for(var i =0;i<operator.length;i++){
	operator[i].addEventListener('click',function(){
		if(this.id=="clear"){
			printHistory("");
			printOutput("");
		}
		else if(this.id=="backspace"){
			var output=reverseNumberFormat(getOutput()).toString();
			if(output){//if output has a value
				output= output.substr(0,output.length-1);
				printOutput(output);
			}
		}
		else{
			var output=getOutput();
			var history=getHistory();
			if(output==""&&history!=""){
				if(isNaN(history[history.length-1])){
					history= history.substr(0,history.length-1);
				}
			}
			if(output!="" || history!=""){
				output= output==""?output:reverseNumberFormat(output);
				history=history+output;
				if(this.id=="="){
					var result=eval(history);
					printOutput(result);
					printHistory("");
				}
				else{
					history=history+this.id;
					printHistory(history);
					printOutput("");
				}
			}
		}
		
	});
}
var number = document.getElementsByClassName("number");
for(var i =0;i<number.length;i++){
	number[i].addEventListener('click',function(){
		var output=reverseNumberFormat(getOutput());
		if(output!=NaN){ //if output is a number
			output=output+this.id;
			printOutput(output);
		}
	});
}
</script>
</div>