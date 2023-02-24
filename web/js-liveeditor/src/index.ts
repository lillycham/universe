// JS Live Editor index file

const jsEditor = document.getElementById('editor-ta-js')! as HTMLTextAreaElement
const htmlEditor = document.getElementById('editor-ta-html')! as HTMLTextAreaElement
const cssEditor = document.getElementById('editor-ta-css')! as HTMLTextAreaElement
// const renderButton = document.getElementById('editor-btn')!
const logger = document.getElementById('logger')!
const root = document.getElementById('preview-embed')! as HTMLIFrameElement
const iframe = root.contentWindow?.document!

let htmlText = '';
let jsText = '';
let cssText = '';
let log: string[] = [];

window.onmessage = (ev) => {
	if (ev.data === true) {
		log = []
		return
	}
	log.push(ev.data)
	logger.innerHTML = ''
	log.forEach(n => {
		logger.append(n)
		logger.append(document.createElement('br'))
	})
}

function updater(x: any) {
	const str = htmlText
	const scr = document.createElement('script')
	const sty = document.createElement('style')
	scr.textContent = "console.log = m => window.top.postMessage(m, '*'); document.addEventListener('DOMContentLoaded', (e) => window.top.postMessage(true, '*'));" + jsText
	sty.textContent = cssText

	iframe.open()
	iframe.write(str)
	iframe.head?.append(scr, sty)
	iframe.close()
}

jsEditor.oninput = function (this, ev) {
	jsText = jsEditor.value
	console.log(jsText)
	updater(ev)
}

htmlEditor.oninput = function (this, ev) {
	htmlText = htmlEditor.value
	console.log(htmlText)
	updater(ev)
}

cssEditor.oninput = function (this, ev) {
	cssText = cssEditor.value
	console.log(cssText)
	updater(ev)
}

// renderButton.onclick = updater