require 'coffee-react/register'
SidebarView = require('./sidebar-view').SidebarView
SidebarComponent = require('./sidebar-view').SidebarComponent

module.exports =
class Sidebar
  constructor: (@cantik) ->
    @links = {}

  activate: (state) ->
    @sidebarView = new SidebarView(@links, @cantik)

  deactivate: ->
    if @centralAreaView?
      @sidebarView.destroy()

  serialize: ->
    sidebarViewState: @sidebarView.serialize()

  changeTab: (tabName) ->
    id = @cantik.utils.normalizeString.normalizeString tabName
    @element.querySelector(".panel .panel-body ul #sidebar-#{id} a").click()

  addLink: (name, category, onClick, active, dataToggle) ->
    active = if active then true else false
    dataToggle = true if not dataToggle?
    @links[category] = [] if category not in Object.keys(@links)

    # Call given onclick after adding tab to history
    onClickWithHistory = (e) =>
      target = e.target
      @cantik.pluginManager.plugins.history.addHistoryEntry(-> target.click())
      do onClick if onClick?

    @links[category].push({'title': name, 'onClick': onClickWithHistory, 'active': active, 'dataToggle': dataToggle})
    do @deactivate
    do @activate
    active
