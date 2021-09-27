<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
request.getServerPort() + request.getContextPath() + "/";
%>


<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>"/>
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>


<script type="text/javascript">

	$(function(){

        timeStyle()

	    /*添加按钮*/
		$("#addbtn").click(function () {

		    /*时间格式*/
            timeStyle()

		    /*
		    * 操作模态窗口的方式
		    *   需要操作的模态窗口的jquery对象 ，调用modal方法 ，为该方法传递参数 show 打开模态窗口 hide 关闭模态窗口
		    *
		    * */

            showname()


        })


        /*保存数据请求到数据库*/
        $("#savabtn").click(function () {

            $.ajax({

                url:"workbench/activity/sava.do",
                data:{
                  "owner":$.trim($("#create-owner").val()),
                    "name":$.trim($("#create-name").val()),
                    "startDate":$.trim($("#create-startdata").val()),
                    "endDate":$.trim($("#create-enddata").val()),
                    "cost":$.trim($("#create-cost").val()),
                    "description":$.trim($("#create-description").val())
                },
                dataType:"json",
                type:"post",
                success:function (data) {

                    if (data.flag){
                        $("#savaform")[0].reset();
                        $("#createActivityModal").modal("hide")

                        pageList(1,2);

                    } else {
                        alert("添加失败")
                    }

                }

            })


        })


        /*查询操作*/
        $("#selectActivitybtn").click(function () {

            $("#hidden-name ").val($.trim($("#activity-name").val()))
           $("#hidden-owner").val($.trim($("#activity-owner").val()))
            $("#hidden-startDate").val($.trim($("#activity-startDate").val()))
            $("#hidden-endDate").val($.trim($("#activity-endDate").val()))

            pageList(1,2);
        })

        pageList(1,2);

        $("#checkboxAll").click(function () {

            $("input[name=checkboksigle]").prop("checked",this.checked)


        })
        /*
        * 语法：
        *$(需要绑定元素的有效的外层元素).on(绑定事件的方式，需要绑定的元素的jquery对象，回调函数)
        *
        * */
        $("#activity-tbody").on("click",$("input[name=checkboksigle]"),function () {
            $("#checkboxAll").prop("checked",$("input[name=checkboksigle]").length==$("input[name=checkboksigle]:checked").length)
        })


        /*删除操作*/
        $("#deletebtn").click(function () {
            var str="";
            var ids=$("input[name=checkboksigle]:checked");
            if(ids.length==0){

                alert("请选择要删除的活动")

            }else{

                if(confirm("是否要删除"+ids.length+"条记录")){


                    $.each(ids,function (i,n) {

                        id=($(n).val())
                        str+=id+",";

                    })

                    $.ajax({
                        url:"workbench/activity/deleteActivity.do",
                        data:{
                            "ids":str
                        },
                        dataType:"json",
                        type:"post",
                        success:function (reg) {
                            if(reg.flag){
                                alert("成功");
                                pageList(1,2);
                                $("#checkboxAll").prop("checked",false)

                            }else {
                                alert("失败")
                            }
                        }

                    })

                }

            }

        })



        /*编辑按钮*/
        $("#editbtn").click(function () {

            /*
            * 操作模态窗口的方式
            *   需要操作的模态窗口的jquery对象 ，调用modal方法 ，为该方法传递参数 show 打开模态窗口 hide 关闭模态窗口
            *
            * */
            var id=$("input[name=checkboksigle]:checked")
            if (id.length>1){

                alert("一次只能编辑一个")


            }else if(id.length<1){

                alert("未勾选")
            }else{

                id=$(id).val()
                $.ajax({

                    url:"workbench/activity/selectById.do",
                    data:{"id":id},
                    type:"get",
                    dataType:"json",
                    success:function (reg) {
                        var str=""
                        $.each(reg.userList,function (i,n) {

                            str+="<option value='"+n.id+"'>"+n.name+"</option>"

                        })

                        $("#edit-owner").html(str)
                        $("#edit-owner").val(reg.activity.owner)

                        $("#editActivityModal").modal("show")
                        $("#edit-id").val(reg.activity.id)
                        $("#edit-name").val(reg.activity.name)
                        $("#edit-startDate").val(reg.activity.startDate)
                        $("#edit-endDate").val(reg.activity.endDate)
                        $("#edit-cost").val(reg.activity.cost)
                        $("#edit-description").val(reg.activity.description)

                    }

                })

            }



        })


        /*修改提交*/
        $("#updatebtn").click(function () {

            $.ajax({
                url:"workbench/activity/updateActivity.do",
                data:{
                    "id":$("#edit-id").val(),
                    "owner":$("#edit-owner").val(),
                    "name":$.trim($("#edit-name").val()),
                    "startDate":$.trim($("#edit-startDate").val()),
                    "endDate":$.trim($("#edit-endDate").val()),
                    "cost":$.trim($("#edit-cost").val()),
                    "description":$.trim($("#edit-description").val())

                },
                type:"post",
                dataType:"json",
                success:function (reg) {
                    if(reg.flag){

                        alert("更新成功")
                        $("#editActivityModal").modal("hide")
                        pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                            ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                    }else {
                        alert("更新失败")
                    }
                }


            })


        })




    });


	function pageList(pageNo,pageSize) {

        $("#activity-name").val($.trim($("#hidden-name").val()))
        $("#activity-owner").val($.trim($("#hidden-owner").val()))
        $("#activity-startDate").val($.trim($("#hidden-startDate").val()))
        $("#activity-endDate").val($.trim($("#hidden-endDate").val()))

	    $.ajax({

            url:"workbench/activity/selectPageList.do",
            data:{
                "pageNo":pageNo,
                "pageSize":pageSize,
                "name":$.trim($("#activity-name").val()),
                "owner":$.trim($("#activity-owner").val()),
                "startDate":$.trim($("#activity-startDate").val()),
                "endDate":$.trim($("#activity-endDate").val())
            },
            dataType:"json",
            type:"get",
            success:function (reg) {

                var str=""
                $.each(reg.list,function (i,n) {
                    str+='<tr class="active">'
                    str+='<td><input type="checkbox" value="'+n.id+'" name="checkboksigle" /></td>'
                    str+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.jsp\';">'+n.name+'</a></td>'
                    str+='<td>'+n.owner+'</td>'
                    str+='<td>'+n.startDate+'</td>'
                    str+='<td>'+n.endDate+'</td>'
                    str+='</tr>'

                })

                $("#activity-tbody").html(str)

                $("#activityPage").bs_pagination({
                    currentPage: pageNo, // 页码
                    rowsPerPage: pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages:reg.pages, // 总页数
                    totalRows:  reg.total, // 总记录条数

                    visiblePageLinks: 3, // 显示几个卡片

                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,

                    onChangePage : function(event, data){
                        pageList(data.currentPage , data.rowsPerPage);
                    }
                });
            }

        })



    }


    function timeStyle() {

        $(".time").datetimepicker({
            minView: "month",
            language:  'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            pickerPosition: "bottom-left"
        });

    }


    function showname() {

        /*显示模态窗口里面的下拉列表*/
        $.ajax({
            url:"workbench/activity/getUserList.do",
            type:"get",
            dataType:"json",
            success:function (data) {
                var str=""
                $.each(data,function (i,n) {

                    str+="<option value='"+n.id+"'>"+n.name+"</option>"

                })

                $("#create-owner").html(str)
                $("#create-owner").val("${user.id}")

                $("#createActivityModal").modal("show")
            }

        })

    }


	
</script>
</head>
<body>


	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="savaform" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startdata" readonly>
							</div>
							<label for="create-endTime" class="col-sm-2 control-label" >结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control  time" id="create-enddata" readonly>
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="savabtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal"   role="form">

                        <input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name" >
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate" >
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="updatebtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	


	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                    <input type="hidden" id="hidden-name"   />
                    <input type="hidden" id="hidden-owner"   />
                    <input type="hidden" id="hidden-startDate"   />
                    <input type="hidden" id="hidden-endDate"   />

				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="activity-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="activity-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control time" type="text" id="activity-startTime"  readonly/>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control  time" type="text" id="activity-endTime" readonly>
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="selectActivitybtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addbtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id ="editbtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id ="deletebtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead >
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox"  id="checkboxAll" /></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activity-tbody">


					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;" >
                <div id="activityPage">



                </div>

			</div>
			
		</div>
		
	</div>
</body>
</html>