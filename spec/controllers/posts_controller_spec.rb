require 'rails_helper'

RSpec.describe PostsController, type: :controller do

    let (:create_post) {FactoryGirl.create(:post)}

    describe "#index" do
        it "renders the index template" do
            get :index
            expect(response).to render_template(:index)
        end
        it "sets the instance variable: @posts to all posts in the database" do
            post1 = FactoryGirl.create(:post)
            post2 = FactoryGirl.create(:post)
            get :index
            expect(assigns(:posts)).to eq([post2, post1])
        end
    end
    describe "#new" do
        it "renders the new template" do
            get :new
            expect(response).to render_template(:new)
        end
        it "creates a new post instance variable" do
            get :new
            expect(assigns(:post)).to be_a_new(Post)
        end
    end
    describe "#create" do
        context "with valid attributes" do
            def valid_request
                post :create, post: FactoryGirl.attributes_for(:post)
            end
            it "saves a record to the database" do
                count_before = Post.count
                valid_request
                count_after = Post.count
                expect(count_after).to eq(count_before + 1)
            end
            it "redirects to the show page of the post" do
                valid_request
                expect(response).to redirect_to(post_path(Post.last))
            end
            it "sets a flash notice message" do
                valid_request
                expect(flash[:notice]).to be
            end
        end
        context "with invalid attributes" do
            def invalid_request
                post :create, post: {title: ""}
            end
            it "doesn't save a record to the database" do
                count_before = Post.count
                invalid_request
                count_after = Post.count
                expect(count_before).to eq(count_after)
            end
            it "renders the new template" do
                invalid_request
                expect(response).to render_template(:new)
            end
            it "sets a flash message" do
                invalid_request
                expect(flash[:alert]).to be
            end

        end
    end
    describe "#show" do
        before do

            get :show, id: create_post.id
        end
        it "renders the show template" do
            expect(response).to render_template(:show)
        end
        it "sets the instance variable to the passed id" do
            expect(assigns(:post)).to eq(create_post)
        end
    end
    describe "#edit" do
        before do
            get :edit, id: create_post.id
        end
        it "renders the edit template" do
            expect(response).to render_template(:edit)
        end
        it "sets an instance variable to the post id passed" do
            expect(assigns(:post)).to eq(create_post)
        end
    end
    describe "#update" do
        context "with valid attirbutes" do
            def valid_request
                patch :update, id: create_post.id, post: {title: "New post title"}
            end
            it "updates the record in the database" do
                valid_request
                expect(create_post.reload.title).to eq("New post title")
            end
            it "redirects to the show page" do
                valid_request
                expect(response).to redirect_to(post_path(create_post))
            end
            it "sets a flash message" do
                valid_request
                expect(flash[:notice]).to be
            end

        end

        context "with invalid attributes" do
            def invalid_request
                patch :update, id: create_post.id, post: {title: ""}
            end
            it "it doesn't save the new value to the database" do
                invalid_request
                expect(create_post.reload.title).to_not eq("")
            end
            it "renders the edit template" do
                invalid_request
                expect(response).to render_template(:edit)
            end
        end

    end
    describe "#destroy" do
        it "removes the record from the database" do
            create_post
            count_before = Post.count
            delete :destroy, id: create_post.id
            count_after = Post.count
            expect(count_before).to eq(count_after + 1)
        end
        it "redirects to the posts_path (listing Page)" do
            delete :destroy, id: create_post.id
            expect(response).to redirect_to(posts_path)
        end
    end

end
