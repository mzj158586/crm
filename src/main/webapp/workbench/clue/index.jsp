<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        pageList(1,2)
            $(".time").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "top-right"
            });



        $("#addBtn").click(function () {


            $.ajax({
                url:"workbench/clue/getUserList.do",
                dataType:"json",
                type:"get",
                success:function (reg) {
                    var str=""
                    $.each(reg,function (i,n) {
                        str+="<option value='"+n.id+"'>"+n.name+"</option>"
                    })
                    $("#create-owner").html(str)
                    $("#create-owner").val("${user.id}")
                    $("#createClueModal").modal("show")
                }



            })


        })

        $("#savaBtn").click(function () {
            $.ajax({
                url:"workbench/clue/savaClue.do",
                data:{
                    "fullname":$.trim($("#create-fullname").val()),
                    "appellation":$.trim($("#create-appellation").val()),
                    "owner":$.trim($("#create-owner").val()),
                    "company":$.trim($("#create-company").val()),
                    "job":$.trim($("#create-job").val()),
                    "email":$.trim($("#create-email").val()),
                    "phone":$.trim($("#create-phone").val()),
                    "website":$.trim($("#create-website").val()),
                    "mphone":$.trim($("#create-mphone").val()),
                    "state":$.trim($("#create-state").val()),
                    "source":$.trim($("#create-source").val()),
                    "description":$.trim($("#create-description").val()),
                    "contactSummary":$.trim($("#create-contactSummary").val()),
                    "nextContactTime":$.trim($("#create-nextContactTime").val()),
                    "address":$.trim($("#create-address").val())
                },
                dataType:"json",
                type:"post",
                success:function (reg) {

                    if (reg.flag){

                        $("#createClueModal").modal("hide")
                        $("#updateBtn")[0].reset();
                        pageList(1,2)

                    }else{
                        alert("保存失败")
                    }
                }
            })

        })

        $("#selectbtn").click(function () {


             $("#hidden-fullname").val($.trim($("#clue-fullname").val()))
             $("#hidden-company").val($.trim($("#clue-company").val()))
             $("#hidden-mphone").val($.trim($("#clue-mphone").val()))
             $("#hidden-source").val($.trim($("#clue-source").val()))
             $("#hidden-owner").val($.trim($("#clue-owner").val()))
             $("#hidden-phone").val($.trim($("#clue-phone").val()))
             $("#hidden-state").val($.trim($("#clue-state").val()))


            pageList(1,2)

        })

        $("#editBtn").click(function(){

           var id = $("input[name=checksign]:checked");

            if(id.length>1){
               alert("修改数量不能超过 1 个")
            }else if(id.length<1){

                alert("请选择修改项目")
            }else {
                id=$(id).val()
                $.ajax({
                    url:"workbench/clue/selectById.do",
                    data:{
                        "id":id
                    },
                    dataType:"json",
                    type:"get",
                    success:function (reg) {

                      var str=""
                        $.each(reg.userList,function (i,n) {
                            str+='<option value="'+n.id+'">'+n.name+'</option>'
                        })
                        $("#edit-owner").html(str)
                        $("#editClueModal").modal("show")

                        $("#edit-owner").val(reg.clue.owner)
                        $("#edit-id").val(id)
                        $("#edit-company").val(reg.clue.company)
                        $("#edit-appellation").val(reg.clue.appellation)
                        $("#edit-job").val(reg.clue.job)
                        $("#edit-email").val(reg.clue.email)
                        $("#edit-phone").val(reg.clue.phone)
                        $("#edit-mphone").val(reg.clue.mphone)
                        $("#edit-website").val(reg.clue.website)
                        $("#edit-state").val(reg.clue.state)
                        $("#edit-source").val(reg.clue.source)
                        $("#edit-address").val(reg.clue.address)
                        $("#edit-description").val(reg.clue.description)
                        $("#edit-contactSummary").val(reg.clue.contactSummary)
                        $("#edit-nextContactTime").val(reg.clue.nextContactTime)
                        $("#edit-fullname").val(reg.clue.fullname)
                    }
                })

            }

        })

        $("#update").click(function () {

            $.ajax({
                url:"workbench/clue/updateClue.do",
                data: {
                    "id":$.trim($("#edit-id").val()),
                    "owner": $.trim($("#edit-owner").val()),
                    "company": $.trim($("#edit-company").val()),
                    "appellation": $.trim($("#edit-appellation").val()),
                    "job": $.trim($("#edit-job").val()),
                    "email": $.trim($("#edit-email").val()),
                    "phone": $.trim($("#edit-phone").val()),
                    "mphone": $.trim($("#edit-mphone").val()),
                    "website": $.trim($("#edit-website").val()),
                    "state": $.trim($("#edit-state").val()),
                    "source": $.trim($("#edit-source").val()),
                    "address": $.trim($("#edit-address").val()),
                    "description": $.trim($("#edit-description").val()),
                    "contactSummary": $.trim($("#edit-contactSummary").val()),
                    "nextContactTime": $.trim($("#edit-nextContactTime").val()),
                    "fullname": $.trim($("#edit-fullname").val())

                },
                dataType:"json",
                  type:"post",
                success:function (reg) {
                    if(reg.flag){
                        $("#editClueModal").modal("hide")
                        pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                            ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                    }else {

                        alert("更新失败")
                    }

                }

            })

        })


        $("#checkall").click(function () {

            $("input[name=checksign]").prop("checked",this.checked)

        })

        $("#showtable").on("click",$("input[name=checksign]"),function () {

            $("#checkall").prop("checked",$("input[name=checksign]").length==$("input[name=checksign]:checked").length)

        })

        $("#deleteBtn").click(function () {

            var ids=$("input[name=checksign]:checked")

            if (ids.length==0){
                alert("请选择要删除的选项")
            } else{
                if(confirm("是否要删除？")){
                    str=""
                    $.each(ids,function (i,n) {

                        str+=($(n).val())+","

                    })
                    $.ajax({
                        url:"workbench/clue/deleteClue.do",
                        data:{
                            "ids":str
                        },
                        dataType:"json",
                        type:"post",
                        success:function (reg) {

                            if(reg.flag){
                                $("#checkall").prop("checked",false)
                                pageList(1,2);

                            }else{


                            }

                        }

                    })

                }


            }

        })


	});

	function  pageList(pageNo,pageSize){


        $("#clue-fullname").val($.trim($("#hidden-fullname").val()))
        $("#clue-company").val($.trim($("#hidden-company").val()))
        $("#clue-mphone").val($.trim($("#hidden-mphone").val()))
        $("#clue-source").val($.trim($("#hidden-source").val()))
        $("#clue-owner").val($.trim($("#hidden-owner").val()))
        $("#clue-phone").val($.trim($("#hidden-phone").val()))
        $("#clue-state").val($.trim($("#hidden-state").val()))




	    $.ajax({
            url:"workbench/clue/selectPageList.do",
            data:{
                "pageNo":pageNo,
                "pageSize":pageSize,
                "fullName":$.trim($("#clue-fullname").val()),
                "company":$.trim($("#clue-company").val()),
                "mphone":$.trim($("#clue-mphone").val()),
                "source":$.trim($("#clue-source").val()),
                "owner":$.trim($("#clue-owner").val()),
                "phone":$.trim($("#clue-phone").val()),
                "state":$.trim($("#clue-state").val())

            },
            dataType:"json",
            type:"get",
            success:function (reg) {

                    var str=""
                    $.each(reg.list,function (i,n) {
                     str+=' <tr>';
                     str+=' <td><input type="checkbox" name="checksign"  value="'+n.id+'" /></td>';
                     str+=' <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/clue/detailClue.do?id='+n.id+'\';">'+n.fullname+'</a></td>';
                     str+=' <td>'+n.company+'</td>';
                     str+=' <td>'+n.mphone+'</td>';
                     str+=' <td>'+n.phone+'</td> <td>'+n.source+'</td>'
                      str+=  '<td>'+n.owner+'</td>'
                     str+=  '  <td>'+n.state+'</td> </tr>';
                    })
                    $("#showtable").html(str)

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



	
</script>
</head>
<body>

	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="updateBtn">
					<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
							<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-appellation">
								  <option></option>
                                    <c:forEach items="${appellation}" var="c">
                                        <option value="${c.value}">${c.text}</option>

                                    </c:forEach>
								</select>
							</div>
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-fullname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
							<label for="create-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
							<label for="create-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-state">
								  <option></option>
                                    <c:forEach items="${clueState}" var="c">
                                        <option value="${c.value}">${c.text}</option>

                                    </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source">
								  <option></option>
                                    <c:forEach items="${source}" var="c">
                                        <option value="${c.value}">${c.text}</option>

                                    </c:forEach>
								</select>
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">线索描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
						
						<div style="position: relative;top: 20px;">
							<div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address"></textarea>
                                </div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"  id="savaBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-appellation">
								  <option></option>
                                    <c:forEach items="${appellation}" var="c">
                                        <option value="${c.value}">${c.text}</option>

                                    </c:forEach>
								</select>
							</div>
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-fullname" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" >
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" >
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" >
							</div>
							<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-state">
								  <option></option>
                                    <c:forEach items="${clueState}" var="c">

                                        <option value="${c.value}">${c.text}</option>

                                    </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
								  <option></option>
                                    <c:forEach items="${source}" var="c">
                                        <option value="${c.value}">${c.text}</option>

                                    </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="edit-nextContactTime" >
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="update">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>线索列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                    <input type="hidden" id="hidden-fullname"/>
                    <input type="hidden" id="hidden-company"/>
                    <input type="hidden" id="hidden-source"/>
                    <input type="hidden" id="hidden-state"/>
                    <input type="hidden" id="hidden-mphone"/>
                    <input type="hidden" id="hidden-phone"/>
                    <input type="hidden" id="hidden-owner"/>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="clue-fullname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司</div>
				      <input class="form-control" type="text" id="clue-company">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="clue-mphone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索来源</div>
					  <select class="form-control" id="clue-source">
					  	  <option></option>
                          <c:forEach items="${source}" var="c">
                              <option value="${c.value}">${c.text}</option>

                          </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="clue-owner">
				    </div>
				  </div>
				  
				  
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">手机</div>
				      <input class="form-control" type="text" id="clue-phone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索状态</div>
					  <select class="form-control" id="clue-state">
					  	<option></option>
                          <c:forEach items="${clueState}" var="c">
                              <option value="${c.value}">${c.text}</option>

                          </c:forEach>
					  </select>
				    </div>
				  </div>

				  <button type="button" class="btn btn-default" id="selectbtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary"   id="addBtn"><span class="glyphicon glyphicon-plus" ></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn" ><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn" ><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkall" /></td>
							<td>名称</td>
							<td>公司</td>
							<td>公司座机</td>
							<td>手机</td>
							<td>线索来源</td>
							<td>所有者</td>
							<td>线索状态</td>
						</tr>
					</thead>
					<tbody id="showtable">
						<%--
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四先生</a></td>
                            <td>动力节点</td>
                            <td>010-84846003</td>
                            <td>12345678901</td>
                            <td>广告</td>
                            <td>zhangsan</td>
                            <td>已联系</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 60px;" >
				<div id="activityPage">

                </div>
			</div>
			
		</div>
		
	</div>
</body>
</html>