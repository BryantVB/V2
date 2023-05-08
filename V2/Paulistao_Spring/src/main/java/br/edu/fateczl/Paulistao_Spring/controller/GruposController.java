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

import br.edu.fateczl.Paulistao_Spring.model.grupos;
import br.edu.fateczl.Paulistao_Spring.persistence.GruposDao;

@Controller
public class GruposController {

	
	
	@Autowired
	GruposDao gDao;
	
	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("grupos");
	}

	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		List<grupos> grupoA = new ArrayList<grupos>();
		List<grupos> grupoB = new ArrayList<grupos>();
		List<grupos> grupoC = new ArrayList<grupos>();
		List<grupos> grupoD = new ArrayList<grupos>();
		try {
			if(botao.equalsIgnoreCase("Listar")) {
				grupoA = gDao.listargrupoA();
				grupoB = gDao.listargrupoB();
				grupoC = gDao.listargrupoC();
				grupoD = gDao.listargrupoD();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			}
		return new ModelAndView("grupos");
	}
}
