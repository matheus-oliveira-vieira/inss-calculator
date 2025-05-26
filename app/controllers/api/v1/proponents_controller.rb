class Api::V1::ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[ update ]

  def index
    @proponents = Proponent.all
  end

  def new
    @proponent = Proponent.new
    @proponent.build_address
    @proponent.contacts.build
  end

  def create
    @proponent = Proponent.new(proponent_params)
    if @proponent.save
      redirect_to api_v1_proponents_path, notice: "Proponente criado com sucesso."
    else
      Rails.logger.error "Erros de validação: #{@proponent.errors.full_messages}"
      @proponent.errors.full_messages.each { |msg| puts msg }
      render :new
    end
  end

  def update
    if @proponent.update(proponent_params)
      redirect_to api_v1_proponents_path, notice: "Proponente atualizado com sucesso."
    else
      render :edit
    end
  end

  def calculate_inss
    salary = params[:salary].to_f

    if salary >= 1518
      inss = ProgressiveInssCalculator.new(salary).calculate
      render json: { inss_discount: inss, success: true }
    else
      render json: { error: "Salário deve ser maior que zero", success: false }
    end
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :birth_date, :email, :password, :cpf, :salary, :inss_discount,
      address_attributes: [ :id, :zip_code, :number, :neighborhood, :city, :state, :street, :_destroy ],
      contacts_attributes: [ :id, :contact_type, :value, :_destroy ]
    )
  end
end
