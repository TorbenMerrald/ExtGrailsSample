
<%@ page import="com.bpas.Extfile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'extfile.label', default: 'Extfile')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${extfileInstance}">
            <div class="errors">
                <g:renderErrors bean="${extfileInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="field3"><g:message code="extfile.field3.label" default="Field3" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: extfileInstance, field: 'field3', 'errors')}">
                                    <g:textField name="field3" value="${extfileInstance?.field3}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="field2"><g:message code="extfile.field2.label" default="Field2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: extfileInstance, field: 'field2', 'errors')}">
                                    <g:textField name="field2" value="${extfileInstance?.field2}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="field1"><g:message code="extfile.field1.label" default="Field1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: extfileInstance, field: 'field1', 'errors')}">
                                    <g:textField name="field1" value="${extfileInstance?.field1}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
