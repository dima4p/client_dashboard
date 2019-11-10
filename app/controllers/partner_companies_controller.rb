class PartnerCompaniesController < ApplicationController
  before_action :set_partner_company, only: [:show, :edit, :update, :destroy]

  # GET /partner_companies
  # GET /partner_companies.json
  def index
    @partner_companies = PartnerCompany.with_contractors_and_clients
    @partner_companies = @partner_companies.page(params[:page]) unless params[:per_page].presence == "0"
    @partner_companies = @partner_companies.per(params[:per_page]) if params[:per_page].presence.to_i > 0
  end

  # GET /partner_companies/1
  # GET /partner_companies/1.json
  def show
  end

  # GET /partner_companies/new
  def new
    @partner_company = PartnerCompany.new
  end

  # GET /partner_companies/1/edit
  def edit
  end

  # POST /partner_companies
  # POST /partner_companies.json
  def create
    @partner_company = PartnerCompany.new(partner_company_params)

    respond_to do |format|
      if @partner_company.save
        format.html { redirect_to @partner_company, notice: 'Partner Company was successfully created.' }
        format.json { render :show, status: :created, location: @partner_company }
      else
        format.html { render :new }
        format.json { render json: @partner_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partner_companies/1
  # PATCH/PUT /partner_companies/1.json
  def update
    respond_to do |format|
      if @partner_company.update(partner_company_params)
        format.html { redirect_to @partner_company, notice: 'Partner Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @partner_company }
      else
        format.html { render :edit }
        format.json { render json: @partner_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partner_companies/1
  # DELETE /partner_companies/1.json
  def destroy
    @partner_company.destroy
    respond_to do |format|
      format.html { redirect_to partner_companies_url, notice: 'Partner Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner_company
      @partner_company = PartnerCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partner_company_params
      params.require(:partner_company).permit(:identity, :name)
    end
end
