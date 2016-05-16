@JurisdictManagementCtrl = ['$scope','$location','base','user','alert','notify','ivhTreeviewMgr',($scope,$location,base,user,alert,notify,ivhTreeviewMgr) -> 

  $scope.title = "管辖权限分配"
  $scope.treeList = treeListTest = []
  treeListTest = [{
    id: 13,
    path: '0,13,',
    parent_id: 0,
    name: '贵州省'
  },{
    id: 15,
    path: '0,13,15',
    parent_id: 13,
    name: '贵阳市'
  },{
    id: 17,
    path: '0,26,27,17,',
    parent_id: 27,
    name: '贵阳市111'
  },{
    id: 26,
    path: '0,26,',
    parent_id: 0,
    name: 'shanghai'
  },{
    id: 27,
    path: '0,26,27,',
    parent_id: 26,
    name: 'hsanghai'
  }]

  _getJurisdictList = () ->
    user.jurisdictManagementList().then (d)->
      treeListTest.each (item) ->
        if !item.parent_id
          $scope.treeList.push({
            id: item.id,
            name: item.name,
            parent_id: item.parent_id,
            children: _transformChild(item.id),
            path: item.path
          })
      console.log $scope.treeList
      return
    return

  _getJurisdictList()

  _transformChild = (id) ->
    children = []
    treeListTest.find (n) -> 
      if n.parent_id is id
        children.push({
          id: n.id,
          name: n.name,
          path: n.path,
          parent_id: n.parent_id,
          child: n.child or []
        })
        return
    if children.length>0
      children.each (item) ->
        item.children = _transformChild(item.id)
    return children

  return
]