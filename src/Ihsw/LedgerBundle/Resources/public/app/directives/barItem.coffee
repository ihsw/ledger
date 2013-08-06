# controller
controller = ($s, $l, BarService) ->
    ### SCOPE
    ###
    # properties
    $s.item = {}

    # methods
    $s.call = (href, callback) ->
        BarService.call $s, href, callback
        $s.onItemCall $s.item

    # watches
    $s.$watch 'disabled', ->
        if typeof $s.disabled == 'undefined'
            return

        if $s.disabled == false
            i = $s.button.classes.indexOf 'disabled'
            if i < 0
                return
            $s.button.classes.splice i, 1
            return

        $s.button.classes.push 'disabled'

    return @
controller.$inject = ['$scope', '$location', 'BarService']

# link
link = ($s, element, attrs, BarButtonController) ->
    ### SCOPE
    ###
    $s.onItemCall = (item) ->
        BarButtonController.onItemCall item

    # generating a button
    classValue = attrs.class ? ''
    item = $s.item =
        label: attrs.label
        classes: classValue.split(' ')
        icon: attrs.icon
        call: ->
            $s.call attrs.href, attrs.callback

    # pushing it up
    BarButtonController.addItem item

# directive definition
window.module.directive 'barItem', ->
    return {
        require: '^barButton'
        restrict: 'E'
        scope:
            callback: '&'
            disabled: '='
            href: '@'
        controller: controller
        link: link
    }