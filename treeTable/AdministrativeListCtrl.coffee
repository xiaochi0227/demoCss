@AdministrativeListCtrl = ['$scope','$location','base','user','alert','notify','$timeout',($scope,$location,base,user,alert,notify,$timeout) -> 
	
	$scope.title = "行政区划管理"
	$scope.list = null

	#获取行政区划列表
	_getAdminiList = () -> 
		user.getAdministativeList (d) ->
			$scope.list = d
			return
		return

	#刷新
	$scope.flash_list = () ->
		_getAdminiList()
		return

	#判断是否有子节点
	$scope.hasChild = (path) ->
		if !path
			return
		else 
			return !!$scope.list.find((n) -> n.path.startsWith(path) and n.path isnt path)

	#新增
	$scope.doAdd = () ->
		notify.pop(
			"新增行政区划",
			'user_layout/administrative-add.html'
			{
				itemList: $scope.list
				callback: () ->
					$scope.doing = false
					alert.add 'success','新增行政区划成功'
					_getAdminiList()
					return
			}	
		)
		return

	
	#新增
	# $scope.doUpdate = (item) ->
	$scope.$on 'doUpdate',(event,item)->
		notify.pop(
			"编辑行政区划",
			'user_layout/administrative-add.html'
			{
				administrative: item,
				itemList: $scope.list,
				callback: () ->
					$scope.doing = false
					alert.add 'success','修改行政区划成功'
					# _getAdminiList()
					console.log $scope.list
					return
			}	
		)
		return


	#删除
	# $scope.doDelete = (id) ->
	$scope.$on 'doDelete',(event,item)->
		id = item.id
		notify.confirm '删除行政区划', '确定要删除该行政区划吗？', () ->
			user.deleteAdministrative id, (d) ->
				if d.err is 0
					alert.add 'success', '删除行政区划成功！'
					index = -1
					$.each $scope.list,(_,n)->
						if n.id is id
							index = _ 
							return false
					if index > 0 
						$scope.list.splice(index,1)
				return
			return
		return

	$scope.modelData = [{
		title: '行政区划名称',
		titleStyle: {
			width: '500px'
		},
		columnName: 'name',
		class: 'ellipsis'
	},{
		title: '描述',
		titleStyle: {
			width: 'auto'
		},
		columnName: 'desc',
		class: 'break-all'
	},{
		title: '操作',
		titleStyle: {
			width: '100px'
		},
		isOper: true
	}]

	$scope.operData = [{
		name: '修改',
		funcName: 'doUpdate'
	},{
		name: '删除',
		funcName: 'doDelete'
	}]

	_getAdminiList()


]

