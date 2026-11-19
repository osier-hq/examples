# Osier examples

Osier is a hosted OpenTofu control plane for AI coding agents: agents plan in a sandbox, every change gets a risk score, and a human approves before anything risky goes live.

This repository holds small OpenTofu stacks for Osier. Use them to see the whole loop before you connect your own infrastructure. The loop is plan, risk score, approval and apply.

## `smoke/`: the whole loop with no cloud credentials

`smoke/` creates a single `random_pet` and nothing else, so it costs nothing and needs no provider token. It carries a `.terraform.lock.hcl` written by OpenTofu with `linux_amd64` hashes, which Osier's read-only `tofu init` requires.

1. Fork this repository, so the Osier GitHub App can read it.
2. In Osier: create an organisation, **New project**, then **Setup** → **Connect GitHub** and pick your fork.
3. Add a stack: your fork, branch `main`, path `smoke`. When the wizard offers the variables from `terraform.tfvars.example`, set `env_name` (any word) and `greeting` (sensitive, anything).
4. **Plan**: the run lands on `planned` with `+1` and a low risk score.
5. **Approve & apply**: the run is `applied`. Plan again: `no changes`.

## Connect your coding agent

Create an API token on the dashboard's **Agents and tokens** page. Then add Osier as an MCP server. The example uses Claude Code. Any MCP client takes the same URL and header:

```bash
claude mcp add --transport http osier https://osier.dev/mcp --header "Authorization: Bearer <token>"
```

Ask your agent to plan the `smoke` stack. It calls `dryrun_plan`, gets the summary and the risk score, and can call `wait_for_run` to follow the run to the end.

## What the agent can and cannot do

- It can list projects and stacks, read state outputs (sensitive ones masked), validate HCL and plan in a fresh sandbox.
- It **never applies**. Its `apply` tool answers `human_approval_required` with a link to the run. A person approves in the Osier dashboard.
- A project owner can set an **auto-apply** policy: low-risk plans on the stacks they choose apply without a click. Destroys, replaces and critical resources always ask a person, whatever the policy says, and an organisation admin can pause auto-apply everywhere at once.

## Learn more

- Quickstart: https://osier.dev/docs/quickstart
- MCP server: https://osier.dev/docs/mcp
- Risk score: https://osier.dev/docs/risk-engine
