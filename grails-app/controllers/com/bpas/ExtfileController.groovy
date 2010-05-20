package com.bpas

import grails.converters.XML
import grails.converters.JSON

class ExtfileController {

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def index = {
    redirect(action: "list", params: params)
  }

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [extfileInstanceList: Extfile.list(params), extfileInstanceTotal: Extfile.count()]
  }

  def create = {
    def extfileInstance = new Extfile()
    extfileInstance.properties = params
    return [extfileInstance: extfileInstance]
  }

  def save = {
    def extfileInstance = new Extfile(params)
    if (extfileInstance.save(flush: true)) {
      flash.message = "${message(code: 'default.created.message', args: [message(code: 'extfile.label', default: 'Extfile'), extfileInstance.id])}"
      redirect(action: "show", id: extfileInstance.id)
    }
    else {
      render(view: "create", model: [extfileInstance: extfileInstance])
    }
  }

  def show = {
    def extfileInstance = Extfile.get(params.id)
    if (!extfileInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'extfile.label', default: 'Extfile'), params.id])}"
      redirect(action: "list")
    }
    else {
      [extfileInstance: extfileInstance]
    }
  }


  def show_ext = {
    def extfileInstance = Extfile.get(params.id)
    println "id is ${extfileInstance.toString()}"
    if (extfileInstance) {
      withFormat {
        html {
          // render "Test"
        }
        json {
          if (!extfileInstance.hasErrors()) {
            render extfileInstance as JSON
          } else {
            render extfileInstance.errors as JSON
          }

        }
      }
    } else {

      // If no id specified or no record returned, then get all records

      def all = Extfile.findAll()
      withFormat {
        json {
          def json = [success: true, message: 'Successfully loaded', data: all]
          render json as JSON
        }
      }

    }
  }





  def edit = {
    def extfileInstance = Extfile.get(params.id)
    if (!extfileInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'extfile.label', default: 'Extfile'), params.id])}"
      redirect(action: "list")
    }
    else {
      return [extfileInstance: extfileInstance]
    }
  }

  def update = {
    def extfileInstance = Extfile.get(params.id)
    if (extfileInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (extfileInstance.version > version) {

          extfileInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'extfile.label', default: 'Extfile')] as Object[], "Another user has updated this Extfile while you were editing")
          render(view: "edit", model: [extfileInstance: extfileInstance])
          return
        }
      }
      extfileInstance.properties = params
      if (!extfileInstance.hasErrors() && extfileInstance.save(flush: true)) {
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'extfile.label', default: 'Extfile'), extfileInstance.id])}"
        redirect(action: "show", id: extfileInstance.id)
      }
      else {
        render(view: "edit", model: [extfileInstance: extfileInstance])
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'extfile.label', default: 'Extfile'), params.id])}"
      redirect(action: "list")
    }
  }

  def delete = {
    def extfileInstance = Extfile.get(params.id)
    if (extfileInstance) {
      try {
        extfileInstance.delete(flush: true)
        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'extfile.label', default: 'Extfile'), params.id])}"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'extfile.label', default: 'Extfile'), params.id])}"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'extfile.label', default: 'Extfile'), params.id])}"
      redirect(action: "list")
    }
  }
}
