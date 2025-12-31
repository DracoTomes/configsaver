FROM ghcr.io/astral-sh/uv:python3.12-trixie-slim

RUN groupadd --system --gid 999 nonroot \
 && useradd --system --gid 999 --uid 999 --create-home nonroot

WORKDIR /app

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_NO_DEV=1
ENV UV_TOOL_BIN_DIR=/usr/local/bin
ENV UV_PYTHON_PREFERENCE=only-system

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project

COPY --chown=nonroot:nonroot . /app

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked

ENV PATH="/app/.venv/bin:$PATH"

RUN mkdir /configs
RUN chown -R nonroot /configs

ENTRYPOINT []

USER nonroot

CMD ["uv", "run", "fastapi", "run", "--host", "0.0.0.0", "main.py"]