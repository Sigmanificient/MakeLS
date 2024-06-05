import argparse
import sys

from . import __version__

from typing import Final

from loguru import logger

EXIT_SUCCESS: Final[int] = 0
LOG_PAD: Final[int] = 8
LOG_FORMAT: Final[str] = (
    "<blue>{time:YYYY-MM-DD HH:mm:ss}</blue>"
    f" | <level>{{level: <{LOG_PAD}}}</level>"
    " | {message}"
)


def main() -> int:
    logger.remove()
    logger.add(
        sys.stderr,
        format=LOG_FORMAT, level="DEBUG",
        backtrace=True, diagnose=True, colorize=True
    )

    logger.add(
        "logs/file_{time}.log",
        level="INFO", rotation="10 MB", colorize=False
    )

    logger.debug("Logger initialized.")

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-v', '--version',
        action='version', version=f"{__package__}, version {__version__}"
    )

    parser.parse_args()

    from . import lsp_server

    lsp_server.start_io()
    return EXIT_SUCCESS


if __name__ == "__main__":
    sys.exit(main())
