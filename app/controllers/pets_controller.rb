class PetsController < ApplicationController

  before_action :set_pet, only: [:edit, :update, :destroy]
  skip_before_action :only_signed_in, only: [:show]

  def show
    @pet = Pet.find(params[:id])
  end

  def index
    @pets = current_user.pets
  end

  def new
    @pet = current_user.pets.new
  end

  def create
    @pet = current_user.pets.new(pet_params)
    if @pet.save
      redirect_to pets_path, success: 'Votre animal a bien été créé'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to pets_path, success: 'Votre animal a bien été modifié'
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, success: 'Votre animal a bien été supprimé'
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :gender, :birthday, :species_id, :avatar_file)
  end

  def set_pet
    @pet = current_user.pets.find(params[:id])
  end

end
