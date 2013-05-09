module = window.module
module.service 'ItemService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing

    @query = () ->
        $http.get(Routing.generate('items')).then (response) ->
            @items = response.data
            return @items
    @create = (item) ->
        $http.post(Routing.generate('item_create'), item).then (response) ->
            item = response.data
            @items[item.id] = item
    @delete = (item) ->
        $http.delete(Routing.generate('item_delete', { itemId: item.id })).then (response) ->
            delete @items[item.id]

    return @
]
module.service 'EntryService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing

    @query = () ->
        $http.get(Routing.generate('entries')).then (response) ->
            @entries = response.data
            for entryId, entry of @entries
                entry['occurred_at'] = new Date entry['occurred_at']
                @entries[entryId] = entry
            return @entries
    @create = (entry) ->
        $http.post(Routing.generate('entry_create'), entry).then (response) ->
            entry = response.data
            entry['occurred_at'] = new Date entry['occurred_at']
            @entries[entry.id] = entry

    return @
]