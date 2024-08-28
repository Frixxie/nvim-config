require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "ollama",
        },
        inline = {
            adapter = "ollama",
        },
        agent = {
            adapter = "ollama",
        },
    },
    default_prompts = {
        ["Generate a Commit Message on Staged changes"] = {
            strategy = "chat",
            description = "Generate a commit message based on staged changes",
            opts = {
                index = 10,
                default_prompt = true,
                mapping = "<LocalLeader>cms",
                slash_cmd = "stagedcommit",
                auto_submit = true,
            },
            prompts = {
                {
                    role = "user",
                    contains_code = true,
                    content = function()
                        return
                            "You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:"
                            .. "\n\n```\n"
                            .. vim.fn.system("git diff --staged")
                            .. "\n```"
                    end,
                },
            },
        },
    }
})
