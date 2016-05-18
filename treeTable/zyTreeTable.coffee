angular.module('zyClient.directives').directive('zyTreeTable',['$compile',($compile)->

  return {
    restrict: 'E',
    replace: true,
    scope: 
      "treeData": "="           #数据列表
      "modelData": "="          #定义每列的model
      "operData": "="           #定义操作列名称
    link: (scope,iElement,iAttrs)->
      console.log iAttrs
      scope.checkHasChild = checkHasChild = iAttrs.checkHasChild
      scope.checkLevel = iAttrs.checkLevel
      scope.checkByField = checkByField = iAttrs.checkByField

      itemList = scope.modelData
      template = '<div></div>'
      linkFun =  $compile(template)
      iElement.append linkFun(scope)

  }


])