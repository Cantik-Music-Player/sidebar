React = require('react')
ReactDOM = require('react-dom')

module.exports.SidebarComponent =
class SidebarComponent extends React.Component
  constructor: (props) ->
    super props

  render: ->
    # Get links
    links = []
    for category in Object.keys(@props.links)
      # Push category title
      links.push <h4 key={category}>{category}</h4>
      for link in @props.links[category]
        # Push every links of the category
        normalizedName = @props.cantik.utils.normalizeString link.title
        links.push(<li className={'active' if link.active} id="sidebar-#{normalizedName}" key={link.title} onClick={link.onClick}>
                    <a className='withripple' data-toggle={'tab' if link.dataToggle} href="##{normalizedName}">{link.title}</a>
                   </li>)

    <div className="panel panel-default" id="sidebar">
      <div className="panel-body">
        <ul className="nav nav-pills nav-stacked">
          {links}
        </ul>
      </div>
    </div>

module.exports.SidebarView =
class SidebarView
  constructor: (@links, @cantik) ->
    @element = document.createElement('div')
    console.log @element
    ReactDOM.render(
      <SidebarComponent links=@links cantik=@cantik />,
      @element
    )
    document.getElementsByTagName('body')[0].appendChild(@element);

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
