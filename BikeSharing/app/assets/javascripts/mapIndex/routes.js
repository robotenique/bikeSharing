$("#routeFreeBike").click(function(){
    $.ajax({
        url: "/api/tst.json",
        data: "topkek",
        dataType: "json",
    }).done(function(raw_data) {
        console.log(raw_data);
    });


    alert("QUE LOKO TIO..");
});
