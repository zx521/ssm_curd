package com.zhangxin.curd.test;


import com.zhangxin.curd.bean.Department;
import com.zhangxin.curd.bean.Employee;
import com.zhangxin.curd.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.zhangxin.curd.dao.DepartmentMapper;

import java.util.UUID;

//测试dao层工作

//spring 项目可以使用spring的单元测试，可以自动注入我们需要的组件
//1.导入spring单元测试的模块@ContextConfiguration 2.@ContextConfiguration指定spring配置文件的位置
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
//3.指定用哪一个单元测试来运行，现在用spring的单元测试
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {

    //4.直接autowired使用即可
    @Autowired
    DepartmentMapper departmentMapper;

    //注入批量的sqlSession
    @Autowired
    SqlSession sqlSession;

    @Autowired
    EmployeeMapper employeeMapper;

    //测试DepartmentMapper
    @Test
    public void testCURD() {
        // 原生注入spring //1.注入spring IOC容器
        //ApplicationContext ioc = new  ClassPathXmlApplicationContext("applicationContext.xml");
        //2.从容器中获取mapper
        //DepartmentMapper departmentMapper =  ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
        // 插入几个部门
       // departmentMapper.insertSelective(new Department(1,"开发部"));
       // departmentMapper.insertSelective(new Department(2,"测试部"));

        // 生成员工数据，测试员工插入
        // employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry.@atguigu.com", 1));

        // 批量插入多个员工，使用可以进行批量操作的 sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            // 获取姓名
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(i+1, uid, "M", uid+"@atguigu.com", 1));
        }
        System.out.println("插入成功");
    }
}
