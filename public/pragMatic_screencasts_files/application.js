/* window.fluid.dockBadge = "10/20"; */

var LoginCheck = Class.create();
LoginCheck.prototype = {

  initialize: function() {
    var user_name = get_cookie('user_name') || 
                    get_cookie('pragmatic_user_name');
    if (!user_name) {
      var link = document.createElement('a');
      link.className = 'login-button';
      link.href = '/login';
      
      var img = document.createElement('img');
      img.alt = 'Login';
      img.height = '27';
      img.width = '72';
      img.title = '';
      img.src = '/images/login-button.gif';
      link.appendChild(img);

      $('login').update(link.outerHTML);
    } else {
      
      var link = document.createElement('a');
      link.href = '/my_account';
      link.appendChild(document.createTextNode('Your Account'));
      
      $('login').update(link.outerHTML);
    }
  }
  
};

/* Updates the price depending on options on the Starter Kit page */
function updateStarterKitPrice() {
  var form = $('starterkit_form');
  Element.show('spinner');
  new Ajax.Request(form.action, {
    asynchronous: true,
    evalScripts: true,
    method: form.method,
    onComplete: function(request) { Element.hide('spinner') },
    parameters: Form.serialize(form)
  });

  return false;
}

function toggleShippingAddress(showShipping) {
  var toggleDiv = $('shipping_address');
  if (showShipping) {
    new Effect.BlindDown(toggleDiv);
  } else {
    new Effect.BlindUp(toggleDiv);
  }
}

function showOrHideShippingAddress() {
  var shipToBilling = $('ship_separate_address');
  if (shipToBilling.checked) {
    $('shipping_address').style.display = "inline";
  } else {
	  $('shipping_address').style.display = "none";
  }
}

function toggleIsAGift(showGift, recipientNameField, shipEmailField) {
  var toggleDiv = $('gift_receiver');
  if (showGift) {
    new Effect.BlindDown(toggleDiv);
  } else {
   recipientNameField.value = '';	
   shipEmailField.value = '';	
   new Effect.BlindUp(toggleDiv);
  }
}

function showOrHideGiftReceiver() {
  var isAGift = $('this_is_a_gift');
  if (isAGift.checked) {
    $('gift_receiver').style.display = "inline";
  } else {
    $('gift_receiver').style.display = "none";
  }
}

function setup_address_page() {
  showOrHideShippingAddress();
  showOrHideGiftReceiver();
}


/* used on the checkout payment screen */
function show_card_code() {
  window.open('/card_code.html', '_card_code', 'width=600,height=400'); 
}

function test_cc_number() {
  $('x_card_num').value = "4007000000027";
  $('x_card_code').value = "123";
  $('x_exp_date').value = "0110";
}

function validateCreditCardForm(submit_button, thank_you_button) {
  var fields = { x_card_num  : 'credit card number',
                 x_card_code : 'credit card security code',
                 x_exp_date  : 'credit card expiration date' };

  for (field in fields) {
    if ($F(field).length == 0) {
      alert("Please specify the " + fields[field]);
      Field.focus(field);
      return false;
    }
  }
                 
  if (!$F('x_card_num').match(/^[0-9]{13,16}$/)) {
    alert("The credit card number must be 13-16 digits");
    Field.focus(field);
    return false;
  }
  
  if (!$F('x_card_code').match(/^[0-9]{3,4}$/)) {
    alert("The credit card security code must be 3-4 digits");
    Field.focus(field);
    return false;
  }
  
  if (!$F('x_exp_date').match(/^[01][0-9](0[789]|1[0-9])$/)) {
    alert("The credit card expiration date must be 4 digits (MMYY)");
    Field.focus(field);
    return false;
  }

  $(submit_button).disabled = true;
  $(submit_button).hide();
  new Effect.Appear(thank_you_button);
  return true;
}

TabControl = function(control_id, options) {
  var id = "#" + control_id;
  $$(id+' ul.tabs li a').each(function(a) {
    var page = a.getAttribute('href').match(/[-_\w]+$/i)[0];

    if (page != options['current']) { $(page).hide() } 
    else { $(a.parentNode).addClassName('active') }

    Event.observe(a, 'click', function(e) {
      $$(id+' ul.tabs li.active').each(function(e) { e.removeClassName('active'); })
      $$(id+' .tab_page[id!='+page+']').each(function(e) { e.hide() });
      $(a.parentNode).addClassName('active');
      $(page).show();
      Event.stop(e);
    });
  });
}

function get_cookie(name) {
  var cookies = document.cookie.split('; ');
  var cookie_value = null;

  for (var i=0; i < cookies.length; i++) {
    var key;
    var value;

    pair = cookies[i].split('='); 
    key = pair[0]; 
    value = pair[1];

    if (key == name) {
      cookie_value = value;
    }
  }

  return cookie_value;
}
