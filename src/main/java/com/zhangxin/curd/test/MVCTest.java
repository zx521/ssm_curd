package com.zhangxin.curd.test;

// 使用spring测试模块提供的测试请求功能，测试分页请求的正确性

import com.github.pagehelper.PageInfo;
import com.zhangxin.curd.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/smvc-servlet.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MVCTest {

    //传入springMVC的ioc(Autowired只能Autowired容器里面的ioc,容器自己需要@WebAppConfiguration注入)
    @Autowired
    WebApplicationContext webApplicationContext;

    //虚拟mvc请求 ，获取处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        //创建MocMVC,需要被创建出来才能被使用
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    //测试分页的方法
    @Test
    public void testPage() throws Exception {
        //模拟发送请求并拿到返回值，需要requestBuilder
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

        // 请求成功以后，先拿到请求对象,再从请求域中拿pageInfo,我们可以取出pageInfo进行验证
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:" + pageInfo.getPageNum());
        System.out.println("总页码:" + pageInfo.getPages());
        System.out.println("总记录数:" + pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码:");
        for (int i : pageInfo.getNavigatepageNums()) {
            System.out.print(" " + i);
        }
        System.out.println();
        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee employee: list){
            System.out.println("ID:"+employee.getEmpId()+"==>Name"+employee.getEmpName() );
        }
    }
}
