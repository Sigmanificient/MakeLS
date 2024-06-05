from loguru import logger
from pygls import server

__version__ = "0.0.1"

lsp_server = server.LanguageServer(
    name="MakeLS",
    version=__version__,
)
