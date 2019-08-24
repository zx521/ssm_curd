<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--引入核心标签库 便利得到数据--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <%-- 以/开始的相对路径,找资源,以服务器路径为标准，生成项目名:http://localhost:3306/ssmdemo --%>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
    <title>员工列表</title>
    <%--  <!-- 引入jQuery --> --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <!-- 引入样式 -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入js文件 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>

<!--显示页面-->
<div class="container">
    <!--标题行-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CURD</h1>
        </div>
    </div>
    <!--按钮行-->
    <div class="row">
        <!--两个按钮，并向右偏移-->
        <div class="col-md-4 col-md-offset-8">
            <button class="btn  btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <br/>
    <!--显示表格数据行-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>ID</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息行-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>

<!--员工修改的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <!-- 静态输入框 -->
                           <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label>
                                <!--  value指定提交是什么 -->
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked>男
                            </label>
                            <label>
                                <input type="radio" name="gender" id="gender2_update_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!--为了springmvc封装employee对象，唯一要去就是表单项的name跟javabean的属性名相同--->
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <!--校验失败错误信息放在span标签中--->
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label>
                                <!--  value指定提交是什么 -->
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked>男
                            </label>
                            <label>
                                <input type="radio" name="gender" id="gender2_add_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    // 记录总记录数
    var totalRecord,currentPage;

    // 当页面加载完成之后,发送一个ajax请求,要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // 取消选中全选复选框
                $("#check_all").prop("checked",false);
                //解析并显示员工信息
                build_emps_table(result);
                //解析显示分页信息
                build_page_info(result);
                //解析并显是分页条信息
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空表格数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        //遍历员工数据（第一个表示要遍历的元素,每次遍历的回调函数）回调函数里面第一个表示索引,第二个表示当前的对象
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            // 添加编辑按钮
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义属性表示当前员工id
            editBtn.attr("edit_id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            // 为删除按钮添加一个自定义属性表示当前删除员工id
            delBtn.attr("del_id",item.empId);
            //构建员工要显示的一行数据  (append方法执行执行后还是返回原来的元素)
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        });
    }

    function build_page_info(result) {
        // 清空分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页,共" +
            result.extend.pageInfo.pages + " 页,总共" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    function build_page_nav(result) {
        //清空分页导航信
        $("#page_nav_area").empty();
        //构建元素
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码信息
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        // 把ul加入到nav元素中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
            // 清除当前元素的校验状态,多个类样式用空格隔开
             $(ele).parent().removeClass("has-success has-error");
             $(ele).next("span").text("");
            if(status == "success"){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if (status=="error"){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
    }

    //清除表单样式及内容
    function  reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        reset_form("#empAddModal form");
        // 发送ajax请求,查出部门信息,显示在下拉列表中
        getDepts("#empAddModal select");
        // 弹出模态框
        $("#empAddModal").modal({
            //弹出对话框点击外面不关闭对话框(传入boolean或者static)
            backdrop: "static"
        });
    });

    // 查出所有部门信息并显示在下拉列表中
    function getDepts(ele) {
        // 清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            // 去向服务器要部门信息,depts表示能处理这个请求,获取部门所有信息
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // 遍历部门信息
                $.each(result.extend.depts, function () {
                    // option提交是部门的id值
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    //显示部门信息在下拉列表中(只有一个标签可以不用设置id值)
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //检验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                } else {
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    // 校验表单数据
    function validate_add_form() {
        // 1.拿到数据进行校验,使用正则表达式(校验名字信息)
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u4e00-\u9fa5]{2,5}$)/;
        if (!regName.test(empName)) {
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文字符的组合");
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文字符的组合");
            return;
        } else {
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
            show_validate_msg("#empName_add_input","success","");
        }
        // 校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return;
        } else {
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }

    // 点击保存 保存员工
    $("#emp_save_btn").click(function () {
        // 将模态框填写的数据提交给服务器进行保存

        // 判断发送的ajax用户名校验是否成功
        if ($(this).attr("ajax-va")=="error") {
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文字符的组合");
            return;
        }

        // 1.先对提交给服务器的数据进行校验
        if (!validate_add_form()) {
             return ;
         }

        // 2.发ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            //表格序列化
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code==100){
                    // alert(result.msg);
                    //员工保存成功后 1.关闭模态框
                    $("#empAddModal").modal("hide");
                    // 2.来到最后一页显示刚才保存的数据(发送ajax请求显示最后一页数据即可)
                    to_page(totalRecord);
                } else {
                    // 显示失败信息,有哪一个字段的错误信息就显示哪一个字段的
                    if(result.extend.errorFields.email != undefined ){
                            // 显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if (result.extend.errorFields.empName !=undefined){
                            // 显示员工名字的错误信息
                       show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });


    //创建按钮之前就绑定了点击事件，所以绑定不上。绑定.live()事件,jquery新版本没有live,使用on进行替代
    $(document).on("click",".edit_btn",function () {
        //查出部门信息，显示部门列表
        getDepts("#empUpdateModal select");
        // 查出员工信息,显示员工信息
        getEmp($(this).attr("edit_id"));
        // 把员工的id传给模态框的更新按钮
         $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        // 弹出模态框
        $("#empUpdateModal").modal({
            //弹出对话框点击外面不关闭对话框(传入boolean或者static)
            backdrop: "static"
        });
    });


    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                // 获取要修改的员工数据
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击更新按钮,更新员工信息
    $("#emp_update_btn").click(function () {
        // 验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return;
        } else {
            show_validate_msg("#email_update_input","success","");
        }

        // 发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            //法一:用POST请求改为PUT请求,data参数后面需要携带数据，需要在web.xml文件中进行配置
           /* type:"POST",
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",*/
           // 法二：直接发送PUT请求(需要在web.xml中进行配置)
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function () {
                // 关闭对话框
                $("#empUpdateModal").modal("hide")
                // 回到本页面
                to_page(currentPage);
            }
        });

    });

    // 点击删除按钮,删除员工信息(单个删除)
    $(document).on("click",".delete_btn",function (){
            //获取要删除的员工的姓名
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            // 获取要删除员工的id
            var empId = $(this).attr("del_id");
            // 弹出是否确认删除对话框
            if(confirm("确定删除员工["+empName+"]吗?")){
                // 确定删除,发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        to_page(currentPage);
                    }
                });
            }
    });

    //完成全选全部选功能
    $("#check_all").click(function () {
        //dom原生的属性，用prop修改或读取dom原生属性的值  attr()获取自定义的值
        // 全选
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    // 下面的单选框是否全选中上面的单选中也要跟着选中
    $(document).on("click",".check_item",function (){
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    // 点击全部删除 就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr ="";
        // 遍历每一个被选中的元素
        $.each($(".check_item:checked"),function () {
            // 组装员工名字的字符串
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id的字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-"
        })
        //去除empName最后一个逗号
        empNames  = empNames.substring(0,empNames.length-1);
        // 取出del_idstr最后一个-
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确定删除["+empNames+"]员工吗?")){
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    to_page(currentPage);
                }
            });
        }
    });

</script>

</body>

</html>
