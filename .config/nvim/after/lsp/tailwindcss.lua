---@type vim.lsp.Config
return {
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'class:list', 'classList', 'ngClass' }, -- className is configured by classRegex
      experimental = {
        classRegex = {
          'className\\s*=\\s*["\']([^"\']*)["\']',
          '(?<=clsx\\((?:[^`]|`[^`]*`)*?)[\'"]([^\'"]*)[\'"]',
          '(?<=cva\\((?:[^`]|`[^`]*`)*?)[\'"]([^\'"]*)[\'"]',
        },
      },
    },
  },
}