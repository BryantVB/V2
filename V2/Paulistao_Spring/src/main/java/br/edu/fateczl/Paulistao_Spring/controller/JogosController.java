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
import br.edu.fateczl.Paulistao_Spring.persistence.JogoDao;

@Controller
public class JogosController {

	@Autowired
	JogoDao jDao;
	
	
	@RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("jogos");
	}

	@RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.POST)
	public ModelAndView jogos(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		List<jogos> jogos = new ArrayList<jogos>();
		
		try {
			if(botao.equalsIgnoreCase("Criar")) {
				jDao.criarJogo(); 
			}
			if(botao.equalsIgnoreCase("Listar")) {
				jogos = jDao.listarJogo();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("jogos", jogos);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			}
		return new ModelAndView("jogos");
	}
	
}
