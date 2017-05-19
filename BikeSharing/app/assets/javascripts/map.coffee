jQuery ->
    window.initMap = ->
        if $('#map').size() > 0
            console.log("TOPPPPPPPPPPPPPPPPPPPPPPPP")
            map = new google.maps.Map document.getElementById('map'), {
                center: {lat: -23.5505, lng: -46.6333}
                zoom: 8
            }
            console.log("TOPPPPPPPPPPPPPPPPPPPPPPPP")
