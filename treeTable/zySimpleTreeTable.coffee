angular.module('zyClient.directives').directive('zySimpleTreeTable',['$timeout', ($timeout)->
  return {
    restrict: 'E',
    replace: true,
    templateUrl: '/template/simpleTreeTable.html',
    scope: 
      "treeData": "="           #数据列表
      "modelData": "="          #定义每列的model
      "operData": "="           #定义操作列名称
    link: (scope,iElement,iAttrs) ->
      console.log scope.operData
      scope.checkHasChild = checkHasChild = iAttrs.checkHasChild
      scope.checkLevel = iAttrs.checkLevel
      scope.checkByField = checkByField = iAttrs.checkByField

      #判断是否有子节点
      scope.hasChild = (path) ->
        if !path
          return
        else 
          return !!scope.treeData.find((n) -> n[checkHasChild].startsWith(path) and n[checkHasChild] isnt path)

      $timeout(()->

        iElement.find('.simple-tree-table-oper a').on 'click',(e)->
          console.log 'a'
          e.preventDefault()
          e.stopPropagation()
          index = $(this).index()
          id = $(this).data('id')
          item = scope.treeData.find (n)-> n if n.id is id 
          scope.$emit scope.operData[index].funcName,item
          return

        iElement.find('.simple-tree-table').on 'click',() ->
          console.log 'tr'
          id = $(this).data('id')
          scope.$apply ()->
            #找到该节点下所有子节点是否已展开
            isFlag = true
            scope.treeData.find (n)->
              if n[checkByField].startsWith(id) and n[checkByField] isnt id
                isFlag = n.isShow && isFlag
                return 
            #设置子节点isShow为当前展开取反
            #设置子节点icon为当前展开取反
            #设置当前节点为展开并且icon为取反
            scope.treeData.each (n)->
              if n[checkByField].startsWith(id) and n[checkByField] isnt id
                n.isShow = !isFlag
                n.icon = !isFlag
              if n[checkByField] is id
                n.isShow = false
                n.icon = !isFlag
              return
            return
          return
        return
      ,100)
  }

])