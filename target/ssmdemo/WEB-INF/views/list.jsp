<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--引入核心标签库 便利得到数据--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <%--以/开始的相对路径,找资源,以服务器路径为标准，生成项目名:http://localhost:3306/ssmdemo--%>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
    <title>员工列表</title>
    <%--    <!-- 引入jQuery -->--%>
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
            <button class="btn  btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <br/>
    <!--显示表格数据行-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>ID</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <!--便利员工数据,取名叫emp-->
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <!--显示分页信息行-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,共${pageInfo.pages}页,总共${pageInfo.total}条记录
        </div>
        <!-- 分页条信息-->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Number">
                        <c:if test="${pageInfo.pageNum==page_Number}">
                            <li class="active"><a href="${APP_PATH}/emps?pn=${page_Number}">${page_Number}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum!=page_Number}">
                            <li ><a href="${APP_PATH}/emps?pn=${page_Number}">${page_Number}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
