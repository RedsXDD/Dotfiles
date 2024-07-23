local has_operators, operators = pcall(require, "mini.operators")
if not has_operators then return end

operators.setup()
