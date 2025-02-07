-- require("codecompanion").setup({
--     strategies = {
--         chat = {
--             adapter = "copilot",
--         },
--         inline = {
--             adapter = "copilot",
--         },
--     },
-- })
require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "llama32",
        },
        inline = {
            adapter = "llama32",
        },
    },
    adapters = {
        llama32 = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "llama32",
                formatted_name = "llama32",
                schema = {
                    model = {
                        default = "llama3.2"
                    },
                    num_ctx = {
                        default = 16384
                    },
                    num_predict = {
                        default = -1
                    },
                },
                env = {
                    url = "http://desktop:11434",
                },
                headers = {
                    ["Content-Type"] = "application/json",
                },
                parameters = {
                    sync = true,
                },
            })
        end,
    },
})
