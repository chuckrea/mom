var mom_app, username;
$(function() {
  $sign_up_form = $("form#sign_up_user");
  $sign_up_form.on("submit", function(event){
    $.ajax({  url: '/users',
              method: "post",
              format: "json",
              data: $sign_up_form.serialize()
            }
    ).done(function(data) {
      console.log(data);
      if (data.success){
        mom_app.signUp(data);
        mom_app.confirmText(data);
      }
    });
  });

  $sign_in_form = $('form#sign_in_user');
  $sign_in_form.on('submit', function(event){
    $.ajax({  url: '/users/sign_in',
              method: 'post',
              format: 'json',
              data: $sign_in_form.serialize()
            }
    ).done(function(data) {
      console.log(data);
      if (data.success){
        mom_app.signIn(data);

      }
    });
  });

  // create ajax logout call
  $logout_link = $('#logout_link');
  $logout_link.on('click', function(){
    $.ajax({  url: '/users/sign_out',
              method: 'delete',
              data: {authenticity_token: window._token} 
            }
    ).done(function(data) {
      console.log(data);
      if (data.success){
        mom_app.logOut();
      }
    });
  });

  mom_app = {
    // actions
    signIn: function(data){
      $(".sign-in").slideToggle(1500);
      mom_app.loggedIn(data);
      //location.reload();    
    },

    confirmText: function(data){
      $.ajax({
        url: '/welcome',
        type: 'post',
        dataType: 'json',
        data: {phone_num: data.current_user.phone_number}
      })
        .success(function(data) {
        console.log("text was sent!")
        });
    },

    signUp: function(data){
      
      $(".register").slideToggle(1500);
  
      mom_app.loggedIn(data);
      //location.reload();
    },

    logOut: function(data){
      mom_app.loggedOut();
      location.reload();
    },

    // toggle logged in/logged out states
    loggedIn: function(data){
      $("div#logged_in_menu").removeClass("inactive");
      $("div#logged_out_menu").addClass("inactive");
      if (data) {
        window._current_user_username = data.current_user.username
      }
    },

    loggedOut: function(){
      $("div#logged_in_menu").addClass("inactive");
      $("div#logged_out_menu").removeClass("inactive");
      window._current_user_username = '';
    }
  }

  if (window._current_user_username) {
    mom_app.loggedIn();  
  } else {
    mom_app.loggedOut();
  }

});