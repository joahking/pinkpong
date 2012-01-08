 class GamesController < ApplicationController
   before_filter :load_users, :only => [:new, :create, :edit, :update]
   before_filter :find_or_create_users_by_emails, :only => [:create, :update]

   # GET /games
   # GET /games.json
   def index
     @games = Game.order("created_at DESC").includes(:winner, :loser)

     respond_to do |format|
       format.html # index.html.erb
       format.json { render :json => @games }
     end
   end

   # GET /games/1
   # GET /games/1.json
   def show
     @game = Game.find(params[:id], :include => [:winner, :loser])

     respond_to do |format|
       format.html # show.html.erb
       format.json { render :json => @game }
     end
   end

   # GET /games/new
   # GET /games/new.json
   def new
     @game = Game.new

     respond_to do |format|
       format.html # new.html.erb
       format.json { render :json => @game }
     end
   end

   # GET /games/1/edit
   def edit
     @game = Game.find(params[:id])
   end

   # POST /games
   # POST /games.json
   def create
     @game = Game.new(params[:game])

     respond_to do |format|
       if @game.save
         format.html { redirect_to @game, :notice => 'Game was successfully created.' }
         format.json { render :json => @game, :status => :created, :location => @game }
       else
         format.html { render :action => "new" }
         format.json { render :json => @game.errors, :status => :unprocessable_entity }
       end
     end
   end

   # PUT /games/1
   # PUT /games/1.json
   def update
     @game = Game.find(params[:id])

     respond_to do |format|
       if @game.update_attributes(params[:game])
         format.html { redirect_to @game, :notice => 'Game was successfully updated.' }
         format.json { head :ok }
       else
         format.html { render :action => "edit" }
         format.json { render :json => @game.errors, :status => :unprocessable_entity }
       end
     end
   end

   # DELETE /games/1
   # DELETE /games/1.json
   def destroy
     @game = Game.find(params[:id])
     @game.destroy

     respond_to do |format|
       format.html { redirect_to games_url }
       format.json { head :ok }
     end
   end

   protected

   def load_users
     @users = User.all
   end

   def find_or_create_users_by_emails
     if params[:game][:winner_id].blank? && params[:winner_email]
       winner = User.find_by_email params[:winner_email]
       winner ||= User.new(:email => params[:winner_email],
                           :password => SecureRandom.hex(6))
       if winner.save
         params[:game][:winner_id] = winner.id
       end
     end

     if params[:game][:loser_id].blank? && params[:loser_email]
       loser = User.find_by_email params[:loser_email]
       loser ||= User.new(:email => params[:loser_email],
                                :password => SecureRandom.hex(6))
       if loser.save
         params[:game][:loser_id] = loser.id
       end
     end

   end

 end
