import argparse

import sys
from . import __version__

from typing import Final


EXIT_SUCCESS: Final[int] = 0


def main() -> int:
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
