library age_verification;
import 'dart:html';
import 'util.dart';

class age_verification {
    DivElement content;

    /**
     * Creates the form that prompts viewer to verify if they are at least 18 years of age
     * before being allow access to the site
     */
    age_verification() {
        content = new Element.html("<div></div>");
        content.nodes.add(new Element.html("<h2>Please verify your age</h2>"));
        content.nodes.add(new Element.html("<br>"));
        ButtonElement over = new Element.html("<button>I am at least 18 years old</button>");
        content.nodes.add(over);
        content.nodes.add(new Element.html("<a href=\"http://disney.com/\">I am under 18 years old</a>"));

        over.onClick.listen((e) {
                set_cookie("over18", "true", seconds: 86400);
                window.location = "#page=index";
            });
    }
}
