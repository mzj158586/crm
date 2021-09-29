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
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){

        $("#remarkBody").on("mouseover",".remarkDiv",function(){
            $(this).children("div").children("div").show();
        })
        $("#remarkBody").on("mouseout",".remarkDiv",function(){
            $(this).children("div").children("div").hide();
        })


		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});


        /*javascript:void(0)
        * 将超链接禁用，只能以触发事件的形式来操作
        *
        * */
        showRemark()


        $("#savaRemarkBtn").click(function () {

            $.ajax({

                url:"workbench/activity/saveRemark.do",
                data:{
                    "noteContent":$.trim($("#remark").val()),
                    "activityId":"${activity.id}"

                },
                dataType:"json",
                type:"post",
                success:function (reg) {

                    if(reg.flag){
                        var str=""
                        str+='        <div class="remarkDiv" style="height: 60px;" id="'+reg.activityRemark.id+'">';
                        str+='        <img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                        str+='        <div style="position: relative; top: -40px; left: 40px;" >';
                        str+='        <h5>'+reg.activityRemark.noteContent+'</h5>';
                        str+="<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>${activity.name}</b> <small style=\"color: gray;\">"+(reg.activityRemark.createTime)+" 由"+(reg.activityRemark.createBy)+"</small>"
                        str+='    <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                        str+='        <a class="myHref" href="javascript:void(0);" onclick="edit(\''+reg.activityRemark.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
                        str+='    &nbsp;&nbsp;&nbsp;&nbsp;';
                        str+='<a class="myHref" href="javascript:void(0);" onclick="remove(\''+reg.activityRemark.id+'\')" ><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                        str+='    </div>';
                        str+='    </div>';
                        str+='    </div>';

                        $("#remarkDiv").before(str)

                    }

                }

            })
            $("#remark").val("")

        })

        $("#updateRemarkBtn").click(function () {
            var id=$("#remarkId").val()
            $.ajax({
                url:"workbench/activity/updateRemark.do",
                data:{
                    "id":id,
                    "noteContent":$.trim($("#noteContent").val())

                },
                type:"post",
                dataType:"json",
                success:function (reg) {
                    if(reg.flag){
                        $("#e"+id).html(reg.activityRemark.noteContent)
                        $("#s"+id).html(reg.activityRemark.editTime+"由"+reg.activityRemark.editBy)

                        $("#editRemarkModal").modal("hide")
                    }else {
                        alert("跟新失败")
                    }


                }


            })


        })



	});

    function edit (id){

        $("#remarkId").val(id)
        $("#editRemarkModal").modal("show")

        var noteContent=$("#e"+id).html();
        $("#noteContent").val(noteContent);

    }


    function remove(id) {

        $.ajax({
            url:"workbench/activity/remarkRemove.do",
            data:{"id":id},
            type:"post",
            dataType:"json",
            success:function (reg) {
                if (reg.flag){
                   $("#"+id).remove()

                }

            }


        })

    }



	function showRemark() {

        $.ajax({

            url:"workbench/activity/selectActivityRemart.do",
            data:{"id":'${activity.id}'},
            dataType:"json",
            type:"get",
            success:function (reg) {
                ';'
                <!-- 备注1 -->';'
                var str="" ;
                $.each(reg,function (i,n) {
                    str+='        <div class="remarkDiv" style="height: 60px;" id="'+n.id+'">';
                    str+='        <img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                    str+='        <div style="position: relative; top: -40px; left: 40px;" >';
                    str+='        <h5 id="e'+n.id+'">'+n.noteContent+'</h5>';
                    str+='<font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small style="color: gray;" id="s'+n.id+'">'+(n.editFlag==0?n.createTime:n.editTime)+' 由'+(n.editFlag==0?n.createBy:n.editBy)+'</small>'
                    str+='    <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                    str+='        <a class="myHref" href="javascript:void(0);" onclick="edit(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
                    str+='    &nbsp;&nbsp;&nbsp;&nbsp;';
                    str+='<a class="myHref" href="javascript:void(0);" onclick="remove(\''+n.id+'\')" ><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                    str+='    </div>';
                    str+='    </div>';
                    str+='    </div>';

                })
                $("#remarkDiv").before(str)

            }

        })

    }

	
</script>

</head>
<body>


<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
            </div>
        </div>
    </div>
</div>


	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-${activity.name} <small>2020-10-10 ~ 2020-10-20</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${activity.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;" id="remarkBody">
		<div class="page-header">
			<h4>备注</h4>
		</div>







		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="savaRemarkBtn">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>