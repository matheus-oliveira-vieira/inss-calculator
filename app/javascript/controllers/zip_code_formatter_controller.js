import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cepField"]

  format() {
    let cep = this.cepFieldTarget.value.replace(/\D/g, "")
    if (cep.length > 8) {
      cep = cep.substring(0, 8)
    }
    this.cepFieldTarget.value = this.#formatCEP(cep)
  }

  #formatCEP(cep) {
    return cep.replace(/(\d{5})(\d{3})/, "$1-$2")
  }
}
