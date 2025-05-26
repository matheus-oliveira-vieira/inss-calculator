import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "links"]

  add(e) {
    e.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.linksTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove(e) {
    e.preventDefault()
    const wrapper = e.target.closest('.contact-fields')

    if (wrapper.dataset.newRecord === 'true') {
      wrapper.remove()
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = '1'
      wrapper.style.display = 'none'
    }
  }
}
