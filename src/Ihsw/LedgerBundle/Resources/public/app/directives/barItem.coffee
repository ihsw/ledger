# controller
controller = ($s, $l, BarService) ->
    # scope properties
    $s.item = {}

    # scope methods
    $s.call = (href, callback) ->
        BarService.call $s, href, callback

    # scope watches
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
        controller: controller
        link: link
    }