import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cpfField"]

  format() {
    let cpf = this.cpfFieldTarget.value.replace(/[^\d]/g, "")
    if (cpf.length > 11) {
      cpf = cpf.substring(0, 11)
    }
    this.cpfFieldTarget.value = this.#formatCPF(cpf)
  }

  #formatCPF(cpf) {
    return cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4")
  }
}
