require.context('../images', true)
require('jquery')
import "../stylesheets/application";
import * as mdc from 'material-components-web';
import {MDCDrawer} from "@material/drawer";
import {MDCTopAppBar} from "@material/top-app-bar";
import {MDCMenu} from '@material/menu';
import {MDCTextField} from '@material/textfield';
import Glide from '@glidejs/glide';
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import Quill from 'quill';
Rails.start();
Turbolinks.start();

document.addEventListener('turbolinks:load', function(){
  const drawer_element = document.querySelector('.mdc-drawer--modal');
  let modal_drawer;
  if(drawer_element) modal_drawer = MDCDrawer.attachTo(drawer_element);
  //const permanent_drawer = MDCDrawer.attachTo(document.querySelector('.mdc-drawer--permanent'));
  const topAppBar = MDCTopAppBar.attachTo(document.querySelector('.mdc-top-app-bar'));
  const buttons = document.querySelectorAll('.mdc-button, .mdc-fab');
  for (const button of buttons) {
    mdc.ripple.MDCRipple.attachTo(button);
  }
  // const textField = new MDCTextField(document.querySelector('.mdc-text-field'));
  mdc.autoInit();
  // topAppBar.setScrollTarget(document.querySelector('.drawer-main-content'));
  topAppBar.listen('MDCTopAppBar:nav', () => {
    modal_drawer.open = !modal_drawer.open;
  });
  document.querySelectorAll( '.mdc-menu' ).forEach(function (menu) {
    menu.mdcMenu = new MDCMenu(menu);
  });
  $('#avatar-menu-anchor').on('click', function(){
    let mdcMenu = $(this).next('.mdc-menu')[0].mdcMenu;
    if(mdcMenu){
      mdcMenu.setAnchorCorner(mdc.menuSurface.Corner.BOTTOM_LEFT);
      mdcMenu.open = !mdcMenu.open;
    }
  });
  const snackbar = document.querySelector('.mdc-snackbar');
  if(snackbar) snackbar.MDCSnackbar.open();
  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('/service-worker.js', { scope: '/' })
      .then(function(reg) {
        console.log('[Companion]', 'Service worker registered!');
        console.log(reg);
      });
  }
  if(document.getElementsByClassName('mdc-datepicker').length>0){
    window.materialPicker = new MaterialDatepicker('.mdc-datepicker',{
      lang: 'ru',
      orientation: 'portrait',
      color: '#6200ee',
      outputFormat: 'DD.MM.YYYY',
      weekBegin: 'monday'
    });
  }
  let vh = window.innerHeight * 0.01;
  document.documentElement.style.setProperty('--vh', `${vh}px`);
  window.addEventListener('resize', () => {
    let vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty('--vh', `${vh}px`);
  });
  if(document.getElementById('quill-editor')){
    window.editor = new Quill('#quill-editor', {
      modules: { toolbar: '#quill-toolbar' },
      theme: 'snow'
    });
  }

  document.querySelectorAll( '[data-mdc-auto-init="MDCSelect"]' ).forEach( function( sel ) {
    sel.My_MDCSelect__Value = sel.querySelector('input.my_mdc-select__value');
    if ( null !== sel.My_MDCSelect__Value ) {
      sel.addEventListener( 'MDCSelect:change', function( a ) {
        if ( sel.MDCSelect ) {
          sel.My_MDCSelect__Value.value = sel.MDCSelect.value;
        }
      } );
    }
  } );
});
import {} from './custom_registrations'