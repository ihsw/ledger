controller = ($s, $f, BarService) ->
    # scope properties
    $s.groups = {}
    $s.BarService = BarService

    # controller methods
    @addGroup = (group) ->
        $s.groups[group.id] = group
    @getGroupCount = ->
        return $f('dictLength')($s.groups)

    # scope methods
    $s.setBarGroups = (target) ->
        BarService.setBarGroups target, $s.groups

    return @
controller.$inject = ['$scope', '$filter', 'BarService']

link = ($s, element, attrs) ->
    if !('target' of attrs)
        throw 'target required in bar directive, not found'
    $s.setBarGroups attrs.target

window.module.directive 'bar', ->
    return {
        restrict: 'E'
        controller: controller
        link: link
    }