module = window.module
module.controller 'ItemController', ['$rootScope', '$timeout', '$scope', 'ItemService', ($rootScope, $timeout, $scope, ItemService) ->
    $rootScope.section = 'items'

    angular.extend $scope, {
        create: () ->
            if @createDisabled
                return
            @createDisabled = true

            ItemService.create({ name: @name }).then (item) =>
                @name = ''
                @itemMetadata[item.id] = { deleteDisabled: false }
                @createDisabled = false
        delete: (item) ->
            if !@itemMetadata[item.id].deleteDisabled
                @itemMetadata[item.id].deleteDisabled = true

                ItemService.delete(item).then () =>
                    delete @itemMetadata[item.id]
        refresh: () ->
            @loading = true
            @createDisabled = false

            ItemService.query().then (items) =>
                @loading = false
                @items = items

                itemMetadata = {}
                for itemId, item of items
                    itemMetadata[itemId] = { deleteDisabled: false }
                @itemMetadata = itemMetadata
    }
    $scope.refresh()
]
module.controller 'HomeController', ['$rootScope', ($rootScope) ->
    $rootScope.section = 'home'
]
module.controller 'EntryController', ['$rootScope', '$scope', 'EntryService', ($rootScope, $scope, EntryService) ->
    $rootScope.section = 'entries'

    angular.extend $scope, {
        modalOptions:
            backdropFade: true
            dialogFade: true
        refresh: () ->
            @loading = true
            @isModalOpen = false

            EntryService.query().then (entries) =>
                @loading = false
                @entries = entries
        showModal: () ->
            @isModalOpen = true
        closeModal: () ->
            @isModalOpen = false
        createEntry: () ->
            alert 'lol'
    }
    $scope.refresh()
]