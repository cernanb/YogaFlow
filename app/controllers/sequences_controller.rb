class SequencesController < ApplicationController
  def index
    @sequences = Sequence.all
    @poses = Pose.all
    @users = User.all
    @longest_sequence = Sequence.most_poses.first
  end

  def new
    if current_user
      @sequence = Sequence.new
      15.times do
        @sequence.poses.build
      end
      @poses = Pose.all
    else
      redirect_to log_in_path
    end
  end

  def create
    @sequence = Sequence.create(sequence_params)
    @sequence.set_poses(params[:sequence])
    @sequence.save
    redirect_to sequences_path
  end

  def show
    @sequence = Sequence.find(params[:id])
    redirect_to sequence_poses_path(@sequence)
  end

  def edit
    @sequence = Sequence.find(params[:id])
  end

  def update
    @sequence = Sequence.find(params[:id])
    #add new poses and updates to sequence
    redirect_to sequence_poses_path(@sequence)
  end

  private

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, :repititions, :pose_ids, poses_attributes: [:name, :description, :pose_ids])
  end

end
