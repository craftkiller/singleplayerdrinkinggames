import 'dart:html';
import 'nav_bar.dart';
import 'register.dart';
import 'login.dart';
import 'list_games.dart';
import 'submit_game.dart';
import 'view_game.dart';
import 'search.dart';
import 'main_page.dart';
import 'util.dart';
import 'age_verification.dart';
import 'chat.dart';

/*
 * Calls to the appropriate webpages.
 */

void display_register() {
    query("#content").children.clear();
    query("#content").children.add(new register_form().content);
}

void display_login() {
    query("#content").children.clear();
    query("#content").children.add(new login_form().content);
}

void display_main_page() {
    query("#content").children.clear();
    query("#content").children.add(new main_page().content);
}

void display_list_games() {
    query("#content").children.clear();
    query("#content").children.add(new list_games_form().content);
}

void display_view_game() {
    query("#content").children.clear();
    query("#content").children.add(new view_game_form().content);
}

void display_game_submission() {
    query("#content").children.clear();
    query("#content").children.add(new submit_game_form().content);
}

void display_search() {
    query("#content").children.clear();
    query("#content").children.add(new search_form().content);
}

void display_age_verification() {
    query("#content").children.clear();
    query("#content").children.add(new age_verification().content);
}

void display_chat() {
    query("#content").children.clear();
    String room = get_url_variable("room");
    if (room == null)
        query("#content").children.add(new chat_box("main").content);
    else
        query("#content").children.add(new chat_box(room).content);
}

void handle_history() {
    // Handle all page routing and history based on "page" url variable
    String over18 = get_cookie("over18");
    if (over18 == null || over18 != "true") {
        display_age_verification();
        return;
    }
    String page_name = get_url_variable("page");
    if (page_name == null) {
        display_main_page();
        return;
    }
    switch (page_name) {
      case "login":
        display_login();
        break;
      case "register":
        display_register();
        break;
      case "list_games":
        display_list_games();
        break;
      case "view_game":
        display_view_game();
        break;
      case "game_submission":
        display_game_submission();
        break;
      case "search":
        display_search();
        break;
      case "chat":
        display_chat();
        break;
      case "index":
        /* Falls Through */
      default:
        display_main_page();
      break;
    }
}

main() {
    try {
        main_wrapped();
    } catch (ex) {
        document.window.alert(ex.toString());
    }
}

main_wrapped() {
    DivElement nav_bar_container = new Element.html("<div id=\"nav_bar_container\"></div>");
    query('#main').children.add(nav_bar_container);
    generate_nav_bar();
    DivElement content = new Element.html("<div id=\"content\">content goes here</div>");
    query('#main').children.add(content);
    handle_history();
    window.onPopState.listen((event) {handle_history();});
}
