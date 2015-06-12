angular.module('HueThesis').directive 'bulb', ( $hue ) ->
    restrict : 'C'
    scope :
        light : "="
        listenTo : "="
    link: ( scope, element, attrs ) ->
        console.log "keks"

        getStyleFromState = ( state ) ->

            payload =
                x   : state.xy[ 0 ]
                y   : state.xy[ 1 ]
                bri : state.bri / 255

            rgb = $hue.xyBriToRgb payload

            for k,v of rgb
                rgb[ k ] = Math.round( 255 * v )


            "background-color: rgb(#{ rgb.r },#{ rgb.g },#{ rgb.b })"



        scope.$watch 'light', ( newValue ) ->
            if newValue
                attrs.$set 'style', getStyleFromState newValue.state
