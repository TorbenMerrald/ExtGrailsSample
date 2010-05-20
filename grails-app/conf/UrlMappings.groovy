class UrlMappings {
  static mappings = {

     "/rest/extfile/$id?"(controller: "extfile", parseRequest: true,
      action = [GET: 'show_ext', PUT: 'update', POST: 'save', DELETE: 'delete']  )


    "/$controller/$action?/$id?" {
      constraints {
        // apply constraints here
      }
    }

    "/"(view: "/index")
    "500"(view: '/error')
  }
}
