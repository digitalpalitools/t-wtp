outD = (id) => window.location = `/t/wtp/tipitaka/data/${id}.html`

prevP = () => { }
upP = () => { }
nextP = () => { }

navHandler = (e) => {
    e.preventDefault()
    window.location = `/t/wtp/tipitaka/data/${e.target.name}.html`
}

$('div.b > a').click(function(e) {
    e.preventDefault(); 
    if (/^https?\:\/\/[^\/]+\/?$/.test(this.href)) {
        window.location = `/t/wtp/index.html`
    } else {
        window.location = this.href.replace(/(.*)\/tipitaka\/(.*)/, '$1/t/wtp/tipitaka/$2.html')
    }
})

$("a#prevL").off('click').on('click', navHandler)
$("a#upL").off('click').on('click', navHandler)
$("a#nextL").off('click').on('click', navHandler)
