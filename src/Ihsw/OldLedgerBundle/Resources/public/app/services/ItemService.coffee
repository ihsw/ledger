service = ($http, $window) ->
    R = $window.Routing
    S = {}

    # properties
    S.list = {}

    # functions
    S.create = (item) ->
        $http.post(R.generate('item_create', { collectionId: item.collection.id }), item).then (response) ->
            item = response.data
            S.list[item.id] = item

            return item
    S.delete = (item) ->
        $http.delete(R.generate('item_delete', { itemId: item.id })).then (response) ->
            delete S.list[item.id]
    S.get = (itemId) ->
        $http.get(R.generate('item_show', { itemId: itemId })).then (response) ->
            item = response.data
            S.list[item.id] = item
            return item
    S.update = (item, newItem) ->
        $http.put(R.generate('item_update', { itemId: item.id }), newItem).then (response) ->
            item = response.data
            S.list[item.id] = item
            return item

    return S
service.$inject = ['$http', '$window']
window.module.service 'ItemService', service