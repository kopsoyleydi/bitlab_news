let password = document.getElementById("password");
let emailMes = document.getElementById("emailMes");
let btn = document.getElementById("sign");

btn.addEventListener("click", function (event){
    function validate(){
        if(password.value.length >= 7){
            btn.type = "submit";
        }
        else{
            emailMes.innerHTML = "Write more eight letters";
            btn.type = "button";
        }
    }
    validate();
});


