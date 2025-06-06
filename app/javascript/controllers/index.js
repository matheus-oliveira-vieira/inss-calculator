// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"
import inssCalculatorController from "./inss_calculator_controller"
import cpfFormatterController from "./cpf_formatter_controller"
import phoneFormatterController from "./phone_formatter_controller"
import zipCodeFormatterController from "./zip_code_formatter_controller"
import nestedFormController from "./nested_form_controller"
import salaryChartController from "./salary_chart_controller"

import HelloController from "./hello_controller"
application.register("hello", HelloController)
application.register("inss-calculator", inssCalculatorController)
application.register("cpf-formatter", cpfFormatterController)
application.register("phone-formatter", phoneFormatterController)
application.register("zip-code-formatter", zipCodeFormatterController)
application.register("nested-form", nestedFormController)
application.register("salary-chart", salaryChartController)
