<#--

    Copyright © 2016 Mathias Kowalzik (Mathias.Kowalzik@leandreck.org)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<#-- @ftlvariable name="" type="org.leandreck.endpoints.processor.model.EndpointNode" -->
<#function buildUrl variables url>
    <#assign result = url>
    <#list variables as item>
        '/api/{value}/{some}'
        '/api/' + value + '/' + some + ''
        <#assign result = result?replace('{', '')>
    </#list>
    <#return result>
</#function>
<#list types as type>
import { ${type.typeName} } from './${type.typeName?lower_case}.model.generated';
</#list>

import { HttpClient, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/observable/throw';
import 'rxjs/add/operator/map';

@Injectable()
export class ${serviceName} {
    private serviceBaseURL = '${serviceURL}';
    constructor(private httpClient: HttpClient) { }
    /* GET */
<#list getGetMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Get(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list>): Observable<${method.returnType.type}> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.get<${method.returnType.type}>(url)
            .catch((error: Response) => this.handleError(error));
    }

</#list>

    /* HEAD */
<#list getHeadMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Head(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list>): Observable<${method.returnType.type}> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.head<${method.returnType.type}>(url)
            .catch((error: Response) => this.handleError(error));
    }

</#list>

    /* POST */
<#list getPostMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Post(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list><#if method.pathVariableTypes?size gt 0>, </#if>${method.requestBodyType.fieldName}: ${method.requestBodyType.type}): Observable<${method.returnType.type}> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.post<${method.returnType.type}>(url, ${method.requestBodyType.fieldName})
            .catch((error: Response) => this.handleError(error));
    }

</#list>

    /* PUT */
<#list getPutMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Put(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list><#if method.pathVariableTypes?size gt 0>, </#if>${method.requestBodyType.fieldName}: ${method.requestBodyType.type}): Observable<${method.returnType.type}> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.put<${method.returnType.type}>(url, ${method.requestBodyType.fieldName})
            .catch((error: Response) => this.handleError(error));
    }

</#list>

    /* PATCH */
<#list getPatchMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Patch(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list><#if method.pathVariableTypes?size gt 0>, </#if>${method.requestBodyType.fieldName}: ${method.requestBodyType.type}): Observable<${method.returnType.type}> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.patch<${method.returnType.type}>(url, ${method.requestBodyType.fieldName})
            .catch((error: Response) => this.handleError(error));
    }

</#list>

    /* DELETE */
<#list getDeleteMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Delete(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list>): Observable<${method.returnType.type}> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.delete<${method.returnType.type}>(url)
          .catch((error: Response) => this.handleError(error));
    }

</#list>

    /* OPTIONS */
<#list getOptionsMethods() as method>
    <#assign expandedURL = method.url?replace('{', '\' + ')>
    <#assign expandedURL = expandedURL?replace('}', ' + \'')>
    public ${method.name}Options(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list><#if method.pathVariableTypes?size gt 0>, </#if>): Observable<ArrayBuffer> {
        const url = this.serviceBaseURL + '${expandedURL}';
        return this.httpClient.options<${method.returnType.type}>(url)
            .catch((error: Response) => this.handleError(error));
    }

</#list>

    <#--/* TRACE NOT SUPPORTED BY HTTPCLIENT*/-->
<#--<#list getTraceMethods() as method>-->
    <#--<#assign expandedURL = method.url?replace('{', '\' + ')>-->
    <#--<#assign expandedURL = expandedURL?replace('}', ' + \'')>-->
    <#--public ${method.name}Trace(<#list method.pathVariableTypes as variable>${variable.fieldName}: ${variable.type}<#sep>, </#sep></#list><#if method.pathVariableTypes?size gt 0>, </#if>${method.requestBodyType.fieldName}: ${method.requestBodyType.type}): Observable<${method.returnType.type}> {-->
        <#--const url = this.serviceBaseURL + '${expandedURL}';-->
        <#--const request = new HttpRequest<${method.requestBodyType.type}>('TRACE', url, ${method.requestBodyType.fieldName}, {-->
            <#--responseType: 'json'-->
        <#--});-->
        <#--return this.httpClient.request<${method.returnType.type}>(request)-->
            <#--.catch((error: Response) => this.handleError(error));-->
    <#--}-->

<#--</#list>-->

    private handleError(error: Response) {
        // in a real world app, we may send the error to some remote logging infrastructure
        // instead of just logging it to the console
        console.error(error);
        return Observable.throw(error);
    }

}
