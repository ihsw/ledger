service = ($http, $window) ->
    R = $window.Routing
    S = {}

    # misc
    initialize = (collection) ->
        items = {}
        for i, item of collection.items
            items[item.id] = item
        collection.items = items

        return collection

    # properties
    S.list = {}

    # methods
    S.query = ->
        S.list = {}

        $http.get(R.generate('collections')).then (response) ->
            for i, collection of response.data
                S.list[collection.id] = initialize collection

            return S.list
    S.create = (collection) ->
        $http.post(R.generate('collection_create'), collection).then (response) ->
            collection = response.data
            S.list[collection.id] = initialize collection

            return collection
    S.delete = (collection) ->
        $http.delete(R.generate('collection_delete', { collectionId: collection.id })).then (response) ->
            delete S.list[collection.id]
    S.get = (collectionId) ->
        $http.get(R.generate('collection_show', { collectionId: collectionId })).then (response) ->
            collection = initialize response.data
            S.list[collection.id] = collection
            return collection
    S.update = (collection, newCollection) ->
        $http.put(R.generate('collection_update', { collectionId: collection.id }), newCollection).then (response) ->
            collection = initialize response.data
            S.list[collection.id] = collection
            return collection

    # utility
    S.onItemDelete = (item) ->
        delete S.list[item.collection.id].items[item.id]

    return S
service.$inject = ['$http', '$window']
window.module.service 'CollectionService', service