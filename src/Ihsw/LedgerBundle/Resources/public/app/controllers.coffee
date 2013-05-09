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

    defaultModalOptions =
        backdropFade: true
        dialogFade: true
    angular.extend $scope, {
        entryModalOptions: defaultModalOptions
        itemsModalOptions: defaultModalOptions
        refresh: () ->
            @loading = true
            @createEntryDisabled = false
            @isEntryModalOpen = false
            @isItemsModalOpen = false

            EntryService.query().then (entries) =>
                @loading = false
                @entries = entries
        showModal: () ->
            @isEntryModalOpen = true
        closeModal: () ->
            @isEntryModalOpen = false
        create: () ->
            if @createEntryDisabled
                return
            @createEntryDisabled = true

            EntryService.create({occurredAt: @occurredAt}).then (entry) =>
                @occurredAt = ''
                @createEntryDisabled = false
        showItemsModal: () ->
            $scope.isItemsModalOpen = true
        closeItemsModal: () ->
            @isItemsModalOpen = false
    }
    $scope.refresh()
]