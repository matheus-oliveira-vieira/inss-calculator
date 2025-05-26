import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["phoneField"]

  format() {
    let phone = this.phoneFieldTarget.value.replace(/\D/g, "")
    this.phoneFieldTarget.value = this.#formatPhone(phone)
  }

  #formatPhone(phone) {
    if (phone.length === 10) {
      return phone.replace(/(\d{2})(\d{4})(\d{4})/, "($1)$2-$3")
    }
    else if (phone.length === 11) {
      return phone.replace(/(\d{2})(\d{5})(\d{4})/, "($1)$2-$3")
    }
    return phone
  }
}
