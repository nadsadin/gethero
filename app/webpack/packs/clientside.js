require.context('../images', true)
require('jquery')
import "../stylesheets/application";
import "../stylesheets/clientside";
import * as mdc from 'material-components-web';
import {MDCDrawer} from "@material/drawer";
import {MDCTopAppBar} from "@material/top-app-bar";
import {MDCTextField} from '@material/textfield';
import Glide from '@glidejs/glide';
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
Rails.start();
Turbolinks.start();

document.addEventListener('turbolinks:load', function(){
  const buttons = document.querySelectorAll('.mdc-button, .mdc-fab');
  for (const button of buttons) {
    mdc.ripple.MDCRipple.attachTo(button);
  }
  // const textField = new MDCTextField(document.querySelector('.mdc-text-field'));
  mdc.autoInit();
//topAppBar.setScrollTarget(document.getElementById('main-content'));
  const snackbar = document.querySelector('.mdc-snackbar');
  if(snackbar) snackbar.MDCSnackbar.open();


  const open = (elem) => {
    let className = elem.className;
    if (className.indexOf(' dropdown-left') === -1) {
      className += ' dropdown-left';
    } else {
      className = className.replace(' dropdown-left', '');
    }
    elem.className = className;

    return false;
  };
  sidenav_drop_1.onclick = function () {
    open(document.getElementById("left_menu"));
  };

  const closed = (elem) => {
    let className = elem.className;
    if (className.indexOf(' dropdown-left') !== -1) {
      className = className.replace(' dropdown-left', '');
    }
    elem.className = className;

    return false;
  };
  closed_menu.onclick = function () {
    closed(document.getElementById("left_menu"));
  };
});