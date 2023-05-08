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
import br.edu.fateczl.Paulistao_Spring.persistence.GolsDao;
import br.edu.fateczl.Paulistao_Spring.persistence.TimeDao;

@Controller
public class GolsController {

	@Autowired
	GolsDao goDao;
	
	@Autowired
	TimeDao tDao;
	
	@RequestMapping(name = "gols", value = "/gols", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		
		List<time> times = new ArrayList<>();
	    String erro = "";
	    String saida = "";
	    try {
	    		times = tDao.listarTimes();
	    		System.out.println(times);
	    	
	    } catch (SQLException | ClassNotFoundException e) {
	    	erro = e.getMessage();
	    } finally {
	    	model.addAttribute("saida", saida);
	    	model.addAttribute("erro", erro);
	    	model.addAttribute("times", times);
	    }
		return new ModelAndView("gols");
	}

	@RequestMapping(name = "gols", value = "/gols", method = RequestMethod.POST)
	public ModelAndView dataJogo(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String timeA = allParam.get("timeA");
		String timeB = allParam.get("timeB");
		String saida = "";
		String erro = "";
		try {
			String nomeA = timeA;
			String nomeB = timeB;
			int golsA = Integer.parseInt(allParam.get("golsA"));
			int golsB = Integer.parseInt(allParam.get("golsB"));
			String data_jogo = allParam.get("data_jogo");
			if(botao.equalsIgnoreCase("Atualizar")) {
				System.out.println(nomeA + nomeB + golsA + golsB + data_jogo);
				
				saida = goDao.alterarGols(nomeA, nomeB, golsA, golsB, data_jogo);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("gols");
	}
	
}
