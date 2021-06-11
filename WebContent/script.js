let userSel=document.querySelector("#user");
let prn=document.querySelector(".prn");
userSel.onchange=()=>{
    let user=userSel.value;
    if(user==="Patient"){
		prn.type="text";
		prn.placeholder="Enter your name";
    }
    else{
		prn.type="password";
		prn.placeholder="Enter your password";
    }
}