import math
import builtins


class Expression:
    """
    Symbolic expression that has:
        .name  -> HFSS expression
        .value -> evaluated Python value
    """

    def __init__(self, name, value_func):
        self.name = name
        self._value_func = value_func

    @property
    def value(self):
        return self._value_func()

    def __str__(self):
        return self.name

    # ------------------------------------------------------
    # Helper
    # ------------------------------------------------------

    @staticmethod
    def _name(x):
        if isinstance(x, (Expression, ModelParameter)):
            return x.name
        return str(x)

    @staticmethod
    def _value(x):
        if isinstance(x, (Expression, ModelParameter)):
            return x.value
        return x

    # ------------------------------------------------------
    # Arithmetic
    # ------------------------------------------------------

    def __add__(self, other):
        return Expression(
            f"({self.name}+{self._name(other)})",
            lambda: self.value + self._value(other)
        )

    def __radd__(self, other):
        return Expression(
            f"({self._name(other)}+{self.name})",
            lambda: self._value(other) + self.value
        )

    def __sub__(self, other):
        return Expression(
            f"({self.name}-{self._name(other)})",
            lambda: self.value - self._value(other)
        )

    def __rsub__(self, other):
        return Expression(
            f"({self._name(other)}-{self.name})",
            lambda: self._value(other) - self.value
        )

    def __mul__(self, other):
        return Expression(
            f"({self.name}*{self._name(other)})",
            lambda: self.value * self._value(other)
        )

    def __rmul__(self, other):
        return Expression(
            f"({self._name(other)}*{self.name})",
            lambda: self._value(other) * self.value
        )

    def __truediv__(self, other):
        return Expression(
            f"({self.name}/{self._name(other)})",
            lambda: self.value / self._value(other)
        )

    def __rtruediv__(self, other):
        return Expression(
            f"({self._name(other)}/{self.name})",
            lambda: self._value(other) / self.value
        )

    def __pow__(self, other):
        # Python ** becomes HFSS ^
        return Expression(
            f"({self.name}^{self._name(other)})",
            lambda: self.value ** self._value(other)
        )

    def __rpow__(self, other):
        return Expression(
            f"({self._name(other)}^{self.name})",
            lambda: self._value(other) ** self.value
        )

    def __neg__(self):
        return Expression(
            f"(-{self.name})",
            lambda: -self.value
        )

    def __pos__(self):
        return Expression(
            f"(+{self.name})",
            lambda: +self.value
        )


class ModelParameter(Expression):
    """
    A parameter defined in HFSS.

    Example:
        a = ModelParameter("a", 10, "mm")

    a.name  -> "a"
    a.value -> 10
    a.unit  -> "mm"
    """

    def __init__(self, name, value, unit="mm"):
        self.parameter_name = name
        self._parameter_value = value
        self.unit = unit

        super().__init__(
            name,
            lambda: self._parameter_value
        )

    @property
    def value(self):
        return self._parameter_value

    @value.setter
    def value(self, value):
        self._parameter_value = value


# ==========================================================
# Mathematical functions
# ==========================================================

def _math_function(name, function, x):

    if isinstance(x, (Expression, ModelParameter)):

        return Expression(
            f"{name}({x.name})",
            lambda: function(x.value)
        )

    return function(x)


def sin(x):
    return _math_function("sin", math.sin, x)


def cos(x):
    return _math_function("cos", math.cos, x)


def tan(x):
    return _math_function("tan", math.tan, x)


def asin(x):
    return _math_function("asin", math.asin, x)


def acos(x):
    return _math_function("acos", math.acos, x)


def atan(x):
    return _math_function("atan", math.atan, x)


def sinh(x):
    return _math_function("sinh", math.sinh, x)


def cosh(x):
    return _math_function("cosh", math.cosh, x)


def tanh(x):
    return _math_function("tanh", math.tanh, x)


def exp(x):
    return _math_function("exp", math.exp, x)


def sqrt(x):
    return _math_function("sqrt", math.sqrt, x)


def log(x):
    return _math_function("log", math.log, x)


def log10(x):
    return _math_function("log10", math.log10, x)


def abs(x):
    if isinstance(x, (Expression, ModelParameter)):
        return Expression(
            f"abs({x.name})",
            lambda: abs(x.value)
        )

    return builtins.abs(x)



class Add_model_parameter(ModelParameter):

    def __init__(self, name, value, unit="mm"):
        #Action.__init__(self)
        ModelParameter.__init__(self, name, value, unit)

    def hfss_implementation(self):

        value = self.value

        text = (
            '\noDesign.ChangeProperty '
            'Array("NAME:AllTabs", '
            'Array("NAME:LocalVariableTab", '
            'Array("NAME:PropServers", "LocalVariables"), '
            'Array("NAME:NewProps", '
            'Array("NAME:%s", '
            '"PropType:=", "VariableProp", '
            '"UserDef:=", true, '
            '"Value:=", "%s%s"))))\n'
            % (self.name, value, self.unit)
        )

        return text

    def plot(self):
        return
