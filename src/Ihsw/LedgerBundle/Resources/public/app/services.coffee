module = window.module
Routing = window.Routing
module.service 'ItemService', ['$http', ($http) ->
    @items = []
    @query = () ->
        $http.get(Routing.generate('items')).then (response) ->
            @items = response.data
    @create = (item) ->
        $http.post(Routing.generate('item_create'), item).then (response) ->
            item = response.data
            @items[item.id] = item
    @delete = (item) ->
        $http.delete(Routing.generate('item_delete', { itemId: item.id })).then (response) ->
            delete @items[item.id]

    return @
]