var b = JSON.parse(data);
var keys = Object.keys(b);
var arr = Object.values(b);
var finalArr = [];
arr.forEach((val,index)=>{
  console.log(val.Serial,index)
  finalArr.push({"{#ID}": keys[index],"{#SERIAL}": val.Serial});
})
console.log(finalArr)
return finalArr;
