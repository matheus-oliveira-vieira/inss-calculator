import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    fetch(this.urlValue)
      .then(response => response.json())
      .then(data => this.renderChart(data))
  }

  renderChart(data) {
    const ctx = document.getElementById("salaryChart").getContext("2d")

    new Chart(ctx, {
      type: "bar",
      data: {
        labels: data.map(item => item.label),
        datasets: [{
          label: "Faixa Salarial",
          data: data.map(item => item.count),
          backgroundColor: "#0d6efd"
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: { display: false }
        },
        scales: {
          y: {
            beginAtZero: true,
            precision: 0
          }
        }
      }
    })
  }
}
