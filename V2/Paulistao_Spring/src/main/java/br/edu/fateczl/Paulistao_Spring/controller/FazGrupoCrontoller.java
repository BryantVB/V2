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
import br.edu.fateczl.Paulistao_Spring.persistence.FazGrupoDao;

@Controller
public class FazGrupoCrontoller {

	@Autowired
	FazGrupoDao fgDao;
	
	
	@RequestMapping(name = "fazgrupo", value = "/fazgrupo", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("fazgrupo");
	}

	@RequestMapping(name = "fazgrupo", value = "/fazgrupo", method = RequestMethod.POST)
	public ModelAndView fazgrupo(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		List<grupos> grupos = new ArrayList<grupos>();
		
		try {
			if(botao.equalsIgnoreCase("Gerar")) {
				fgDao.Fazergrupos();
				grupos = fgDao.listargrupos();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("grupos", grupos);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			}
		return new ModelAndView("fazgrupo");
	}
}
