try { eval('core'); } catch(e) { // do not execute twice

// Brendan Eich:

Function.prototype.bind = function(object) {
  var method=this;
  return function()  {    method.apply(object, arguments);  };
};

// create core object
core = {};

core.classID = function() {
  return 'core';
};

core.toString = function() {
  return 'core';
};

core.nameSpaceName = function() {
  return 'core';
};

core.className = function() {
  return 'core';
};

core.isClass = function() {
  return false;
};

core.isNameSpace = function() {
  return true;
};

core.getClass = function() {
  return this.constructor;
};

core.classes = [];
core.lang = 'en';

// default behaviour
core.loadOnDemand = true;


//================================================================================
// class handling functions
//================================================================================

core._isInstalled = function(classID) {
  if (typeof classID != 'string') throw new Error('core._isInstalled(): string argument expected');
  var retVal = false;
  if (classID.length == 0 || classID.indexOf('.') == 0 || classID.indexOf('..') >= 0 || classID.indexOf(' ') >= 0) {
    throw new Error('core._isInstalled(): invalid classID');
  }
  try {
    // should work with namespace shortcuts too
    if (eval(classID).classID() == classID) {
      retVal = true;
    }
  } catch(e) {}
  return retVal;
};

core._isNameSpace = function(nameSpaceName) {
  if (typeof nameSpaceName != 'string') throw new Error('core._isNameSpace() - error: string argument expected');
  var retVal = false;
  if (nameSpaceName.length == 0) return retVal;
  try {
    if (eval(nameSpaceName) && eval(nameSpaceName + '.isNameSpace();')) {
      retVal = true;
    }
  } catch(e) {}
  return retVal;
};

core.installClass = function(objClass) {

  var cp = null;
  try {
     cp = new core.classPath(objClass.classID());
  } catch(e) {
    throw new Error('core.installClass(): object passed has no classID');
  }
  var cls = null;
  try {
    // don't install a class twice!
    if (null==(cls = eval(objClass.classID()))) {
      throw new Error('');
    }
  } catch(e) {
  
    // add class to namespace
    if (cp.path.indexOf(' ')>=0 || cp.path.indexOf('..')>=0) throw new Error('core.installClass: invalid class name \''+cp.path+'\'');
    var ns = core._verifyNameSpace(cp.nameSpaceString());
    cls = objClass;
    ns[cp.shortName()] = cls;
    // set standard methods for class
    cls.toString = new Function('return \''+cp.shortName()+'\';');
    cls.isClass = function() { return true;};
    cls.isNameSpace = function() { return false;};
    cls.isInstance = function() {return false;};
    if (cls['isFinal'] == null) cls.isFinal = function() { return false;};
    if (cls['isAbstract'] == null) cls.isAbstract = function() { return false;};
    cls.lang = core.lang;
    // set standard methods for instances
    cls.prototype.getClass = function() { return this.constructor;};
    cls.prototype.classID = cls.classID;
    cls.prototype.toString = function() { return this.constructor.toString();};
    cls.prototype.isClass = function() {return false;};
    cls.prototype.isNameSpace = function() {return false;};
    cls.prototype.isInstance = function() {return true;};
    if (cls['sup'] == null) cls.sup = cls;
    // do class specific installation stuff
    if (cls['install']) {
      // standard methods may be overridden here
      cls.install();
    }
    core.classes[core.classes.length] = cls;
  }
  return cls;
};

core.derive = function(subClass, from) {

  var cp = null;
  try {
     cp = new core.classPath(subClass.classID());
  } catch(e) {
    throw new Error('core.installClass(): object passed has no classID');
  }
  try {
    // don't install a class twice!
    if (null==(cls = eval(subClass.classID()))) {
      throw new Error('');
    }
  } catch(e) {
    if (arguments.length < 2) {
      throw new Error('core.derive(): parameter missing');
    }
    var check = true;
    try {
      check = from.isClass();
    } catch(e) {
      check = false;
    }
    if (!check) {
      throw new Error('core.derive(): invalid parameters'); 
    }
    try {
      check = from.isFinal();
    } catch(e) {
      check = false;
    }
    if (check) {
      throw new Error('core.derive(): class \''+from.classID()+'\' is final'); 
    }
    var cls = null;
    
    // derive from base class
    subClass.prototype = new from;
    // copy subclass properties to new prototype
    for (var p in subClass) {
      switch(p) {
        case 'classID':
        case 'prototype':
        case 'sup':
        case 'sub':
          continue;
      }
      eval('subClass.prototype.'+p+' = subClass.'+p+';');
    }
    // make sure that all methods are called through subclass instance
    // and not through prototype - prototype does not know what 'sub' is
    for (var p in from.prototype) {
      if (typeof from.prototype[p] == 'function') {
        switch(p) {
          case 'getClass':
          case 'classID':
          case 'toString':
          case 'isClass':
          case 'isNameSpace':
          case 'isInstance':
          case 'isAbstract':
          case 'isFinal':
            continue;
        }
        subClass.prototype[p] = new Function(
          'return core.getClassByID(\''+from.classID()+'\').prototype.'+p+'.apply(this, arguments);'
		);
/*		
        subClass.prototype[p] = new Function(
          'var stmt=\'core.getClassByID(\\\''+from.classID()+'\\\').prototype.'+p+'.call(this\';'+
          'var val = null;\n'+
          'for (var i = 0; i < arguments.length; i++) {\n'+
            'if (typeof arguments[i] == \'string\') {\n'+
              'val=\'\\\'\'+arguments[i]+\'\\\'\';\n'+
            '} else {\n'+
              'val = arguments[\'+i+\'];\n'+
            '}\n'+
            'stmt+=\', \'+val;\n'+
          '}\n'+
          'stmt+=\');\';'+
          'return eval(stmt);');
*/
      }
    }
    subClass.sup = from;
    subClass.prototype.constructor = subClass;
  }
};


core.getClassByID = function(classID) {
  switch (arguments.length) {
  case 0:
    throw new Error('core.getClass(): no arguments given');
    break;
  default:
    break;
  }
  if (core._isInstalled(classID)) {
    return eval(classID);
  } else {
    return core.loadClass(classID);
  }
};

core.loadClass = function(classID) {
  if (core.loadOnDemand) {
    // for the time being...
    throw new Error('core.loadClass(): not implemented; cannot load class \''+classID+'\'');
    // replace with the right code
  } else {
    throw new Error('core.loadClass(): class \''+classID+'\' not installed');
  }
}

core.localize = function(newLang) {
  core.lang = newLang;
  for (var cls in core.classes) {
    core.loadLang(cls.classID(), core.lang);
  }
}

// load language file for a class and install messages
core.loadLang = function(classID, lang) {
}

//================================================================================
// class instance handling functions
//================================================================================

core.createInstance = function(classID) {
  switch (arguments.length) {
  case 0:
    throw new Error('core.create(): no arguments given');
    break;
  default:
    break;
  }
  if (typeof classID != 'string') throw new Error('core.createInstance(): invalid parameter');
  var cls = null;
  try {
    cls = core.getClassByID(classID);
  } catch(e) {
    throw new Error('core.create(): class \''+classID+'\' is not installed');
  }
  if (cls.isAbstract()) {
    throw new Error('core.createInstance(): abstract class \''+classID+'\' cannot be instantiated');
  }
  var instance = new cls();
  if (cls.prototype['initialize']!=null) {
    var stmt = 'instance.initialize(';
    for (var i = 1; i < arguments.length; i++) {
      stmt += ((i==1)?'' : ', ')+'arguments['+i+']';
    }
    stmt += ')';
    eval(stmt);
  }
  return instance;
}

//================================================================================
// namespace handling functions
//================================================================================

core._verifyNameSpace = function(nameSpaceName) {

  if (typeof nameSpaceName != 'string') {
    if (typeof nameSpaceName == 'object' && eval(nameSpaceName.toString()+'[isNameSpace]') &&
      nameSpaceName.isNameSpace()
    ) {
      nameSpaceName = nameSpaceName.toString();
    } else {
      throw new Error('core._verifyNameSpace: string argument expected');
    }
  }  
  // create a command string for dynamically installing a namespace
  var _createCmd = function(nameSpace, shortName) {
    var base = nameSpace ;
    if (base.length > 0) {
      base += '.';
    }
    var _longName = base + shortName;
    var cmd = _longName + ' = {};\n' +
      _longName + '.toString = function() { return \'' + _longName + '\';};\n' +
      _longName + '.isClass = function() { return false;};\n' +
      _longName + '.isInstance = function() { return false;};\n' +
      _longName + '.isNameSpace = function() { return true;};\n';
    return cmd;
  }
  // check for existence
  var ns = null;
  try {
    if (ns = eval(nameSpaceName)) {
      if (core._isNameSpace(nameSpaceName)) {
        // don't return a shortcut!    
        return eval(eval(nameSpaceName).toString());
      }
    }
  } catch(e) {}
  if (ns) {
    throw new Error('Object \''+nameSpaceName+'\' exists already');
  }
  // create namespace on the fly
  var _cp = new core.classPath(nameSpaceName);
  var _nameSpace = _cp.nameSpaceString();
  if (_nameSpace.length > 0) {
    // use recursion to make sure that _nameSpace exists and don't use shortcut name
    _nameSpace = core._verifyNameSpace(_nameSpace).toString();
  }
  eval(_createCmd(_nameSpace, _cp.shortName()));
  return eval(nameSpaceName);
};

core.createShortCut = function(nameSpaceName) {

  return eval(core._verifyNameSpace(nameSpaceName).toString());

};

//================================================================================
// helper classes and functions
//================================================================================

core.classPath = function(path) {
  if (typeof path != 'string') throw new Error('core.classpath - error: string argument expected');
  this.path = path;
};

core.classPath.toString = function() {
  return this.path;
};

core.classPath.className = function() {
  return 'core.classPath';
};

core.classPath.prototype.toString = core.classPath.toString;

core.classPath.prototype.className = core.classPath.className;

core.classPath.prototype.nameSpaceString = function() {
  var pos = this.path.lastIndexOf('.');
  if (pos == -1) {
    return '';
  }
  return this.path.slice(0, pos);
};

core.classPath.prototype.shortName = function() {
  var pos = this.path.lastIndexOf('.');
  if (pos == -1) {
    return this.path;
  }
  return this.path.slice(pos + 1);
};

core.classPath.prototype.edges = function () {
  return this.path.split('.');
};

core.classPath.prototype.add = function(edge) {

  if (this.path == '') {
    return edge;
  }
  return this.path + '.' + edge;
};

core.msgBuilder = function(cls, msgId, aParms) {
  var msg = cls.messages[msgId];
  for (var i = 0; i < aParms.length; i++) {
    msg = msg.replace('$'+i, aParms[i]);   
  }
  return msg;
}

core.inspect = function(obj, msg, hide) {
  if (msg == null) msg = '';
  msg += obj.toString()+' ('+typeof obj+'):\n';
  var i = 0;
  var val = '';
  for (var p in obj) {
    if (obj[p] && obj[p].toString().indexOf('function') >= 0) {
      val = '(anonymous function)';
    } else {
      val = obj[p];
    }
    msg+=p + ' ('+ typeof obj[p] + '): '+val+(((++i)%3==0) ? '\n' : '\t\t\t');
  }
  if (!hide) alert(msg);
  return msg;
}

// localization part
core.messages = [
///BEGIN MESSAGES(core)
///END MESSAGES
];
try {
  window.setTimeout('window.status = \'Core successfully initialized!\';', 10);
  window.setTimeout('window.status = \'\';', 1000);
} catch(e) {
  alert(e.toString());
}
} // end global catch

try { 
  if (dataPort == null) {
    throw new Error('');
  }
} catch(e) { // do not execute twice


  if (document.dp0 == null) {
    throw new Exception('dataPort: applet \'dp0\' not found');
  }
// create dataPort object
var dataPort = {};

dataPort.classID = function() {
  return 'dataPort';
};

// localization part
dataPort.messages = [
///BEGIN MESSAGES(core)
///END MESSAGES
];

core.installClass(dataPort);

// alert('dataPort successfully installed');

} // end global catch

