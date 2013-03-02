library list_games;

import 'dart:html';
import 'dart:json';
import 'nav_bar.dart';
import 'util.dart';

class list_games_form {
    DivElement content;

    list_games_form() {
        content = new Element.html("<div></div>");
        content.id = "view_game";
        get_string("list_games.php", "", (resp) {
            List games = parse(resp);
            games.forEach( (Map game) {
                DivElement InfoDiv = new DivElement();
                InfoDiv.classes.add('game_name');
                var gamename = game["game_name"];
                var gameid = game["game_id"];
                var link = new Element.html("<a href=/#page=view_game;gameid=${gameid}>${gamename}</a>");
                InfoDiv.children.add(link);
                content.children.add(InfoDiv);
            });
        });
    }
}

void main() {
    try {
        main_wrapped();
    } on Exception
    catch (ex) {
        document.window.alert(ex.toString());
    }
}

void main_wrapped() {
    query('#main').children.add(new nav_bar().content);
    var game_div = new DivElement();
    game_div.id = "game-view";
    query('#main').children.add(game_div);
    query('#game-view').children.add(new list_games_form().content);
}
