#define __gma_assert_error__
/// @function __gma_assert_error__(message, expected, got)
/// @param message The message to display to the user
/// @param expected The value expected for the assertion
/// @param got The actual received value for the assertion
{
  var gtbp = asset_get_index("__GMA_TEST_BREAKPOINT__"),
      gbp = asset_get_index("__GMA_BREAKPOINT__");
  if (GMASSERT_ENABLED && ((gtbp != -1 && !script_execute(gtbp, argument0, argument2, argument1)) || (gbp != -1 && gtbp == -1 && !script_execute(gbp, argument0, argument2, argument1)) || gbp == -1)) {
    var msg = argument0 + chr(13)+chr(10) + chr(13)+chr(10) + "Expected: " + __gma_debug_value__(argument1) + chr(13)+chr(10) + chr(13)+chr(10) + "Got: " + __gma_debug_value__(argument2) + chr(13)+chr(10) + chr(13)+chr(10);
    if (os_browser == browser_not_a_browser) {
      show_error(msg, true);
    }
    else {
      show_message(msg);
    }
  }
}

#define __gma_assert_error_simple__
/// @function __gma_assert_error_simple__(message, got)
/// @param message The message to display to the user
/// @param got The actual received value for the assertion
{
  var gtbp = asset_get_index("__GMA_TEST_BREAKPOINT__"),
      gbp = asset_get_index("__GMA_BREAKPOINT__");
  if (GMASSERT_ENABLED && ((gtbp != -1 && !script_execute(gtbp, argument0, argument1, "")) || (gbp != -1 && gtbp == -1 && !script_execute(gbp, argument0, argument1, "")) || gbp == -1)) {
    var msg = argument0 + chr(13) + chr(13);
    if (os_browser == browser_not_a_browser) {
      show_error(msg, true);
    }
    else {
      show_message(msg);
    }
  }
}

#define __gma_assert_error_raw__
/// @function __gma_assert_error_raw__(message, expected, got)
/// @param message The message to display to the user
/// @param expected The value expected for the assertion
/// @param got The actual received value for the assertion
{
  var gtbp = asset_get_index("__GMA_TEST_BREAKPOINT__"),
      gbp = asset_get_index("__GMA_BREAKPOINT__");
  if (GMASSERT_ENABLED && ((gtbp != -1 && !script_execute(gtbp, argument0, argument2, argument1)) || (gbp != -1 && gtbp == -1 && !script_execute(gbp, argument0, argument2, argument1)) || gbp == -1)) {
    var msg = argument0 + chr(13) + chr(13) + "Expected: " + argument1 + chr(13) + chr(13) + "Got: " + argument2 + chr(13) + chr(13);
    if (os_browser == browser_not_a_browser) {
      show_error(msg, true);
    }
    else {
      show_message(msg);
    }
  }
}

#define __gma_debug_value__
/// @function __gma_debug_value__(val, [noprefix])
/// @param val The value to derive a debug-friendly value from
/// @param [noprefix] Whether to skip the "(type)" header (defaults to false)
{
  var type = typeof(argument[0]);
  var dv;
  switch (type) {
    case "number":
      //Return integers as-is
      if (is_infinity(argument[0])) {
        dv = (argument[0] < 0) ? "-infinity" : "infinity";
      }
      else if (is_nan(argument[0])) {
        dv = "NaN";
      }
      else if (frac(argument[0]) == 0) {
        dv = string(argument[0]);
      }
      //Get mantissa and exponent
      else {
        var mantissa, exponent;
        exponent = floor(log10(abs(argument[0])));
        mantissa = string_replace_all(string_format(argument[0]/power(10,exponent), 15, 14), " ", "");
        //Trim trailing zeros off mantissa
        var i, ca;
        i = string_length(mantissa);
        do {
          ca = string_char_at(mantissa, i);
          i -= 1;
        } until (ca != "0")
        if (ca != ".") {
          mantissa = string_copy(mantissa, 1, i+1);
        }
        else {
          mantissa = string_copy(mantissa, 1, i);
        }
        //Add exponent except if it is zero
        if (exponent != 0) {
          dv = mantissa + "e" + string(exponent);
        }
        else {
          dv = mantissa;
        }
      }
    break;
    case "string":
      var str = string_replace_all(argument[0], "\\", "\\\\");
      str = string_replace_all(str, "\"", "\\\"");
      str = string_replace_all(str, "\n", "\\n");
      str = string_replace_all(str, "\r", "\\r");
      str = string_replace_all(str, "\t", "\\t");
      str = string_replace_all(str, "\f", "\\f");
      str = string_replace_all(str, "\b", "\\b");
      str = string_replace_all(str, "\v", "\\v");
      str = string_replace_all(str, "\a", "\\a");
      dv = "\"" + str + "\"";
    break;
    case "array":
      var result = "",
          arr = argument[0],
					size = array_length(arr);
      for (var i = 0; i < size; i++) {
        result += __gma_debug_value__(arr[i], true);
        if (i < size-1) {
          result += ", ";
        }
      }
      dv = "[" + result + "]";
    break;
    case "struct":
      var strc = argument[0];
      var structType = instanceof(strc);
      var __q = structType + ""; //DIRTY WORKAROUND: For squelching structType string leak in 23.1.1.118 Mac Runtime
      var result = "";
      var properties = variable_struct_get_names(strc);
      var size = array_length(properties);
      var gotFirst = false;
      for (var i = 0; i < size; i++) {
        var propertyValue = variable_struct_get(strc, properties[i]);
        if (is_method(propertyValue)) continue;
        if (gotFirst) {
          result += ", ";
        } else {
          gotFirst = true;
        }
        result += properties[i] + ": " + __gma_debug_value__(propertyValue, true);
      }
      if (structType == "struct") {
        dv = "{" + result + "}";
      } else {
        dv = structType + "({" + result + "})";
      }
    break;
    case "bool":
      if (argument[0]) {
        dv = "bool(true)";
      } else {
        dv = "bool(false)";
      }
    break;
    case "int32":
    case "int64":
      dv = type + "(" + string(argument[0]) + ")";
    break;
    case "ptr":
      var hexchars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
      var hex = "";
      var ptrval = int64(argument[0]);
      do {
        hex = hexchars[ptrval & $F] + hex;
        ptrval = ptrval >> 4;
      } until (ptrval == 0);
      dv = "ptr($" + hex + ")";
    break;
    case "undefined":
      dv = "undefined";
    break;
    case "method":
      dv = "function(){...}";
    break;
    case "null":
      dv = "null";
    break;
    case "unknown":
      dv = "???";
    break;
    case "vec3":
      dv = "vec3(" + string(argument[0]) + ")";
    break;
    case "vec4":
      dv = "vec4(" + string(argument[0]) + ")";
    break;
  }
  if (argument_count > 1 && argument[1]) {
    return dv;
  }
  return "(" + type + ")" + chr(13)+chr(10) + dv;
}

#define __gma_debug_list_value__
/// @function __gma_debug_list_value__(val)
/// @param val The value to derive a debug-friendly value from
{
  //Return list(<INVALID>) if it does not exist
  if (!(is_real(argument0) || is_int32(argument0) || is_int64(argument0)) || !ds_exists(argument0, ds_type_list)) {
    return "list(<INVALID>)";
  }
  //Return list(entry1, entry2, ..., entry n) if it exists
  var content = "",
      siz = ds_list_size(argument0);
  for (var i = 0; i < siz; i++) {
    content += __gma_debug_value__(argument0[| i], true);
    if (i < siz-1) {
      content += ", ";
    }
  }
  return "list(" + content + ")";
}

#define __gma_debug_grid_value__
/// @function __gma_debug_grid_value__(val)
/// @param val The value to derive a debug-friendly value from
{
  //Return grid(<INVALID>) if it does not exist
  if (!(is_real(argument0) || is_int32(argument0) || is_int64(argument0)) || !ds_exists(argument0, ds_type_grid)) {
    return "grid(<INVALID>)";
  }
  //Return grid(a, b, c; d, e, f; ...)
  var content = "";
  var width = ds_grid_width(argument0);
  var height = ds_grid_height(argument0);
  for (var yy = 0; yy < height; ++yy) {
    if (yy > 0) content += "; ";
    for (var xx = 0; xx < width; ++xx) {
      if (xx > 0) content += ", ";
      content += __gma_debug_value__(argument0[# xx, yy], true);
    }
  }
  return "grid(" + content + ")";
}

#define __gma_debug_map_value__
/// @function __gma_debug_map_value__(val)
/// @param val The value to derive a debug-friendly value from
{
  //Return map(<INVALID>) if it does not exist
  if (!(is_real(argument0) || is_int32(argument0) || is_int64(argument0)) || !ds_exists(argument0, ds_type_map)) {
    return "map(<INVALID>)";
  }
  //Return map(key0: value0, key1: value1, ..., keyN: valueN) if it exists
  var content = "";
  var firstEntry = true;
  for (var k = ds_map_find_first(argument0); !is_undefined(k); k = ds_map_find_next(argument0, k)) {
    if (firstEntry) {
      firstEntry = false;
    } else {
      content += ", ";
    }
    content += __gma_debug_value__(k, true) + ": " + __gma_debug_value__(argument0[? k], true);
  }
  return "map(" + content + ")";
}

#define __gma_debug_struct_value__
/// @function __gma_debug_struct_value__(val)
/// @param val The value to derive a debug-friendly value from
/// @description Return a detailed debug value of the given struct, including methods (which __gma_debug_value__ omits)
{
  //Fall back to __gma_debug_value__ if not a struct
  if (!is_struct(argument0)) return __gma_debug_value__(argument0, true);
  //Determine correct opening and closing
  var strc = argument[0];
  var structType = instanceof(strc);
  var __q = structType + ""; //DIRTY WORKAROUND: For squelching structType string leak in 23.1.1.118 Mac Runtime
  //Grab properties
  var properties = variable_struct_get_names(strc);
  var size = array_length(properties);
  var result = "";
  for (var i = 0; i < size; i++) {
    if (i > 0) {
      result += ", ";
    }
    result += properties[i] + ": " + __gma_debug_value__(variable_struct_get(strc, properties[i]), true);
  }
  //Return combined result
  if (structType == "struct") {
    return "{" + result + "}";
  }
  return structType + "({" + result + "})";
}

#define __gma_equal__
/// @function __gma_equal__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "array":
        var size = array_length(argument0);
        if (size != array_length(argument1)) return false;
        for (var i = 0; i < size; i++) {
          if (!__gma_equal__(argument0[@ i], argument1[@ i])) return false;
        }
        return true;
      break;
      case "struct":
        var size = variable_struct_names_count(argument0);
        if (size != variable_struct_names_count(argument1)) return false;
        var kn = variable_struct_get_names(argument0);
        for (var i = 0; i < size; ++i) {
          var k = kn[i];
          if (!variable_struct_exists(argument1, k) || !__gma_equal__(variable_struct_get(argument0, k), variable_struct_get(argument1, k))) return false;
        }
        return true;
      break;
      default:
        return argument0 == argument1;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_equalish__
/// @function __gma_equalish__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "array":
        var size = array_length(argument0);
        if (size != array_length(argument1)) return false;
        for (var i = 0; i < size; i++) {
          if (!__gma_equalish__(argument0[@ i], argument1[@ i])) return false;
        }
        return true;
      break;
      case "struct":
        var size = variable_struct_names_count(argument0);
        if (size != variable_struct_names_count(argument1)) return false;
        var kn = variable_struct_get_names(argument0);
        for (var i = 0; i < size; ++i) {
          var k = kn[i];
          if (!variable_struct_exists(argument1, k) || !__gma_equalish__(variable_struct_get(argument0, k), variable_struct_get(argument1, k))) return false;
        }
        return true;
      break;
      case "number":
        return argument0 == argument1 || abs(argument0-argument1) <= GMASSERT_TOLERANCE;
      break;
      default:
        return argument0 == argument1;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_greater_than__
/// @function __gma_greater_than__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 > argument1;
      break;
      case "string":
        if (argument0 == argument1) return false;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 > c1;
          }
        }
        return len0 > len1;
      break;
      case "array":
        var size = array_length(argument0);
        if (size != array_length(argument1)) return false;
        for (var i = 0; i < size; i++) {
          if (!__gma_greater_than__(argument0[@ i], argument1[@ i])) return false;
        }
        return true;
      break;
      case "struct":
        var size = variable_struct_names_count(argument0);
        if (size != variable_struct_names_count(argument1)) return false;
        var kn = variable_struct_get_names(argument0);
        for (var i = 0; i < size; ++i) {
          var k = kn[i];
          if (!variable_struct_exists(argument1, k) || !__gma_greater_than__(variable_struct_get(argument0, k), variable_struct_get(argument1, k))) return false;
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_less_than__
/// @function __gma_less_than__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 < argument1;
      break;
      case "string":
        if (argument0 == argument1) return false;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 < c1;
          }
        }
        return len0 < len1;
      break;
      case "array":
        var size = array_length(argument0);
        if (size != array_length(argument1)) return false;
        for (var i = 0; i < size; i++) {
          if (!__gma_less_than__(argument0[@ i], argument1[@ i])) return false;
        }
        return true;
      break;
      case "struct":
        var size = variable_struct_names_count(argument0);
        if (size != variable_struct_names_count(argument1)) return false;
        var kn = variable_struct_get_names(argument0);
        for (var i = 0; i < size; ++i) {
          var k = kn[i];
          if (!variable_struct_exists(argument1, k) || !__gma_less_than__(variable_struct_get(argument0, k), variable_struct_get(argument1, k))) return false;
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_greater_than_or_equal__
/// @function __gma_greater_than_or_equal__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 >= argument1;
      break;
      case "string":
        if (argument0 == argument1) return true;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 > c1;
          }
        }
        return len0 > len1;
      break;
      case "array":
        var size = array_length(argument0);
        if (size != array_length(argument1)) return false;
        for (var i = 0; i < size; i++) {
          if (!__gma_greater_than_or_equal__(argument0[@ i], argument1[@ i])) return false;
        }
        return true;
      break;
      case "struct":
        var size = variable_struct_names_count(argument0);
        if (size != variable_struct_names_count(argument1)) return false;
        var kn = variable_struct_get_names(argument0);
        for (var i = 0; i < size; ++i) {
          var k = kn[i];
          if (!variable_struct_exists(argument1, k) || !__gma_greater_than_or_equal__(variable_struct_get(argument0, k), variable_struct_get(argument1, k))) return false;
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_less_than_or_equal__
/// @function __gma_less_than_or_equal__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 <= argument1;
      break;
      case "string":
        if (argument0 == argument1) return true;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 < c1;
          }
        }
        return len0 < len1;
      break;
      case "array":
        var size = array_length(argument0);
        if (size != array_length(argument1)) return false;
        for (var i = 0; i < size; i++) {
          if (!__gma_less_than_or_equal__(argument0[@ i], argument1[@ i])) return false;
        }
        return true;
      break;
      case "struct":
        var size = variable_struct_names_count(argument0);
        if (size != variable_struct_names_count(argument1)) return false;
        var kn = variable_struct_get_names(argument0);
        for (var i = 0; i < size; ++i) {
          var k = kn[i];
          if (!variable_struct_exists(argument1, k) || !__gma_less_than_or_equal__(variable_struct_get(argument0, k), variable_struct_get(argument1, k))) return false;
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define assert
/// @function assert(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is true.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!argument[0]) {
    __gma_assert_error_simple__(msg, argument[0]);
  }
}

#define assert_fail
/// @function assert_fail(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is false.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Assertion didn't fail!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (argument[0]) {
    __gma_assert_error_simple__(msg, argument[0]);
  }
}

#define assert_operation
/// @function assert_operation(got, expected, op, invert, [msg], [debug_got], [debug_expected])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param op A script taking the gotten value and the expected as arguments and returning true/false
/// @param invert Whether to invert the result returned by op
/// @param [msg] (optional)
/// @param [debug_got] (optional)
/// @param [debug_expected] (optional)
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg = "Assertion Failed!",
      debug_got = undefined,
      debug_expected = undefined;
  switch (argument_count) {
    case 7:
      debug_expected = argument[6];
    case 6:
      debug_got = argument[5];
    case 5:
      msg = argument[4];
    case 4:
    break;
    default:
      show_error("Expected 4-7 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!(argument[3] ^^ script_execute(argument[2], argument[0], argument[1]))) {
    //
    var debug_value_expected, debug_value_got;
    if (is_undefined(debug_expected)) {
      debug_value_expected = __gma_debug_value__(argument[1]);
    } else if (is_string(debug_expected)) {
      debug_value_expected = debug_expected;
    } else {
      debug_value_expected = script_execute(debug_expected, argument[1])
    }
    if (is_undefined(debug_got)) {
      debug_value_got = __gma_debug_value__(argument[0]);
    } else {
      debug_value_got = script_execute(debug_got, argument[0]);
    }
    __gma_assert_error_raw__(msg, debug_value_expected, debug_value_got);
  }
}

#define assert_equal
/// @function assert_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_equal__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_equalish
/// @function assert_equalish(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is approximately equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Equalish assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_equalish__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_is
/// @function assert_is(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is exactly equal to the expected expression (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (typeof(argument[0]) != typeof(argument[1]) || argument[0] != argument[1]) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_not_equal
/// @function assert_not_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (__gma_equal__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_not_equalish
/// @function assert_not_equalish(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not approximately equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not equalish assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (__gma_equalish__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_isnt
/// @function assert_isnt(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not exactly equal to the expected expression (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (typeof(argument[0]) == typeof(argument[1]) && argument[0] == argument[1]) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_greater_than
/// @function assert_greater_than(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is greater than the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Greater than assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_greater_than__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value greater than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes after " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all greater than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_less_than
/// @function assert_less_than(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is less than the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Less than assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_less_than__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value less than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes before " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all less than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_greater_than_or_equal
/// @function assert_greater_than_or_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is greater than or equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Greater than or equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_greater_than_or_equal__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value greater than or equal to " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes after or is " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all greater than or equal to " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_less_than_or_equal
/// @function assert_less_than_or_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is less than or equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Less than or equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_less_than_or_equal__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value less than or equal to " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes before or is " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all less than or equal " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_is_string
/// @function assert_is_string(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is a string.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "String type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_string(argument[0])) {
    __gma_assert_error_raw__(msg, "Any string", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_real
/// @function assert_is_real(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is a real number.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Real type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_real(argument[0])) {
    __gma_assert_error_raw__(msg, "Any real value", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_array
/// @function assert_is_array(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is an array.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Array type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_array(argument[0])) {
    __gma_assert_error_raw__(msg, "Any array", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_defined
/// @function assert_is_defined(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not undefined.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Defined type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_undefined(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but undefined", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_undefined
/// @function assert_is_undefined(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is undefined.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Undefined type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_undefined(argument[0])) {
    __gma_assert_error_raw__(msg, "undefined", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_string
/// @function assert_isnt_string(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not a string.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-string type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_string(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but a string", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_real
/// @function assert_isnt_real(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not a real number.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-real type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_real(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but a real value", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_array
/// @function assert_isnt_array(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not an array.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-array type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_array(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but an array", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_defined
/// @function assert_isnt_defined(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is undefined.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Undefined type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_undefined(argument[0])) {
    __gma_assert_error_raw__(msg, "undefined", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_undefined
/// @function assert_isnt_undefined(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not undefined.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Defined type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_undefined(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but undefined", __gma_debug_value__(argument[0]));
  }
}

#define assert_in_range
/// @function assert_in_range(got, lower, upper, [msg])
/// @param got The actual received value for the assertion
/// @param lower The lower bound of the range (inclusive)
/// @param upper The upper bound of the range (inclusive)
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is within the inclusive range between lower and upper.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 3:
      msg = "In-range assertion failed!";
    break;
    case 4:
      msg = argument[3];
    break;
    default:
      show_error("Expected 3 or 4 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types
  switch (typeof(argument[1])) {
    case "number":
    case "string":
    case "array":
    break;
    default:
      msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
    exit;
  }
  if (typeof(argument[1]) != typeof(argument[2])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error__(msg + " (mismatched range types)", "A real value for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "string":
        __gma_assert_error__(msg + " (mismatched range types)", "A string for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "array":
        __gma_assert_error__(msg + " (mismatched range types)", "An array for the upper bound", __gma_debug_value__(argument[2]));
      break;
      default:
        msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
      break;
    }
    exit;
  }
  //Check assertion
  if (!(__gma_less_than_or_equal__(argument[0], argument[2]) && __gma_less_than_or_equal__(argument[1], argument[0]))) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that lies between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error_raw__(msg + " (unsupported type)", "A value comparable to " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
    }
  }
}

#define assert_not_in_range
/// @function assert_not_in_range(got, lower, upper, [msg])
/// @param got The actual received value for the assertion
/// @param lower The lower bound of the range (inclusive)
/// @param upper The upper bound of the range (inclusive)
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not within the inclusive range between lower and upper.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 3:
      msg = "Out-of-range assertion failed!";
    break;
    case 4:
      msg = argument[3];
    break;
    default:
      show_error("Expected 3 or 4 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types
  switch (typeof(argument[1])) {
    case "number":
    case "string":
    case "array":
    break;
    default:
      msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
    exit;
  }
  if (typeof(argument[1]) != typeof(argument[2])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error__(msg + " (mismatched range types)", "A real value for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "string":
        __gma_assert_error__(msg + " (mismatched range types)", "A string for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "array":
        __gma_assert_error__(msg + " (mismatched range types)", "An array for the upper bound", __gma_debug_value__(argument[2]));
      break;
      default:
        msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
      break;
    }
    exit;
  }
  //Check assertion
  if (__gma_less_than_or_equal__(argument[0], argument[2]) && __gma_less_than_or_equal__(argument[1], argument[0])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value not between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that does not lie between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all not between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error_raw__(msg + " (unsupported type)", "A value comparable to " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
    }
  }
}

#define assert_contains
/// @function assert_contains(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array contains a value equal to content.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) == 0) {
          __gma_assert_error_raw__(msg, "A string that contains " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      var size = array_length(arr);
      for (var i = 0; i < size; i++) {
        if (__gma_equal__(argument[1], arr[i])) {
          found = true;
          break;
        }
      }
      if (!found) {
        __gma_assert_error_raw__(msg, "An array that contains " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (__gma_equal__(argument[1], list[| i])) {
            found = true;
            break;
          }
        }
        if (!found) {
          __gma_assert_error_raw__(msg, "A list that contains " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_contains_exact
/// @function assert_contains_exact(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array contains a value exactly equal to content (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exact inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) == 0) {
          __gma_assert_error_raw__(msg, "A string that contains exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      var size = array_length(arr);
      for (var i = 0; i < size; i++) {
        if (typeof(argument[1]) == typeof(arr[i]) && argument[1] == arr[i]) {
          found = true;
          break;
        }
      }
      if (!found) {
        __gma_assert_error_raw__(msg, "An array that contains exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (typeof(argument[1]) == typeof(list[| i]) && argument[1] == list[| i]) {
            found = true;
            break;
          }
        }
        if (!found) {
          __gma_assert_error_raw__(msg, "A list that contains exactly " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_contain
/// @function assert_doesnt_contain(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array does not contain a value equal to content.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) > 0) {
          __gma_assert_error_raw__(msg, "A string that does not contain " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      var size = array_length(arr);
      for (var i = 0; i < size; i++) {
        if (__gma_equal__(argument[1], arr[i])) {
          found = true;
          break;
        }
      }
      if (found) {
        __gma_assert_error_raw__(msg, "An array that does not contain " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (__gma_equal__(argument[1], list[| i])) {
            found = true;
            break;
          }
        }
        if (found) {
          __gma_assert_error_raw__(msg, "A list that does not contain " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_contain_exact
/// @function assert_doesnt_contain_exact(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array does not contain a value exactly equal to content (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exact exclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) > 0) {
          __gma_assert_error_raw__(msg, "A string that does not contain exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      var size = array_length(arr);
      for (var i = 0; i < size; i++) {
        if (typeof(argument[1]) == typeof(arr[i]) && argument[1] == arr[i]) {
          found = true;
          break;
        }
      }
      if (found) {
        __gma_assert_error_raw__(msg, "An array that eoes not contain exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (typeof(argument[1]) == typeof(list[| i]) && argument[1] == list[| i]) {
            found = true;
            break;
          }
        }
        if (found) {
          __gma_assert_error_raw__(msg, "A list that does not contain exactly " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_contains_2d
/// @function assert_contains_2d(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten grid or 2D array contains a value equal to content.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "2D inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "array":
      var arr = argument[0];
      var size_i = array_length(arr);
      for (var i = 0; i < size_i && !found; i++) {
        var size_j = array_length(arr[i]);
        for (var j = 0; j < size_j; j++) {
          if (__gma_equal__(argument[1], arr[i][j])) {
            found = true;
            break;
          }
        }
      }
      if (!found) {
        __gma_assert_error_raw__(msg, "A 2D array that contains " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_grid)) {
        var grid = argument[0],
            size_i = ds_grid_width(grid),
            size_j = ds_grid_height(grid);
        for (var i = 0; i < size_i && !found; i++) {
          for (var j = 0; j < size_j; j++) {
            if (__gma_equal__(argument[1], grid[# i, j])) {
              found = true;
              break;
            }
          }
        }
        if (!found) {
          __gma_assert_error_raw__(msg, "A grid that contains " + __gma_debug_value__(argument[1]), __gma_debug_grid_value__(argument[0]));
        }
      }
      else {
        msg += " (grid ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent grid ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
      __gma_assert_error_raw__(msg, "A grid or 2D array", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_contains_exact_2d
/// @function assert_contains_exact_2d(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten grid or 2D array contains a value equal to content, as compared using ==.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exact 2D inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "array":
      var arr = argument[0];
      var size_i = array_length(arr);
      for (var i = 0; i < size_i && !found; i++) {
        var size_j = array_length(arr[i]);
        for (var j = 0; j < size_j; j++) {
          if (argument[1] == arr[i][j]) {
            found = true;
            break;
          }
        }
      }
      if (!found) {
        __gma_assert_error_raw__(msg, "A 2D array that contains " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_grid)) {
        var grid = argument[0],
            size_i = ds_grid_width(grid),
            size_j = ds_grid_height(grid);
        for (var i = 0; i < size_i && !found; i++) {
          for (var j = 0; j < size_j; j++) {
            if (argument[1] == grid[# i, j]) {
              found = true;
              break;
            }
          }
        }
        if (!found) {
          __gma_assert_error_raw__(msg, "A grid that contains " + __gma_debug_value__(argument[1]), __gma_debug_grid_value__(argument[0]));
        }
      }
      else {
        msg += " (grid ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent grid ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
      __gma_assert_error_raw__(msg, "A grid or 2D array", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_contain_2d
/// @function assert_doesnt_contain_2d(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten grid or 2D array doesn't contain a value equal to content.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "2D non-inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "array":
      var arr = argument[0];
      var size_i = array_length(arr);
      for (var i = 0; i < size_i && !found; i++) {
        var size_j = array_length(arr[i]);
        for (var j = 0; j < size_j; j++) {
          if (__gma_equal__(argument[1], arr[i][j])) {
            found = true;
            break;
          }
        }
      }
      if (found) {
        __gma_assert_error_raw__(msg, "A 2D array that doesn't contain " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_grid)) {
        var grid = argument[0],
            size_i = ds_grid_width(grid),
            size_j = ds_grid_height(grid);
        for (var i = 0; i < size_i && !found; i++) {
          for (var j = 0; j < size_j; j++) {
            if (__gma_equal__(argument[1], grid[# i, j])) {
              found = true;
              break;
            }
          }
        }
        if (found) {
          __gma_assert_error_raw__(msg, "A grid that doesn't contain " + __gma_debug_value__(argument[1]), __gma_debug_grid_value__(argument[0]));
        }
      }
      else {
        msg += " (grid ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent grid ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
      __gma_assert_error_raw__(msg, "A grid or 2D array", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_contain_exact_2d
/// @function assert_doesnt_contain_exact_2d(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten grid or 2D array doesn't contain a value equal to content, as compared using ==.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exact 2D non-inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "array":
      var arr = argument[0];
      var size_i = array_length(arr);
      for (var i = 0; i < size_i && !found; i++) {
        var size_j = array_length(arr[i]);
        for (var j = 0; j < size_j; j++) {
          if (argument[1] == arr[i][j]) {
            found = true;
            break;
          }
        }
      }
      if (found) {
        __gma_assert_error_raw__(msg, "A 2D array that doesn't contain " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number": case "int32": case "int64":
      if (ds_exists(argument[0], ds_type_grid)) {
        var grid = argument[0],
            size_i = ds_grid_width(grid),
            size_j = ds_grid_height(grid);
        for (var i = 0; i < size_i && !found; i++) {
          for (var j = 0; j < size_j; j++) {
            if (argument[1] == grid[# i, j]) {
              found = true;
              break;
            }
          }
        }
        if (found) {
          __gma_assert_error_raw__(msg, "A grid that doesn't contain " + __gma_debug_value__(argument[1]), __gma_debug_grid_value__(argument[0]));
        }
      }
      else {
        msg += " (grid ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent grid ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
      __gma_assert_error_raw__(msg, "A grid or 2D array", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_have_key
///@func assert_doesnt_have_key(got, key, [msg])
///@param got The actual received value for the assertion
///@param key The key got should not have
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given struct or map does not have the given key.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "No-key assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion (struct form)
  if (is_struct(argument[0])) {
    if (variable_struct_exists(argument[0], argument[1])) {
      __gma_assert_error_raw__(msg, "A map or struct without key " + __gma_debug_value__(argument[1]), __gma_debug_struct_value__(argument[0]));
    }
  }
  //Check assertion (map form)
  else if (is_real(argument[0]) || is_int32(argument[0]) || is_int64(argument[0])) {
    if (!ds_exists(argument[0], ds_type_map) || ds_map_exists(argument[0], argument[1])) {
      __gma_assert_error_raw__(msg, "A map or struct without key " + __gma_debug_value__(argument[1]), __gma_debug_map_value__(argument[0]));
    }
  }
  //Invalid
  else {
    __gma_assert_error_raw__(msg, "A map or struct without key " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
  }
}

#define assert_doesnt_have_method
///@func assert_doesnt_have_method(got, methodName, [msg])
///@param got The actual received value for the assertion
///@param methodName The method name got should not have
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given value does not have a method of the given name.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "No-method assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_struct(argument[0]) || (variable_struct_exists(argument[0], argument[1]) && is_method(variable_struct_get(argument[0], argument[1])))) {
    __gma_assert_error_raw__(msg, "A struct without a method named " + argument[1], __gma_debug_struct_value__(argument[0]));
  }
}

#define assert_doesnt_throw
///@func assert_doesnt_throw(func, thrown, [msg])
///@param func The function to run (can be function or 2-array of a function plus its argument)
///@param thrown The thing that func should not throw
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given function throws nothing or something other than the given thing.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "No-throw assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  var _func, _arg, _arg0;
  var _noarg = false;
  if (is_array(argument[0])) {
    _arg0 = argument[0];
    _func = _arg0[0];
    _arg = _arg0[1];
  } else {
    _func = argument[0];
    _noarg = true;
  }
  //Check assertion
  try {
    if (_noarg) {
      _func();
    } else {
      _func(_arg);
    }
  } catch (exc) {
    if (__gma_equal__(exc, argument[1])) {
      __gma_assert_error_raw__(msg, "No throw " + __gma_debug_value__(argument[1]), "throw " + __gma_debug_value__(exc));
    }
    exit;
  }
}

#define assert_doesnt_throw_instance_of
///@func assert_doesnt_throw_instance_of(func, typeName, [msg])
///@param func The function to run (can be function or 2-array of a function plus its argument)
///@param typeName The type of the thing func should not throw
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given function doesn't throw the given type of thing.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not-throw-type assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  var _func, _arg, _arg0;
  var _noarg = false;
  if (is_array(argument[0])) {
    _arg0 = argument[0];
    _func = _arg0[0];
    _arg = _arg0[1];
  } else {
    _func = argument[0];
    _noarg = true;
  }
  //Check assertion
  try {
    if (_noarg) {
      _func();
    } else {
      _func(_arg);
    }
  } catch (exc) {
    if (typeof(exc) == argument[1] || (is_struct(exc) && instanceof(exc) == argument[1])) {
      __gma_assert_error_raw__(msg, "throw type other than " + argument[1], "throw " + __gma_debug_value__(exc));
    }
    exit;
  }
}

#define assert_has_key
///@func assert_has_key(got, key, [msg])
///@param got The actual received value for the assertion
///@param key The key got should have
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given struct or map has the given key.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Key assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion (struct form)
  if (is_struct(argument[0])) {
    if (!variable_struct_exists(argument[0], argument[1])) {
      __gma_assert_error_raw__(msg, "A map or struct with key " + __gma_debug_value__(argument[1]), __gma_debug_struct_value__(argument[0]));
    }
  }
  //Check assertion (map form)
  else if (is_real(argument[0]) || is_int32(argument[0]) || is_int64(argument[0])) {
    if (!ds_exists(argument[0], ds_type_map) || !ds_map_exists(argument[0], argument[1])) {
      __gma_assert_error_raw__(msg, "A map or struct with key " + __gma_debug_value__(argument[1]), __gma_debug_map_value__(argument[0]));
    }
  }
  //Invalid
  else {
    __gma_assert_error_raw__(msg, "A map or struct with key " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
  }
}

#define assert_has_method
///@func assert_has_method(got, methodName, [msg])
///@param got The actual received value for the assertion
///@param methodName The method name got should have
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given value has a method of the given name.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Method assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_struct(argument[0]) || !variable_struct_exists(argument[0], argument[1]) || !is_method(variable_struct_get(argument[0], argument[1]))) {
    __gma_assert_error_raw__(msg, "A struct with a method named " + argument[1], __gma_debug_struct_value__(argument[0]));
  }
}

#define assert_is_instance_of
///@func assert_is_instance_of(got, typeName, [msg])
///@param got The actual received value for the assertion
///@param typeName The type that the given value should have
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given value has the given type.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Instance-of assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (typeof(argument[0]) != argument[1] && (!is_struct(argument[0]) || instanceof(argument[0]) != argument[1])) {
    __gma_assert_error_raw__(msg, "Anything of type " + argument[1], __gma_debug_value__(argument[0]));
  }
}

#define assert_is_method
///@func assert_is_method(got, [msg])
///@param got The actual received value for the assertion
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the gotten expression is a method.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Function type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_method(argument[0])) {
    __gma_assert_error_raw__(msg, "Any method", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_struct
///@func assert_is_struct(got, [msg])
///@param got The actual received value for the assertion
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the gotten expression is a struct.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Struct type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_struct(argument[0])) {
    __gma_assert_error_raw__(msg, "Any struct", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_instance_of
///@func assert_isnt_instance_of(got, typeName, [msg])
///@param got The actual received value for the assertion
///@param typeName The type that the given value should not have
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given value does not have the given type.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not-instance-of assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (typeof(argument[0]) == argument[1] || (is_struct(argument[0]) && instanceof(argument[0]) == argument[1])) {
    __gma_assert_error_raw__(msg, "Anything not of type " + argument[1], __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_method
///@func assert_isnt_method(got, [msg])
///@param got The actual received value for the assertion
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the gotten expression is not a method.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-function type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_method(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but a method", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_struct
///@func assert_isnt_struct(got, [msg])
///@param got The actual received value for the assertion
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the gotten expression is not a struct.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-struct type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_struct(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but a struct", __gma_debug_value__(argument[0]));
  }
}

#define assert_not_throwless
///@func assert_not_throwless(func, [msg])
///@param func The function to run (can be function or 2-array of a function plus its argument)
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the function run throws something
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Not-throwless assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  var _func, _arg, _arg0;
  var _noarg = false;
  if (is_array(argument[0])) {
    _arg0 = argument[0];
    _func = _arg0[0];
    _arg = _arg0[1];
  } else {
    _func = argument[0];
    _noarg = true;
  }
  //Check assertion
  try {
    if (_noarg) {
      _func();
    } else {
      _func(_arg);
    }
  } catch (exc) {
    exit;
  }
  __gma_assert_error_raw__(msg, "throw something", "throw <none>");
}

#define assert_throwless
///@func assert_throwless(func, [msg])
///@param func The function to run (can be function or 2-array of a function plus its argument)
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the function run throws nothing
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Throwless assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  var _func, _arg, _arg0;
  var _noarg = false;
  if (is_array(argument[0])) {
    _arg0 = argument[0];
    _func = _arg0[0];
    _arg = _arg0[1];
  } else {
    _func = argument[0];
    _noarg = true;
  }
  //Check assertion
  try {
    if (_noarg) {
      _func();
    } else {
      _func(_arg);
    }
  } catch (exc) {
    __gma_assert_error_raw__(msg, "throw <none>", "throw " + __gma_debug_value__(exc));
  }
}

#define assert_throws
///@func assert_throws(func, thrown, [msg])
///@param func The function to run (can be function or 2-array of a function plus its argument)
///@param thrown The thing that func should throw
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given function throws the given thing.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Throw assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  var _func, _arg, _arg0;
  var _noarg = false;
  if (is_array(argument[0])) {
    _arg0 = argument[0];
    _func = _arg0[0];
    _arg = _arg0[1];
  } else {
    _func = argument[0];
    _noarg = true;
  }
  //Check assertion
  try {
    if (_noarg) {
      _func();
    } else {
      _func(_arg);
    }
  } catch (exc) {
    if (!__gma_equal__(exc, argument[1])) {
      __gma_assert_error_raw__(msg, "throw " + __gma_debug_value__(argument[1]), "throw " + __gma_debug_value__(exc));
    }
    exit;
  }
  __gma_assert_error_raw__(msg, "throw " + __gma_debug_value__(argument[1]), "throw <none>");
}

#define assert_throws_instance_of
///@func assert_throws_instance_of(func, typeName, [msg])
///@param func The function to run (can be function or 2-array of a function plus its argument)
///@param typeName The type of the thing func should throw
///@param [msg] (optional) A custom message to display when the assertion fails
///@description Assert that the given function throws the given type of thing.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Throw-type assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  var _func, _arg, _arg0;
  var _noarg = false;
  if (is_array(argument[0])) {
    _arg0 = argument[0];
    _func = _arg0[0];
    _arg = _arg0[1];
  } else {
    _func = argument[0];
    _noarg = true;
  }
  //Check assertion
  try {
    if (_noarg) {
      _func();
    } else {
      _func(_arg);
    }
  } catch (exc) {
    if (typeof(exc) != argument[1] && (!is_struct(exc) || instanceof(exc) != argument[1])) {
      __gma_assert_error_raw__(msg, "throw type " + argument[1], "throw " + __gma_debug_value__(exc));
    }
    exit;
  }
  __gma_assert_error_raw__(msg, "throw type " + argument[1], "throw <none>");
}
