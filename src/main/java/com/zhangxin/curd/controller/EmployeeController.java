package com.zhangxin.curd.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhangxin.curd.bean.Employee;
import com.zhangxin.curd.bean.Msg;
import com.zhangxin.curd.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//处理员工的增删改查请求
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    // 删除员工
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            //批量删除
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.delteBatch(del_ids);
        } else {
            //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


    //得到员工基本信息(查询员工)
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    // 保存员工(员工更新方法)
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveMsg(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    //检查用户名是否可用
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        // 检查用户名是否是合法表达式
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5}$)";
        if (!empName.matches(regName)) {
            return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文字符的组合");
        }

        //数据库用户名重复校验
        boolean judge = employeeService.checkUser(empName);
        if (judge) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "数据重复,用户名不可用");
        }
    }

    // 支持jsr303校验，需要导入Hibernate-Validator
    // 保存对象方法时需要在对象前面加上一个@Valid注解(表示封装对象之后里面的对象要进行检验),后面紧跟封装结果
    // 员工保存
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            //封装错误信息,提交给浏览器
            Map<String, Object> map = new HashMap<String, Object>();
            // 校验失败,应该返回失败,在模态框中显示校验失败的错误信息
            //提取校验失败信息
            List<FieldError> fieldError = bindingResult.getFieldErrors();
            for (FieldError fieldError1 : fieldError) {
                /* System.out.println("错误的字段名"+fieldError1.getField());
                 System.out.println("错误的信息"+fieldError1.getDefaultMessage());*/
                map.put(fieldError1.getField(), fieldError1.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    // 把返回的字符串转换为json字符串(ResponseBody需要导入jackson包)
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //引入PageHelper分页插件(在查询之前只需调用startPage方法，从第几页开始查询，每页显示多少条数据)
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这条查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，第二个参数表示需要连续显示的页数(传入连续显示的页数)
        // 只需要将pageInfo交给页面就行了,封装了详细的分页信息,包括查询出来的数据
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }


    //查询员工数据（分页查询）
    @RequestMapping("/emps1")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //引入PageHelper分页插件(在查询之前只需调用startPage方法，从第几页开始查询，每页显示多少条数据)
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这条查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，第二个参数表示需要连续显示的页数(传入连续显示的页数)
        // ，只需要将pageInfo交给页面就行了,封装了详细的分页信息,包括查询出来的数据
        PageInfo page = new PageInfo(emps, 5);
        //把page交给页面
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
