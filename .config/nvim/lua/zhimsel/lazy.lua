-- This returns the `opts` block used by lazy.setup() (in init.lua)
return {

  defaults = {
    lazy = false, -- don't lazy-load plugins by default
  },

  dev = {
    path = "~/dev",
    fallback = true,
  },

  -- Use Unicode symbols, not the default Nerd Font icons (which I don't use)
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },

}
