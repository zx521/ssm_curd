package com.zhangxin.curd.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    //自定义规则需要加上Pattern注解
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5}$)",
            message = "数据库校验用户名必须是2-5位中文或者6-16位英文字符的组合")
    private String empName;

    private String gender;

    @Pattern(regexp = "([a-z0-9_\\.]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})",message = "数据库校验:邮箱格式不正确")
    private String email;

    private Integer dId;

    //查询员工的同时部门信息也是查询好的
    private  Department department;

    public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Employee() {
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}