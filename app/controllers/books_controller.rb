class BooksController < ApplicationController

before_action :authenticate_user!


  def index
    if user_signed_in?
    #form_withに必要な記述
    @book = Book.new
    #ログイン中のユーザー情報を取り出している
    @user = User.find(current_user.id)
    #Bookモデルを全て取り出す
    @books = Book.all
    #user_id(book) = id(user) となるものを取り出す
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if user_signed_in?
      #show.html.erbのログイン中のユーザーの投稿内容取得のためBookモデルのuser_idとログイン中のidが一致するものすべてをとっている
      @book = Book.find(params[:id])
      #bookモデルのuser_id
      @user = User.find(@book.user_id)
      
      #form_withに必要な記述
      @book_new = Book.new
      
      @comments = @book.book_comments
      @comment = BookComment.new
      # byebug
      # @book_comments = BookComment.page(params[:page]).reverse_order
    else
      redirect_to new_user_session_path
    end
  end


  def edit
   
    #新規投稿ではなく編集なので編集したいidを取ってきてform_withに渡している
    
      @book = Book.find(params[:id])
    if @book.user_id == current_user.id then
         render :edit
    else
      redirect_to books_path
    end
    
  end

  def update
     #bookのidを取り出している
    @book = Book.find(params[:id])
    #データを受け取るbook_paramsに更新している
   if @book.update(book_params)
      flash[:success] = 'Book was successfully updated.'
    #Bookの詳細画面に遷移
      redirect_to book_path(@book.id)
   else
      render :edit
   end
  end

 def create
    #ログイン中のユーザー情報を取り出している
   @user = User.find(current_user.id)
   #Bookモデルを全て取り出す
   @books = Book.all
   #form_withに必要な記述
   @book = Book.new(book_params)
   #booksモデルのuser_idカラムにログイン中のidを入れる
   @book.user_id = current_user.id

   if @book.save  #内容を保存する
   #bookの詳細画面へ遷移（ここに遷移するidを指定する)
    flash[:success] = 'You have created successfully.'
     redirect_to book_path(@book.id)
   else
     render :index
   end
 end

 def destroy
    if user_signed_in?
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    else
      render :show
    end
 end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
