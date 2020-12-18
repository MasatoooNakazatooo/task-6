class UsersController < ApplicationController
    before_action :authenticate_user!
  def index
    if user_signed_in?
    #form_withに必要な記述
    @book = Book.new
    #ログイン中のユーザーのデータを取り出している
    @user = User.find(current_user.id)
    #全ユーザーのデータを取り出している
    @users = User.all
    else
       redirect_to new_user_registration_path
    end
  end

  #viewを持たないからインスタンス変数がいらない
  def create
   #form_withに必要な記述
   book = Book.new(book_params)
   #booksモデルのuser_idカラムにログイン中のidを入れる
   book.user_id = current_user.id
   #内容を保存する
   if book.save
      flash[:success] = 'Book was successfully created.'
      #bookの詳細画面へ遷移（ここに遷移するidを指定する)
      redirect_to book_path(book.id)
   else
     render :index
   end
    #bookの詳細画面へ遷移（ここに遷移するidを指定する)
   redirect_to book_path(book.id)
  end



  def show
    if user_signed_in?
     #form_withに必要な記述
    @book = Book.new
    #ログイン中のユーザーidとBookモデルのuser_idが一致するものすべてをユーザーが投稿したものを表示するために取得している
    @books = Book.where(user_id: current_user.id)
    #そのユーザーのデータを取得
    @user = User.find(params[:id])
    else
       redirect_to new_user_registration_path
    end

  end

  def edit
    
     #新規投稿ではなく編集なので編集したいidを取ってきてform_withに渡している
     @user = User.find(params[:id])
    if   @user.id == current_user.id
     render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
     #bookのidを取り出している
    @user = User.find(params[:id])
    #データを受け取るbook_paramsに更新している
   if @user.update(user_params)
    #Bookの詳細画面に遷移
     flash[:success] = 'User info was successfully Updated.'
      redirect_to user_path(@user.id)
   else
      render :edit
   end
  end

  private

  def user_params
  params.require(:user).permit(:profile_image, :name, :introduction)
  end
  def book_params
  params.require(:book).permit( :title, :body, :id)
  end
end
