package = "data_structures_basics"
version = "1.0.0-1"
source = {
   url = "git+ssh://git@github.com/yorche3/lua.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
   queries = {}
}
build_dependencies = {
   queries = {}
}
build = {
   type = "builtin",
   modules = {
      data_structures_basics = "src/data_structures_basics/init.lua",
      ["data_structures_basics.node"] = "src/data_structures_basics/node.lua",
      ["data_structures_basics.linked_list"] = "src/data_structures_basics/linked_list.lua",
      ["data_structures_basics.stack"] = "src/data_structures_basics/stack.lua",
      ["data_structures_basics.queue"] = "src/data_structures_basics/queue.lua",
   }
}
test_dependencies = {
   queries = {}
}
