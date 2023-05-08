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

import br.edu.fateczl.Paulistao_Spring.model.jogos;
import br.edu.fateczl.Paulistao_Spring.persistence.DataJogoDao;

@Controller
public class DataJogoController {

	@Autowired
	DataJogoDao djDao;
	
	@RequestMapping(name = "dataJogo", value = "/dataJogo", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("dataJogo");
	}

	@RequestMapping(name = "dataJogo", value = "/dataJogo", method = RequestMethod.POST)
	public ModelAndView dataJogo(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String data = allParam.get("data");
		String erro = "";
		String saida = "";
		
		List<jogos> jogos = new ArrayList<>();
		
		try {
			
			if(botao.equalsIgnoreCase("Listar")) {
				jogos = djDao.listarjogos(data);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("jogos", jogos);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			}
		return new ModelAndView("dataJogo");
	}
	
	
}
