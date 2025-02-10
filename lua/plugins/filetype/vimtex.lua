return {
  "lervag/vimtex",
	ft = "tex",
  init = function()
		vim.g.vimtex_syntax_enabled = 0
	
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
		
		vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-lualatex",
      pdfdvi = "-pdfdvi",
      pdfps = "-pdfps",
      pdflatex = "-pdf",
      luatex = "-lualatex",
      lualatex = "-lualatex",
      xelatex = "-xelatex",
      ["context (pdftex)"] = "-pdf -pdflatex=texexec",
      ["context (luatex)"] = "-pdf -pdflatex=context",
      ["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'"
    }
  end
}