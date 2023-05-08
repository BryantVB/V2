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

import br.edu.fateczl.Paulistao_Spring.model.JogoInfo;
import br.edu.fateczl.Paulistao_Spring.persistence.ConsultaGrupoDao;

@Controller
public class ConsultaGrupoController {

	@Autowired
	ConsultaGrupoDao cgDao;
	
	@RequestMapping(name = "consultaGrupo", value = "/consultaGrupo", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("consultaGrupo");
	}

	@RequestMapping(name = "consultaGrupo", value = "/consultaGrupo", method = RequestMethod.POST)
	public ModelAndView consultagrupo(ModelMap model, @RequestParam Map<String, String> allParam) {
		List<JogoInfo> jogosInf = new ArrayList<>();
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		
		try {
			if(botao.equalsIgnoreCase("Pesquisar")) {
				System.out.println("Pesquisar");
				jogosInf = cgDao.listainfo(allParam.get("grupo"));
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			System.out.println(jogosInf.get(0));
			model.addAttribute("jogosInf", jogosInf);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
		return new ModelAndView("consultaGrupo");
	}	
	}
}
