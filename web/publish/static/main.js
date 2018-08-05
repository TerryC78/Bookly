function initFlyouts() {
  initPublishedFlyoutMenus(
    [{
      "id": "491566478514253546",
      "title": "Trending",
      "url": "index.html",
      "target": "",
      "nav_menu": false,
      "nonclickable": false
    }, {
      "id": "471949740448456849",
      "title": "My Book",
      "url": "my-book.html",
      "target": "",
      "nav_menu": false,
      "nonclickable": false
    }, {
      "id": "679221979880523079",
      "title": "My Wallet",
      "url": "my-wallet.html",
      "target": "",
      "nav_menu": false,
      "nonclickable": false
    }],
    "471949740448456849",
    '',
    'active',
    false, {
      "navigation\/item": "<li {{#id}}id=\"{{id}}\"{{\/id}} class=\"wsite-menu-item-wrap\n    {{#is_current}}site-menu-active{{\/is_current}}\n    {{#has_children}}site-menu-parent{{\/has_children}}\">\n  <a\n    {{^nonclickable}}\n      {{^nav_menu}}\n        href=\"{{url}}\"\n      {{\/nav_menu}}\n    {{\/nonclickable}}\n    {{#target}}\n      target=\"{{target}}\"\n    {{\/target}}\n    {{#membership_required}}\n      data-membership-required=\"{{.}}\"\n    {{\/membership_required}}\n    {{#nonclickable}}data-dead-link{{\/nonclickable}}\n    class=\"wsite-menu-item {{#nonclickable}}dead-link{{\/nonclickable}}\"\n    >\n    {{{title_html}}}\n  <\/a>\n  {{#has_children}}{{> navigation\/flyout\/list}}{{\/has_children}}\n<\/li>\n",
      "navigation\/flyout\/list": "<ul class=\"site-submenu\">\n  {{#children}}{{> navigation\/flyout\/item}}{{\/children}}\n<\/ul>\n",
      "navigation\/flyout\/item": "<li\n  {{#id}}id=\"{{id}}\"{{\/id}}\n  class=\"\n    site-submenu-item\n    {{#is_current}}site-submenu-active{{\/is_current}}\n    {{#has_children}}site-submenu-parent{{\/has_children}}\n  \"\n>\n  <a\n    {{^nonclickable}}\n      {{^nav_menu}}\n        href=\"{{url}}\"\n      {{\/nav_menu}}\n    {{\/nonclickable}}\n    {{#target}}\n      target=\"{{target}}\"\n    {{\/target}}\n    class=\"site-submenu-link\"\n  >{{{title_html}}}<\/a>\n\n  {{#has_children}}\n    {{> navigation\/flyout\/list}}\n  {{\/has_children}}\n<\/li>\n"
    }, {
      "hasCustomMinicart": true
    }
  )
}


function initCustomerAccountsModels() {
      (function(){_W.setup_rpc({"url":"\/ajax\/api\/JsonRPC\/CustomerAccounts\/","actions":{"CustomerAccounts":[{"name":"login","len":2,"multiple":false,"standalone":false},{"name":"logout","len":0,"multiple":false,"standalone":false},{"name":"getSessionDetails","len":0,"multiple":false,"standalone":false},{"name":"getAccountDetails","len":0,"multiple":false,"standalone":false},{"name":"getOrders","len":0,"multiple":false,"standalone":false},{"name":"register","len":4,"multiple":false,"standalone":false},{"name":"emailExists","len":1,"multiple":false,"standalone":false},{"name":"passwordReset","len":1,"multiple":false,"standalone":false},{"name":"passwordUpdate","len":3,"multiple":false,"standalone":false},{"name":"validateSession","len":1,"multiple":false,"standalone":false}]},"namespace":"_W.CustomerAccounts.RPC"});
_W.setup_model_rpc({"rpc_namespace":"_W.CustomerAccounts.RPC","model_namespace":"_W.CustomerAccounts.BackboneModelData","collection_namespace":"_W.CustomerAccounts.BackboneCollectionData","bootstrap_namespace":"_W.CustomerAccounts.BackboneBootstrap","models":{"CustomerAccounts":{"_class":"CustomerAccounts.Model.CustomerAccounts","defaults":null,"validation":null,"types":null,"idAttribute":null,"keydefs":null}},"collections":{"CustomerAccounts":{"_class":"CustomerAccounts.Collection.CustomerAccounts"}},"bootstrap":[]});
})();
}
if(document.createEvent && document.addEventListener) {
  var initEvt = document.createEvent('Event');
  initEvt.initEvent('customerAccountsModelsInitialized', true, false);
  document.dispatchEvent(initEvt);
} else if(document.documentElement.initCustomerAccountsModels === 0){
  document.documentElement.initCustomerAccountsModels++
}
