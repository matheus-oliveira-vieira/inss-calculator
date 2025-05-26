import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary", "discount"]

  calculateInss() {
    const salary = parseFloat(this.salaryTarget.value)

    if (!salary || salary <= 0) {
      this.discountTarget.value = ""
      return
    }

    fetch('/api/v1/proponents/calculate_inss', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ salary: salary })
    })
    .then(response => {
      return response.json()
    })
    .then(data => {
      this.discountTarget.value = data.inss_discount?.toFixed(2) || "0.00"
    })
    .catch(error => {
      console.error("Erro na requisição:", error)
    })
  }
}