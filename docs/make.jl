using Documenter
using Gmail
DocMeta.setdocmeta!(Gmail, :DocTestSetup, :(using Gmail); recursive=true)
makedocs(
    sitename = "Gmail",
    format = Documenter.HTML(),
    modules = [Gmail]
)
deploydocs(
    repo = "github.com/dokudo91/Gmail.jl.git",
)