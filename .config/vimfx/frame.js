vimfx.listen('getCurrentHref', (data, callback) => {
  let {href} = content.document.activeElement
  callback(href)
})
