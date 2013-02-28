library util;

import 'dart:html';

/** 
 * Asynchronously call the server and pass the string of the output to the callback function
 *
 * @param address The address to call
 * @param url_data url encoded variables
 * @param callback The function to pass the string to when the data is returned
 */
void get_string(String address, String url_data, callback)
{
    HttpRequest request = new HttpRequest();
  
    request.onLoad.listen((Event event) {
            callback(request.responseText);
        });
  
    // POST the data to the server
    request.open("POST", address, true);
    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    request.send(url_data); // perform the async POST
}

/** 
 * Synchronously call the server and return the string from the output
 *
 * @param address The address to call
 * @param url_data url encoded variables
 *
 * @return The output from the call to the server
 */
String get_string_synchronous(String address, String url_data)
{
    HttpRequest request = new HttpRequest();
  
    // POST the data to the server
    request.open("POST", address, false);
    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    request.send(url_data); // perform the sync POST
    return request.responseText;
}

/** 
 * Retrieve the string value of a cookie with the corresponding name
 *
 * @param name The name of the cookie
 *
 * @return The string value of the cookie, or null if not found
 */
String get_cookie(String name)
{
    List<String> cookies = document.cookie.split(";");
    for (int i = 0; i < cookies.length; ++i) {
        List<String> split = cookies[i].split("=");
        if (split[0].trim() == name.trim()) {
            return split[1].trim();
        }
    }
    return null;
}

String get_url_variable(String name)
{
    String hash_string = window.location.hash.replaceFirst('#', '');
    List<String> variables = hash_string.split(";");
    for (int i = 0; i < variables.length; ++i) {
        List<String> split = variables[i].split("=");
        if (split[0].trim() == name.trim()) {
            return split[1].trim();
        }
    }
    return null;
}

/** 
 * Generate the date time string for cookies
 *
 * @param local_time The DateTime in local time
 *
 * @return The formatted string in UTC
 */
String generate_expires_string(DateTime local_time)
{
    DateTime time = local_time.toUtc();
    String ret = "";
    if (time.weekday == DateTime.MON) {
        ret = "${ret}Mon, ";
    } else if (time.weekday == DateTime.TUE) {
        ret = "${ret}Tue, ";
    } else if (time.weekday == DateTime.WED) {
        ret = "${ret}Wed, ";
    } else if (time.weekday == DateTime.THU) {
        ret = "${ret}Thu, ";
    } else if (time.weekday == DateTime.FRI) {
        ret = "${ret}Fri, ";
    } else if (time.weekday == DateTime.SAT) {
        ret = "${ret}Sat, ";
    } else if (time.weekday == DateTime.SUN) {
        ret = "${ret}Sun, ";
    }
    ret = "${ret}${time.day} ";
    if (time.month == DateTime.JAN) {
        ret = "${ret}Jan ";
    } else if (time.month == DateTime.FEB) {
        ret = "${ret}Feb ";
    } else if (time.month == DateTime.MAR) {
        ret = "${ret}Mar ";
    } else if (time.month == DateTime.APR) {
        ret = "${ret}Apr ";
    } else if (time.month == DateTime.MAY) {
        ret = "${ret}May ";
    } else if (time.month == DateTime.JUN) {
        ret = "${ret}Jun ";
    } else if (time.month == DateTime.JUL) {
        ret = "${ret}Jul ";
    } else if (time.month == DateTime.AUG) {
        ret = "${ret}Aug ";
    } else if (time.month == DateTime.SEP) {
        ret = "${ret}Sep ";
    } else if (time.month == DateTime.OCT) {
        ret = "${ret}Oct ";
    } else if (time.month == DateTime.NOV) {
        ret = "${ret}Nov ";
    } else if (time.month == DateTime.DEC) {
        ret = "${ret}Dec ";
    }
    ret = "${ret}${time.year} ${time.hour}:${time.minute}:${time.second} GMT";
    return ret;
}

/** 
 * Create a new cookie
 *
 * @param name The cookie's name
 * @param value The value to assign to the cookie
 * @param seconds The number of seconds the cookie should exist, pass null to never expire cookie
 */
void set_cookie(String name, String value, int seconds)
{
    if (seconds != null) {
        DateTime now = new Date.now();
        DateTime expires = now.add(new Duration(seconds: seconds));
        document.cookie = "${name}=${value}; expires=${generate_expires_string(expires)}";
    } else {
        document.cookie = "${name}=${value};";
    }
}

/** 
 * Delete the named cookie
 *
 * @param name The name of the cookie
 */
void delete_cookie(String name)
{
    document.cookie = "${name}=; expires=Thu, 01 Jan 1970 00:00:01 GMT";
}
