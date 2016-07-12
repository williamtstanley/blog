$(document).ready(function(){

    var allPosts = function(){
        $.get("/posts", function(data){
            for(var i = 0; i < data.length; i++){
                var post = data[i];
                $("#hook-point").prepend("<div class='post'><h4><a href='/posts/" + post.id + "'>" + post.title + "</a></h4><p>" + post.body.slice(0,60) + "</p></div><hr>");
            }
        });
    }

    var onePost = function(data){
        $("#page-header").html("");
        $("#hook-point").html("<div><button id='back-button'>BACK</button><h1>" + data.title + "</h1><p>" + data.body +"</p><p><small class='muted'>Written by: " + data.user.first_name + " " + data.user.last_name + "</small></p><hr>" );
        $("#hook-point").append("<form id='create-comment'><textarea placeholder='enter a comment here'></textarea><br><button type='submit'>Comment</button><hr><div id='comments'>")
        data.comments.forEach(function(comment){
            $("#comments").prepend("<div><p>" + comment.body + "</p></div>");
        })
    }

    var renderPost = function(post){
        $.get(post, function(data){
            onePost(data);
            $("#create-comment").on("submit", function(event){
                var comment = $("textarea").val();
                event.preventDefault();
                $.ajax({
                    method: "POST",
                    url: "/posts/" + data.id + "/comments",
                    data: {
                        comment: {body: comment}
                    },
                    success: function(){
                        $("#comments").prepend("<div><p>" + comment + "</p></div>");
                        $("#comments div:first-child").hide().fadeIn(1000);
                    },
                    error: function(){
                        alert('fuck no');
                    }
                })
            })
            $("#back-button").click(function(event){
                event.preventDefault();
                delete localStorage.post;
                allPosts();
            })

        })

    }


    $("#hook-point").on("click", ".post a", function(event){
        localStorage.post = $(this).attr('href');
        var post = localStorage.post;
        renderPost(post);
        return false;
    })

    if (localStorage.post){
        renderPost(localStorage.post);
    } else {
        allPosts();
    }



})

// $.get("/posts?inclue=user", function(data)


// "<p><small class='muted'>" + data.user.first_name + " " + data.user.last_name + "</small></p>"