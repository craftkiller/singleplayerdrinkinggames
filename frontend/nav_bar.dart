library nav_bar;
import 'dart:html';
import 'login.dart';

void generate_nav_bar() {
    query('#nav_bar_container').children.clear();
    query('#nav_bar_container').children.add(new nav_bar().content);
}

class nav_bar {
    DivElement content;
    nav_bar() {
        content = new DivElement();
        content.id = "nav_bar";

        var link_list = ["Home", "Games", "Submit Game", "Search", "Chat"];

        var link_map = {
            "Home" : "index",
            "Games" : "list_games",
            "Login" : "login",
            "Register" : "register",
            "Submit Game" : "game_submission",
            "Search" : "search",
            "Chat" : "chat"
        };
        link_list.forEach( (e) {
                var page = link_map[e];
                var link_html = new Element.html("<a href=/#page=${page}> ${e} </a>");
                content.children.add(link_html);
            });
        Map user_data = get_login_details();
        if (user_data == null) {
            //User not logged in
            for (var e in ["Login", "Register"]) {
                var page = link_map[e];
                var link_html = new Element.html("<a href=/#page=${page}> ${e} </a>");
                content.children.add(link_html);
            }
        } else {
            content.children.add(new Element.html("<span>Logged in as: ${user_data['username']}</span>"));
            content.children.add(new Element.html("<a href=\"logout.php\">Log Out</a>"));
        }
    }
}
