<html>
<head>
  <link rel="stylesheet" href="${createLinkTo(dir: 'js', file: 'extjs/resources/css/ext-all.css')}"></link>
  <link rel="stylesheet" href="${createLinkTo(dir: 'js', file: 'extjs/examples/ux/css/RowEditor.css')}"></link>
  <link rel="stylesheet" href="${createLinkTo(dir: 'js', file: 'extjs/examples/restful/restful.css')}"></link>
  <link rel="stylesheet" href="${createLinkTo(dir: 'js', file: 'extjs/examples/shared/examples.css')}"></link>
  <link rel="stylesheet" href="${createLinkTo(dir: 'js', file: 'extjs/examples/shared/icons/silk.css')}"></link>
  <script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'extjs/adapter/ext/ext-base.js')}"></script>
  <script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'extjs/ext-all-debug.js')}"></script>
  <script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'extjs/examples/shared/extjs/App.js')}"></script>

  <script type="text/javascript">

  </script>

  <script type="text/javascript">

    // This cookie saves settings for next time. Stateful must be true
    Ext.BLANK_IMAGE_URL = '../js/extjs/resources/images/default/s.gif';
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    Ext.QuickTips.init();

    Ext.ns('Bpas');

    Bpas.FormPanel = Ext.extend(Ext.form.FormPanel, {
      border:true,
      frame:true,
      labelAlign: 'left',
      labelWidth:80,
      bodyStyle: 'padding:5px'
    });


    Ext.onReady(function() {


      // Application instance for showing user-feedback messages - Deeee.

      Ext.Ajax.defaultHeaders = { 'Content-Type': 'application/json' };


      var App = new Ext.App({});

      // Create a standard HttpProxy instance.
      var proxy = new Ext.data.HttpProxy({
        url: '../rest/extfile'
      });

      // Typical JsonReader.  Notice additional meta-data params for defining the core attributes of your json-response
      var reader = new Ext.data.JsonReader({
        successProperty: 'success',
        idProperty: 'id',
        root: 'data',
        messageProperty: 'message'  // <-- New "messageProperty" meta-data
      }, [
        {
          name: 'class'
        },
        {
          name: 'id'
        },
        {
          name: 'field1',
          type: 'string'
        },
        {
          name: 'field2',
          type: 'string'
        },
        {
          name: 'field3',
          type: 'string'
        }
      ]);

      // The new DataWriter component.
      var writer = new Ext.data.JsonWriter({
        encode: false,   // <-- don't return encoded JSON -- causes Ext.Ajax#request to send data using jsonData config rather than HTTP params
        writeAllFields: true,
        // Change format of data so it fits to Grails
        apply: function(params, baseParams, action, rs) {
          params.jsonData = rs;
        },
        render : function(http, baseParams, data) {
          http.jsonData = data;
        }

      });

      // Typical Store collecting the Proxy, Reader and Writer together.
      //      var store = new Ext.data.Store({
      var store = new Ext.data.Store({
        id: 'extfile',
        restful: true,     // <-- This Store is RESTful
        proxy: proxy,
        reader: reader,
        writer: writer    // <-- plug a DataWriter into the store just as you would a Reader
      });

      // load the store immeditately
      store.load();

      ////
      // ***New*** centralized listening of DataProxy events "beforewrite", "write" and "writeexception"
      // upon Ext.data.DataProxy class.  This is handy for centralizing user-feedback messaging into one place rather than
      // attaching listenrs to EACH Store.
      //
      // Listen to all DataProxy beforewrite events
      //
      Ext.data.DataProxy.addListener('beforewrite', function(proxy, action) {
        App.setAlert(App.STATUS_NOTICE, "Before " + action);
      });

      ////
      // all write events
      //
      Ext.data.DataProxy.addListener('write', function(proxy, action, result, res, rs) {
        App.setAlert(true, action + ':' + res.message);
      });

      ////
      // all exception events
      //
      Ext.data.DataProxy.addListener('exception', function(proxy, type, action, options, res) {
        App.setAlert(false, "Something bad happend while executing " + action);
      });


      // Let's pretend we rendered our grid-columns with meta-data from our ORM framework.
      var userColumns = [
        {
          header: "ID",
          width: 10,
          dataIndex: 'id'
        },
        {
          header: "Field 1",
          width: 10,
          sortable: true,
          dataIndex: 'field1',
          editor: new Ext.form.TextField({selectOnFocus:true})
        },
        {
          header: "Field 2",
          width
                  :
                  40,
          sortable
                  :
                  true,
          dataIndex
                  :
                  'field2',
          editor
                  :
                  new Ext.form.TextField({selectOnFocus:true})
        }
        ,
        {
          header: "Field 3",
          width
                  :
                  15,
          dataIndex
                  :
                  'field3',
          editor
                  :
                  new Ext.form.NumberField({selectOnFocus:true})
        }
      ]
              ;


      // use RowEditor for editing
      var editor = new Ext.ux.grid.RowEditor({
        saveText: 'Update'
      });

      // Create a typical GridPanel with RowEditor plugin
      var userGrid = new Ext.grid.GridPanel({
        renderTo: 'user-grid',
        iconCls: 'icon-grid',
        frame: true,
        title: 'Template edit list ${appName}.',
        autoScroll: true,
        //          autoHeight: true,
        height: 300,
        store: store,
        stripeRows: true,
        plugins: [editor],
        columns : userColumns,
        tbar: [
          {
            text: 'Add',
            iconCls: 'silk-add',
            handler: onAddRecord
          },
          '-',
          {
            text: 'Delete',
            iconCls: 'silk-delete',
            handler: onDelete
          },
          '-'
        ],
        stateId: 'usergrid',
        stateful: true,
        viewConfig: {
          forceFit: true

        }
      });

      /**
       * onAdd
       */
      function onAdd(btn, ev) {


        var u = new userGrid.store.recordType({
          'class' : 'extfile',
          id : 0,
          field1: 'abc',
          field2: 'def',
          field3 : 'ghij'
        });
        editor.stopEditing();
        userGrid.store.insert(0, u);
        editor.startEditing(0);
      }


      /**
       * onAdd
       */
      function onAddRecord(btn, ev) {

        nav.load({
          url:'./create',
          text: 'Henter data',
          scripts: true
        });
      }

      ;


      /**
       * onDelete
       */
      function onDelete() {
        var rec = userGrid.getSelectionModel().getSelected();
        if (!rec) {
          return false;
        }
        userGrid.store.remove(rec);
      }


      // tabs for the center
      var centerpanel = new Ext.Panel({
        id: 'center-panel',
        region: 'center',
        margins:'3 3 3 0',
        layout: 'fit',
        defaults:{autoScroll:true},
        items:[userGrid]
      });

      // Panel for the west
      var nav = new Ext.Panel({
        title: 'navigation',
        region: 'west',
        split: true,
        width: 200,
        collapsible: true,
        margins:'3 0 3 3',
        cmargins:'3 3 3 3'
      });

      var view = new Ext.Viewport({
        title: 'Layout Window',
        closable:true,
        width:600,
        height:350,
        //border:false,
        plain:true,
        layout: 'border',

        items: [nav,centerpanel]
      });

      view.show(this);


    });





  </script>


  <script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'extjs/examples/ux/RowEditor.js')}"></script>

  <meta name="layout" content="main"/>
</head>
<body>

<div class="container" style="width:1000px">
  <div id="user-grid"></div>
</div>

</body>
</html>