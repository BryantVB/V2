package br.edu.fateczl.Paulistao_Spring.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.Paulistao_Spring.model.time;
import br.edu.fateczl.Paulistao_Spring.persistence.TimeDao;

@Controller
public class TimeController {
	@Autowired
	TimeDao tDao;
	
	@RequestMapping(name = "times", value = "/times", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("times");
	}

	@RequestMapping(name = "times", value = "/times", method = RequestMethod.POST)
	public ModelAndView initi(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		List<time> times = new ArrayList<time>();
		
		try {
			if(botao.equalsIgnoreCase("listar")) {
				times = tDao.listarTimes();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("times", times);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			}
		return new ModelAndView("times");
	}
	
}







