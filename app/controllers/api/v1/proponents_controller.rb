class Api::V1::ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[ update destroy ]

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
      redirect_to proponents_path, notice: "Proponente criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @proponent.update(proponent_params)
      redirect_to proponents_path, notice: "Proponente atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @proponent.destroy
    redirect_to proponents_path, notice: "Proponente removido com sucesso."
  end

  def calculate_inss
    salary = params[:salary].to_f
    inss = ProgressiveInssCalculator.new(salary).calculate

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("inss_value", partial: "proponents/inss_value", locals: { inss: inss }) }
    end
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(
      :email, :password, :cpf, :salary, :inss_discount,
      address_attributes: [ :id, :zip_code, :city, :state, :street, :_destroy ],
      contacts_attributes: [ :id, :contact_type, :value, :_destroy ]
    )
  end
end
