console.log('JS is running')

document.addEventListener("DOMContentLoaded", function(event) { 
    // setInterval(function(){
        fetch("home/coins")

        fetch("home/coins")
            .then(response => response.json())
            .then((data) => {
                // I'm assuming you'll have direct access to data instead of res.data here,
                // depending on how your API is structured
               console.log(data)
            });
        console.log('Ran home index')
    //  }, 3000);    
  });