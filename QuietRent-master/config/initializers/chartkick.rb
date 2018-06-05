Chartkick.options = {
  label: "Fiabilité",
  height: '450px',
  colors: ["#F18132", "#000"]
}
Chartkick.options[:html] = '<div id="%{id}" style="height: %{height};width: %{width}">Loading...</div>'
Chartkick.options[:content_for] = :charts_js
