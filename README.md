# SvgAndroid
Java Android library for rendering svg - fork of LarvaLabs svg-android 
Original source at https://github.com/japgolly/svg-android
Changes by XPila:
1. SVGParser.java - FloatMath deprecated (FloatMath.xxx replaced by (float)Math.xxx)
2. ParserHelper.java - field 'value' renamed to 'ASCII' in MarshMallow - http://stackoverflow.com/questions/33035866/android-6-0-marshmallow-static-initialization-exception-on-getdeclaredfield)
3. SVGParser.java - tag 'text' attribute 'transform' was mandatory in original code
4. SVGParser.java - tag 'text' color was not working in original code (always black)
