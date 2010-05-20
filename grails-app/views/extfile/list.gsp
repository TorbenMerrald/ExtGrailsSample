
<%@ page import="com.bpas.Extfile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'extfile.label', default: 'Extfile')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'extfile.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="field3" title="${message(code: 'extfile.field3.label', default: 'Field3')}" />
                        
                            <g:sortableColumn property="field2" title="${message(code: 'extfile.field2.label', default: 'Field2')}" />
                        
                            <g:sortableColumn property="field1" title="${message(code: 'extfile.field1.label', default: 'Field1')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${extfileInstanceList}" status="i" var="extfileInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${extfileInstance.id}">${fieldValue(bean: extfileInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: extfileInstance, field: "field3")}</td>
                        
                            <td>${fieldValue(bean: extfileInstance, field: "field2")}</td>
                        
                            <td>${fieldValue(bean: extfileInstance, field: "field1")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${extfileInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
