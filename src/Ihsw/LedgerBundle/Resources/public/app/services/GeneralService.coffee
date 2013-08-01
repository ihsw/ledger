service = ($http, $window) ->
    R = $window.Routing
    S = {}

    # properties

    # functions
    S.summary = ->
        $http.get(R.generate('home_summary')).then (response) ->
            return response.data

    return S
service.$inject = ['$http', '$window']
window.module.service 'GeneralService', service