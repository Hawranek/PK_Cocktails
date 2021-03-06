package pl.coderslab.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import pl.coderslab.entity.Card;
import pl.coderslab.entity.Cocktail;
import pl.coderslab.entity.User;
import pl.coderslab.jsonclasses.CocktailList;
import pl.coderslab.repository.CardRepository;
import pl.coderslab.repository.UserRepository;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/app/card")
public class CardController {

    private final CardRepository cardRepository;
    private final UserRepository userRepository;

    @ModelAttribute("user")
    public User user(HttpServletRequest request) {
        return userRepository.getUserByUsername(request.getUserPrincipal().getName());
    }

    public CardController(
            CardRepository cardRepository,
            UserRepository userRepository
    ) {
        this.cardRepository = cardRepository;
        this.userRepository = userRepository;
    }

    //wyświetlanie kart użytkownika z sesji
    @RequestMapping("/all")
    public String list(Model model, HttpServletRequest request) {
        model.addAttribute(
                "cards",
                cardRepository.findByUser(
                        user(request)));
        return "cards/list";
    }

    //dodawanie nowej karty dla danego użytkownika
    @GetMapping("/form")
    public String form(Model model, HttpServletRequest request) {
        Card card = new Card();
        card.setUser(user(request));
        model.addAttribute("card", card);
        return "cards/form";
    }

    //edytowanie karty danego użytkownika
    @GetMapping("/form/{id}")
    public String edit(@PathVariable Long id, Model model) {
        Card card = cardRepository.getById(id);
        model.addAttribute("card", card);
        return "cards/form";
    }

    //zapis dodawanej/edytowanej karty danego użytkownika
    @PostMapping("/form")
    public String addingCard(@Valid Card card, BindingResult result) {
        if (result.hasErrors()) {
            return "cards/form";
        }

        cardRepository.save(card);
        return "redirect:/app/card/all";
    }

    //usuwanie karty danego użytkownika
    @GetMapping("/del/{id}")
    public String delete(@PathVariable Long id) {
        cardRepository.deleteById(id);
        return "redirect:/app/card/all";
    }

    //wyświetlanie drinków w danej karcie
    @RequestMapping("/{id}/cocktails")
    public String cocktailList(@PathVariable Long id, Model model) {
        Card byId = cardRepository.findById(id).orElse(null);
        model.addAttribute("card", byId);
        model.addAttribute("cocktails", byId.getCocktails());
        return "drinks/cardcocktails";
    }

    //formularz: dodawanie cocktailu z API do karty
    @GetMapping("/addtocard/{drinkid}")
    public String addToCard(@PathVariable("drinkid") Long id, Model model, HttpServletRequest request) {
        RestTemplate restTemplate = new RestTemplate();
        String resource = String.format("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=%d", id);
        CocktailList cocktailList = restTemplate.getForObject(resource, CocktailList.class);
        Cocktail cocktail = cocktailList.getDrinks().get(0).parseToCocktail();

        List<Card> cardsByUser = cardRepository.findByUser(user(request));
        //dodanie kart do modelu? - DODANE

        model.addAttribute("cocktail", cocktail);
        model.addAttribute("cards", cardsByUser);
        return "drinks/addtocard";
    }

    //zapisywanie cocktailu z API do karty
    @PostMapping("/addtocard")
    public String add(
            Cocktail cocktail,
            @RequestParam("cardid") Long cardid
    ) {
        Card byId = cardRepository.findById(cardid).orElse(null);
        System.out.println(cocktail.toString());
        List<Cocktail> tmplist;
        if (byId.getCocktails() == null) {
            tmplist = new ArrayList<>();
        } else {
            tmplist = byId.getCocktails();
        }
        tmplist.add(cocktail);
        byId.setCocktails(tmplist);
        cardRepository.save(byId);      //cocktailu i składników nie trzeba zapisywać (cascade)
        return "redirect:/app/card/all";
    }
}
