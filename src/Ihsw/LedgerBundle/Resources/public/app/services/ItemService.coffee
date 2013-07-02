window.module.service 'ItemService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.list =
        values: {}
        getLength: ->
            size = 0
            entries = S.list.values
            for key, value of entries
                if entries.hasOwnProperty key
                    size++
            return size

    # functions
    S.query = ->
        S.list.values = {}

        $http.get(Routing.generate('items')).then (response) ->
            for i, item of response.data
                S.list.values[item.id] = item

            return S.list
    S.create = (item) ->
        $http.post(Routing.generate('item_create'), item).then (response) ->
            item = response.data
            S.list.values[item.id] = item

            return item
    S.delete = (item) ->
        $http.delete(Routing.generate('item_delete', { itemId: item.id })).then (response) ->
            delete S.list.values[item.id]
    S.get = (itemId) ->
        $http.get(Routing.generate('item_show', { itemId: itemId })).then (response) ->
            item = response.data
            S.list.values[item.id] = item
            return item
    S.update = (item, newItem) ->
        $http.put(Routing.generate('item_update', { itemId: item.id }), newItem).then (response) ->
            item = response.data
            S.list.values[item.id] = item
            return item

    return S
]