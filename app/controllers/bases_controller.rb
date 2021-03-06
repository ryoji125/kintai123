class BasesController < ApplicationController

  def index
    @bases = Base.all
    unless current_user.admin?
      redirect_to root_url
    end
  end
    
  def new 
	  @base = Base.new
    respond_to do |format| 
      format.html{ redirect_to @base, notice: '拠点が追加されました。' }
      format.js {} 
    end
  end
    
  
  def create
    @base = Base.new(base_params)
    respond_to do |format|
      if @base.save
        format.html { redirect_to @base, notice: '拠点が追加されました。' }
        format.json { render :show, status: :created, location: @base }
        format.js { @status = "success"}
      else
        format.html { render :new }
        format.json { render json: @base.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
      end
    end
  end
  
  def edit
    @base = Base.find(params[:id])
  end

  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報を更新しました。"
    else
      flash[:danger] = "拠点の更新に失敗しました。" 
    end
    redirect_to bases_url
  end
  
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    flash[:success] = "拠点を削除しました。"
    redirect_to bases_url
  end
  
  
    private

    def base_params
      params.require(:base).permit(:name, :atype, :number)
    end
    
end