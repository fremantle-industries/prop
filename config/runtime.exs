import Config

# Shared variables
env = config_env() |> Atom.to_string()
http_port = (System.get_env("HTTP_PORT") || "4000") |> String.to_integer()
prop_host = System.get_env("PROP_HOST") || "prop.localhost"
workbench_host = System.get_env("WORKBENCH_HOST") || "workbench.localhost"
history_host = System.get_env("HISTORY_HOST") || "history.localhost"
rube_host = System.get_env("RUBE_HOST") || "rube.localhost"
slurpee_host = System.get_env("SLURPEE_HOST") || "slurpee.localhost"
livebook_host = System.get_env("LIVEBOOK_HOST") || "livebook.localhost"
grafana_host = System.get_env("GRAFANA_HOST") || "grafana.localhost"
prometheus_host = System.get_env("PROMETHEUS_HOST") || "prometheus.localhost"

prop_secret_key_base =
  System.get_env("PROP_SECRET_KEY_BASE") ||
    "uwi9NZNbqTE1Nnro1FvaeKNeFfTWKphLG9IamO4jGLjvNbWhhp10ewNx1I8zPJ/y"

prop_live_view_signing_salt = System.get_env("PROP_LIVE_VIEW_SIGNING_SALT") || "cvulB0bl"

workbench_secret_key_base =
  System.get_env("WORKBENCH_SECRET_KEY_BASE") ||
    "vJP36v4Gi2Orw8b8iBRg6ZFdzXKLvcRYkk1AaMLYX0+ry7k5XaJXd/LY/itmoxPP"

workbench_live_view_signing_salt =
  System.get_env("WORKBENCH_LIVE_VIEW_SIGNING_SALT") || "TolmUusQ6//zaa5GZHu7DG2V3YAgOoP/"

history_secret_key_base =
  System.get_env("HISTORY_SECRET_KEY_BASE") ||
    "5E5zaJwG5w2ABR+0p+4GQs1nwzz5e7UbkEa6hlpel6wcrI6CAhWsrKWEecfYFWRF"

history_live_view_signing_salt =
  System.get_env("HISTORY_LIVE_VIEW_SIGNING_SALT") || "MXNTK//1Uc1R5wIKBGTZyTPPEQyVxSo3"

rube_secret_key_base =
  System.get_env("RUBE_SECRET_KEY_BASE") ||
    "vJP36v4Gi2Orw8b8iBRg6ZFdzXKLvcRYkk1AaMLYX0+ry7k5XaJXd/LY/itmoxPP"

rube_live_view_signing_salt =
  System.get_env("RUBE_LIVE_VIEW_SIGNING_SALT") || "TolmUusQ6//zaa5GZHu7DG2V3YAgOoP/"

slurpee_secret_key_base =
  System.get_env("SLURPEE_SECRET_KEY_BASE") ||
    "vJP36v4Gi2Orw8b8iBRg6ZFdzXKLvcRYkk1AaMLYX0+ry7k5XaJXd/LY/itmoxPP"

slurpee_live_view_signing_salt =
  System.get_env("SLURPEE_LIVE_VIEW_SIGNING_SALT") || "TolmUusQ6//zaa5GZHu7DG2V3YAgOoP/"

livebook_secret_key_base =
  System.get_env("LIVEBOOK_SECRET_KEY_BASE") ||
    "vJP36v4Gi2Orw8b8iBRg6ZFdzXKLvcRYkk1AaMLYX0+ry7k5XaJXd/LY/itmoxPP"

livebook_live_view_signing_salt =
  System.get_env("LIVEBOOK_LIVE_VIEW_SIGNING_SALT") || "TolmUusQ6//zaa5GZHu7DG2V3YAgOoP/"

# Telemetry
config :telemetry_poller, :default, period: 1_000

# Database
partition = System.get_env("MIX_TEST_PARTITION")
default_database_url = "postgres://postgres:postgres@localhost:5432/prop_?"
configured_database_url = System.get_env("DATABASE_URL") || default_database_url
database_url = "#{String.replace(configured_database_url, "?", env)}#{partition}"

# Prop
config :prop,
       :prometheus_metrics_port,
       {:system, :integer, "PROP_PROMETHEUS_METRICS_PORT", 9572}

config :prop, Prop.Repo,
  url: database_url,
  pool_size: 5

config :prop, PropWeb.Endpoint,
  url: [host: prop_host, port: http_port],
  render_errors: [view: PropWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tai.PubSub,
  secret_key_base: prop_secret_key_base,
  live_view: [signing_salt: prop_live_view_signing_salt]

# Workbench
config :workbench,
       :prometheus_metrics_port,
       {:system, :integer, "WORKBENCH_PROMETHEUS_METRICS_PORT", 9571}

config :workbench, Workbench.Repo,
  url: database_url,
  pool_size: 5

config :workbench, WorkbenchWeb.Endpoint,
  http: [port: http_port],
  url: [host: workbench_host, port: http_port],
  render_errors: [view: WorkbenchWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Tai.PubSub,
  secret_key_base: workbench_secret_key_base,
  live_view: [signing_salt: workbench_live_view_signing_salt],
  server: false

config :workbench,
  asset_aliases: %{
    btc: [:xbt],
    usd: [:busd, :pax, :usdc, :usdt, :tusd]
  },
  balance_snapshot: %{
    enabled: {:system, :boolean, "BALANCE_SNAPSHOT_ENABLED", false},
    boot_delay_ms: {:system, :integer, "BALANCE_SNAPSHOT_BOOT_DELAY_MS", 10_000},
    every_ms: {:system, :integer, "BALANCE_SNAPSHOT_EVERY_MS", 60_000},
    btc_usd_venue: {:system, :atom, "BALANCE_SNAPSHOT_BTC_USD_VENUE", :binance},
    btc_usd_symbol: {:system, :atom, "BALANCE_SNAPSHOT_BTC_USD_SYMBOL", :btc_usdc},
    usd_quote_venue: {:system, :atom, "BALANCE_SNAPSHOT_USD_QUOTE_VENUE", :binance},
    usd_quote_asset: {:system, :atom, "BALANCE_SNAPSHOT_USD_QUOTE_ASSET", :usdt},
    quote_pairs: [binance: :usdt, okex: :usdt]
  }

# History
config :history,
       :prometheus_metrics_port,
       {:system, :integer, "HISTORY_PROMETHEUS_METRICS_PORT", 9570}

config :history, History.Repo,
  url: database_url,
  pool_size: 5

config :history, HistoryWeb.Endpoint,
  http: [port: http_port],
  url: [host: history_host, port: http_port],
  render_errors: [view: HistoryWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Tai.PubSub,
  secret_key_base: history_secret_key_base,
  live_view: [signing_salt: history_live_view_signing_salt],
  server: false

config :history, data_adapters: %{}

# Tai
config :tai, Tai.Orders.OrderRepo,
  url: database_url,
  pool_size: 5

config :tai, venues: %{}
config :tai, fleets: %{}

# Rube
config :rube,
       :prometheus_metrics_port,
       {:system, :integer, "RUBE_PROMETHEUS_METRICS_PORT", 9569}

config :rube, Rube.Repo,
  url: database_url,
  pool_size: 5

config :rube, RubeWeb.Endpoint,
  http: [port: http_port],
  url: [host: rube_host, port: http_port],
  render_errors: [view: RubeWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Slurpee.PubSub,
  secret_key_base: rube_secret_key_base,
  live_view: [signing_salt: rube_live_view_signing_salt],
  server: false

# Slurpee
config :slurpee,
       :prometheus_metrics_port,
       {:system, :integer, "SLURPEE_PROMETHEUS_METRICS_PORT", 9568}

config :slurpee, SlurpeeWeb.Endpoint,
  http: [port: http_port],
  url: [host: slurpee_host, port: http_port],
  render_errors: [view: SlurpeeWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Slurpee.PubSub,
  secret_key_base: slurpee_secret_key_base,
  live_view: [signing_salt: slurpee_live_view_signing_salt],
  server: false

# Slurp
config :slurp,
  new_head_subscriptions: %{
    "*" => [
      %{
        enabled: true,
        handler: {Slurpee.NewHeadHandler, :handle_new_head, []}
      }
    ]
  }

config :slurp,
  blockchains: %{
    "eth-mainnet" => %{
      start_on_boot: false,
      name: "Ethereum",
      adapter: Slurp.Adapters.Evm,
      network_id: 1,
      chain_id: 1,
      chain: "ETH",
      testnet: false,
      timeout: 5000,
      new_head_initial_history: 0,
      poll_interval_ms: 2_500,
      explorer: {Slurp.ExplorerAdapters.Etherscan, "https://etherscan.io"},
      rpc: [
        "https://api.mycryptoapi.com/eth"
      ]
    },
    "bsc-mainnet" => %{
      start_on_boot: false,
      name: "Binance Smart Chain",
      adapter: Slurp.Adapters.Evm,
      network_id: 56,
      chain_id: 56,
      chain: "BSC",
      testnet: false,
      new_head_initial_history: 0,
      poll_interval_ms: 1_000,
      explorer: {Slurp.ExplorerAdapters.BscScan, "https://bscscan.com"},
      rpc: [
        "https://bsc-dataseed1.binance.org"
      ]
    },
    "matic-mainnet" => %{
      start_on_boot: false,
      name: "Matic",
      adapter: Slurp.Adapters.Evm,
      network_id: 137,
      chain_id: 137,
      chain: "Matic",
      testnet: false,
      timeout: 5000,
      new_head_initial_history: 0,
      poll_interval_ms: 2_500,
      explorer: {Slurp.ExplorerAdapters.Polygonscan, "https://polygonscan.com"},
      rpc: [
        "https://rpc-mainnet.matic.network"
      ]
    },
    "xdai-mainnet" => %{
      start_on_boot: false,
      name: "xDAI",
      adapter: Slurp.Adapters.Evm,
      network_id: 100,
      chain_id: 100,
      chain: "xDAI",
      testnet: false,
      timeout: 5000,
      new_head_initial_history: 0,
      poll_interval_ms: 2_500,
      explorer: {Slurp.ExplorerAdapters.Blockscout, "https://blockscout.com/xdai/mainnet/"},
      rpc: [
        "https://rpc.xdaichain.com"
      ]
    },
    "avalanche-mainnet" => %{
      start_on_boot: false,
      name: "Avalanche",
      adapter: Slurp.Adapters.Evm,
      network_id: 43114,
      chain_id: 43114,
      chain: "Avax",
      testnet: false,
      timeout: 5000,
      new_head_initial_history: 0,
      poll_interval_ms: 2_500,
      explorer: {Slurp.ExplorerAdapters.Avascan, "https://avascan.info"},
      rpc: [
        "https://api.avax.network/ext/bc/C/rpc"
      ]
    },
    "optimism-mainnet" => %{
      start_on_boot: false,
      name: "Optimistic Ethereum",
      adapter: Slurp.Adapters.Evm,
      network_id: 10,
      chain_id: 10,
      chain: "ETH",
      testnet: false,
      timeout: 5000,
      new_head_initial_history: 0,
      poll_interval_ms: 2_500,
      explorer: {Slurp.ExplorerAdapters.Etherscan, "https://optimistic.etherscan.io"},
      rpc: [
        "https://mainnet.optimism.io/"
      ]
    },
    "fantom-mainnet" => %{
      start_on_boot: false,
      name: "Fantom",
      adapter: Slurp.Adapters.Evm,
      network_id: 250,
      chain_id: 250,
      chain: "FTM",
      testnet: false,
      timeout: 5000,
      new_head_initial_history: 0,
      poll_interval_ms: 2_500,
      explorer: {Slurp.ExplorerAdapters.Ftmscan, "https://ftmscan.com"},
      rpc: [
        "https://rpcapi.fantom.network"
      ]
    }
  }

config :slurp,
  log_subscriptions: %{
    "*" => %{
      # ERC20
      "Approval(address,address,uint256)" => [
        %{
          enabled: false,
          struct: Rube.Erc20.Events.Approval,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "name" => "owner",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "name" => "spender",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "name" => "value",
                  "type" => "uint256"
                }
              ],
              "name" => "Approval",
              "type" => "event"
            }
          ]
        }
      ],
      "Transfer(address,address,uint256)" => [
        %{
          enabled: false,
          struct: Rube.Erc20.Events.Transfer,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "name" => "from",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "name" => "to",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "name" => "value",
                  "type" => "uint256"
                }
              ],
              "name" => "Transfer",
              "type" => "event"
            }
          ]
        }
      ],
      "Mint(address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Erc20.Events.Mint,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "name" => "sender",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "name" => "amount0",
                  "type" => "uint"
                },
                %{
                  "indexed" => false,
                  "name" => "amount1",
                  "type" => "uint"
                }
              ],
              "name" => "Mint",
              "type" => "event"
            }
          ]
        }
      ],
      "Burn(address,uint256,uint256,address)" => [
        %{
          enabled: false,
          struct: Rube.Erc20.Events.Burn,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "name" => "sender",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "name" => "amount0",
                  "type" => "uint"
                },
                %{
                  "indexed" => false,
                  "name" => "amount1",
                  "type" => "uint"
                },
                %{
                  "indexed" => true,
                  "name" => "to",
                  "type" => "address"
                }
              ],
              "name" => "Burn",
              "type" => "event"
            }
          ]
        }
      ],
      # AMM - Uniswap, Sushiswap, Pancakeswap etc...
      "Swap(address,uint256,uint256,uint256,uint256,address)" => [
        %{
          enabled: true,
          struct: Rube.Amm.Events.Swap,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "name" => "sender",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "name" => "amount0In",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "name" => "amount1In",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "name" => "amount0Out",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "name" => "amount1Out",
                  "type" => "uint256"
                },
                %{
                  "indexed" => true,
                  "name" => "to",
                  "type" => "address"
                }
              ],
              "name" => "Swap",
              "type" => "event"
            }
          ]
        }
      ],
      "Sync(uint112,uint112)" => [
        %{
          enabled: true,
          struct: Rube.Amm.Events.Sync,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => false,
                  "name" => "reserve0",
                  "type" => "uint112"
                },
                %{
                  "indexed" => false,
                  "name" => "reserve1",
                  "type" => "uint112"
                }
              ],
              "name" => "Sync",
              "type" => "event"
            }
          ]
        }
      ],
      # Chainlink
      "AddedAccess(address)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.AddedAccess,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => false,
                  "internalType" => "address",
                  "name" => "user",
                  "type" => "address"
                }
              ],
              "name" => "AddedAccess",
              "type" => "event"
            }
          ]
        }
      ],
      "AnswerUpdated(int256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.AnswerUpdated,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "int256",
                  "name" => "current",
                  "type" => "int256"
                },
                %{
                  "indexed" => true,
                  "internalType" => "uint256",
                  "name" => "roundId",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "updatedAt",
                  "type" => "uint256"
                }
              ],
              "name" => "AnswerUpdated",
              "type" => "event"
            }
          ]
        }
      ],
      "AvailableFundsUpdated(uint256)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.AvailableFundsUpdated,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "uint256",
                  "name" => "amount",
                  "type" => "uint256"
                }
              ],
              "name" => "AvailableFundsUpdated",
              "type" => "event"
            }
          ]
        }
      ],
      "NewRound(uint256,address,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.NewRound,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "uint256",
                  "name" => "roundId",
                  "type" => "uint256"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "startedBy",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "startedAt",
                  "type" => "uint256"
                }
              ],
              "name" => "NewRound",
              "type" => "event"
            }
          ]
        }
      ],
      "RoundDetailsUpdated(uint128,uint32,uint32,uint32,uint32)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.NewRound,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "uint128",
                  "name" => "paymentAmount",
                  "type" => "uint128"
                },
                %{
                  "indexed" => true,
                  "internalType" => "uint32",
                  "name" => "minSubmissionCount",
                  "type" => "uint32"
                },
                %{
                  "indexed" => true,
                  "internalType" => "uint32",
                  "name" => "maxSubmissionCount",
                  "type" => "uint32"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint32",
                  "name" => "restartDelay",
                  "type" => "uint32"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint32",
                  "name" => "timeout",
                  "type" => "uint32"
                }
              ],
              "name" => "RoundDetailsUpdated",
              "type" => "event"
            }
          ]
        }
      ],
      "SubmissionReceived(int256,uint32,address)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.SubmissionReceived,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "int256",
                  "name" => "submission",
                  "type" => "int256"
                },
                %{
                  "indexed" => true,
                  "internalType" => "uint32",
                  "name" => "round",
                  "type" => "uint32"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "oracle",
                  "type" => "address"
                }
              ],
              "name" => "SubmissionReceived",
              "type" => "event"
            }
          ]
        }
      ],
      "ValidatorUpdated(address,address)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.ValidatorUpdated,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "previous",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "current",
                  "type" => "address"
                }
              ],
              "name" => "ValidatorUpdated",
              "type" => "event"
            }
          ]
        }
      ],
      "NewTransmission(address,address)" => [
        %{
          enabled: true,
          struct: Rube.Chainlink.Events.NewTransmission,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "uint32",
                  "name" => "aggregatorRoundId",
                  "type" => "uint32"
                },
                %{
                  "indexed" => false,
                  "internalType" => "int192",
                  "name" => "answer",
                  "type" => "int192"
                },
                %{
                  "indexed" => false,
                  "internalType" => "address",
                  "name" => "transmitter",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "int192[]",
                  "name" => "observations",
                  "type" => "int192[]"
                },
                %{
                  "indexed" => false,
                  "internalType" => "bytes",
                  "name" => "observers",
                  "type" => "bytes"
                },
                %{
                  "indexed" => false,
                  "internalType" => "bytes32",
                  "name" => "rawReportContext",
                  "type" => "bytes32"
                }
              ],
              "name" => "NewTransmission",
              "type" => "event"
            }
          ]
        }
      ],
      # Keep3r
      "SubmitJob(address,address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.SubmitJob,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "liquidity",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "provider",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "credit",
                  "type" => "uint256"
                }
              ],
              "name" => "SubmitJob",
              "type" => "event"
            }
          ]
        }
      ],
      "RemoveJob(address,address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.RemoveJob,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "liquidity",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "provider",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "credit",
                  "type" => "uint256"
                }
              ],
              "name" => "RemoveJob",
              "type" => "event"
            }
          ]
        }
      ],
      "UnbondJob(address,address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.UnbondJob,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "liquidity",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "provider",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "credit",
                  "type" => "uint256"
                }
              ],
              "name" => "UnbondJob",
              "type" => "event"
            }
          ]
        }
      ],
      "JobAdded(address,uint256,address)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.JobAdded,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "address",
                  "name" => "governance",
                  "type" => "address"
                }
              ],
              "name" => "JobAdded",
              "type" => "event"
            }
          ]
        }
      ],
      "JobRemoved(address,uint256,address)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.JobRemoved,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "address",
                  "name" => "governance",
                  "type" => "address"
                }
              ],
              "name" => "JobRemoved",
              "type" => "event"
            }
          ]
        }
      ],
      "AddCredit(address,address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.AddCredit,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "credit",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "creditor",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "amount",
                  "type" => "uint256"
                }
              ],
              "name" => "AddCredit",
              "type" => "event"
            }
          ]
        }
      ],
      "ApplyCredit(address,address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.ApplyCredit,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "liquidity",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "provider",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "credit",
                  "type" => "uint256"
                }
              ],
              "name" => "ApplyCredit",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperWorked(address,address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperWorked,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "credit",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "job",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "amount",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperWorked",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperBonding(address,uint256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperBonding,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "active",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "bond",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperBonding",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperBonded(address,uint256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperBonded,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "activated",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "bond",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperBonded",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperUnbonding(address,uint256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperUnbonding,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "deactive",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "bond",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperUnbonding",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperUnbound(address,uint256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperUnbound,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "deactivated",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "bond",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperUnbound",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperSlashed(address,address,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperSlashed,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "slasher",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "slash",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperSlashed",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperDispute(address,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperDispute,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperDispute",
              "type" => "event"
            }
          ]
        }
      ],
      "KeeperResolved(address,uint256)" => [
        %{
          enabled: true,
          struct: Rube.Keep3r.Events.KeeperResolved,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "keeper",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "block",
                  "type" => "uint256"
                }
              ],
              "name" => "KeeperResolved",
              "type" => "event"
            }
          ]
        }
      ],
      # Compound
      "AccrueInterest(uint256,uint256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.MoneyMarkets.Events.AccrueInterest,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "cashPrior",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "interestAccumulated",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "borrowIndex",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "totalBorrows",
                  "type" => "uint256"
                }
              ],
              "name" => "AccrueInterest",
              "type" => "event"
            }
          ]
        }
      ],
      # FutureSwap
      "TradeOpen(uint256,address,bool,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address)" =>
        [
          %{
            enabled: true,
            struct: Rube.FutureSwap.Events.TradeOpen,
            handler: {Rube.EventHandler, :handle_event, []},
            abi: [
              %{
                "anonymous" => false,
                "inputs" => [
                  %{
                    "indexed" => true,
                    "internalType" => "uint256",
                    "name" => "tradeId",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => true,
                    "internalType" => "address",
                    "name" => "tradeOwner",
                    "type" => "address"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "bool",
                    "name" => "isLong",
                    "type" => "bool"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "collateral",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "leverage",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "assetPrice",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "stablePrice",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "openFee",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "oracleRoundId",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => false,
                    "internalType" => "uint256",
                    "name" => "timestamp",
                    "type" => "uint256"
                  },
                  %{
                    "indexed" => true,
                    "internalType" => "address",
                    "name" => "referral",
                    "type" => "address"
                  }
                ],
                "name" => "TradeOpen",
                "type" => "event"
              }
            ]
          }
        ],
      "TradeLiquidate(uint256,address,address,uint256,uint256,uint256)" => [
        %{
          enabled: true,
          struct: Rube.FutureSwap.Events.TradeLiquidate,
          handler: {Rube.EventHandler, :handle_event, []},
          abi: [
            %{
              "anonymous" => false,
              "inputs" => [
                %{
                  "indexed" => true,
                  "internalType" => "uint256",
                  "name" => "tradeId",
                  "type" => "uint256"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "tradeOwner",
                  "type" => "address"
                },
                %{
                  "indexed" => true,
                  "internalType" => "address",
                  "name" => "liquidator",
                  "type" => "address"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "stableToSendLiquidator",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "stableToSendTradeOwner",
                  "type" => "uint256"
                },
                %{
                  "indexed" => false,
                  "internalType" => "uint256",
                  "name" => "timestamp",
                  "type" => "uint256"
                }
              ],
              "name" => "TradeLiquidate",
              "type" => "event"
            }
          ]
        }
      ]
    }
  }

# Livebook
config :livebook, LivebookWeb.Endpoint,
  url: [host: livebook_host, port: http_port],
  pubsub_server: Livebook.PubSub,
  secret_key_base: prop_secret_key_base,
  live_view: [signing_salt: prop_live_view_signing_salt],
  server: false

Livebook.config_runtime()

# Master Proxy
config :master_proxy,
  # any Cowboy options are allowed
  http: [:inet6, port: http_port],
  # https: [:inet6, port: 4443],
  backends: [
    %{
      host: ~r/#{prop_host}/,
      phoenix_endpoint: PropWeb.Endpoint
    },
    %{
      host: ~r/#{workbench_host}/,
      phoenix_endpoint: WorkbenchWeb.Endpoint
    },
    %{
      host: ~r/#{history_host}/,
      phoenix_endpoint: HistoryWeb.Endpoint
    },
    %{
      host: ~r/#{rube_host}/,
      phoenix_endpoint: RubeWeb.Endpoint
    },
    %{
      host: ~r/#{slurpee_host}/,
      phoenix_endpoint: SlurpeeWeb.Endpoint
    },
    %{
      host: ~r/#{livebook_host}/,
      phoenix_endpoint: LivebookWeb.Endpoint
    }
  ]

# Navigation
config :navigator,
  links: %{
    prop: [
      %{
        label: "Prop",
        link: {PropWeb.Router.Helpers, :home_path, [PropWeb.Endpoint, :index]},
        class: "text-4xl"
      },
      %{
        label: "Workbench",
        link: {WorkbenchWeb.Router.Helpers, :balance_all_url, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "History",
        link: {HistoryWeb.Router.Helpers, :trade_url, [HistoryWeb.Endpoint, :index]}
      },
      %{
        label: "Rube",
        link: {RubeWeb.Router.Helpers, :home_url, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Slurpee",
        link: {SlurpeeWeb.Router.Helpers, :home_url, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Livebook",
        link: {LivebookWeb.Router.Helpers, :home_url, [LivebookWeb.Endpoint, :page]}
      },
      %{
        label: "Grafana",
        link: "http://#{grafana_host}"
      },
      %{
        label: "Prometheus",
        link: "http://#{prometheus_host}"
      }
    ],
    workbench: [
      %{
        label: "Workbench",
        link: {WorkbenchWeb.Router.Helpers, :balance_all_path, [WorkbenchWeb.Endpoint, :index]},
        class: "text-4xl"
      },
      %{
        label: "Balances",
        link: {WorkbenchWeb.Router.Helpers, :balance_day_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Wallets",
        link: {WorkbenchWeb.Router.Helpers, :wallet_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Accounts",
        link: {WorkbenchWeb.Router.Helpers, :account_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Orders",
        link: {WorkbenchWeb.Router.Helpers, :order_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Positions",
        link: {WorkbenchWeb.Router.Helpers, :position_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Products",
        link: {WorkbenchWeb.Router.Helpers, :product_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Fees",
        link: {WorkbenchWeb.Router.Helpers, :fee_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Venues",
        link: {WorkbenchWeb.Router.Helpers, :venue_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Advisors",
        link: {WorkbenchWeb.Router.Helpers, :fleet_path, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Prop",
        link: {PropWeb.Router.Helpers, :home_url, [PropWeb.Endpoint, :index]}
      },
      %{
        label: "Rube",
        link: {RubeWeb.Router.Helpers, :home_url, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Slurpee",
        link: {SlurpeeWeb.Router.Helpers, :home_url, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Livebook",
        link: {LivebookWeb.Router.Helpers, :home_url, [LivebookWeb.Endpoint, :page]}
      },
      %{
        label: "Grafana",
        link: "http://#{grafana_host}"
      },
      %{
        label: "Prometheus",
        link: "http://#{prometheus_host}"
      }
    ],
    history: [
      %{
        label: "History",
        link: {HistoryWeb.Router.Helpers, :trade_path, [HistoryWeb.Endpoint, :index]},
        class: "text-4xl"
      },
      %{
        label: "Data",
        link: {HistoryWeb.Router.Helpers, :trade_path, [HistoryWeb.Endpoint, :index]}
      },
      %{
        label: "Products",
        link: {HistoryWeb.Router.Helpers, :product_path, [HistoryWeb.Endpoint, :index]}
      },
      %{
        label: "Tokens",
        link: {HistoryWeb.Router.Helpers, :token_path, [HistoryWeb.Endpoint, :index]}
      },
      %{
        label: "Prop",
        link: {PropWeb.Router.Helpers, :home_url, [PropWeb.Endpoint, :index]}
      },
      %{
        label: "Workbench",
        link: {WorkbenchWeb.Router.Helpers, :balance_all_url, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Rube",
        link: {RubeWeb.Router.Helpers, :home_url, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Slurpee",
        link: {SlurpeeWeb.Router.Helpers, :home_url, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Livebook",
        link: {LivebookWeb.Router.Helpers, :home_url, [LivebookWeb.Endpoint, :page]}
      },
      %{
        label: "Grafana",
        link: "http://#{grafana_host}"
      },
      %{
        label: "Prometheus",
        link: "http://#{prometheus_host}"
      }
    ],
    rube: [
      %{
        label: "Rube",
        link: {RubeWeb.Router.Helpers, :home_url, [RubeWeb.Endpoint, :index]},
        class: "text-4xl"
      },
      %{
        label: "Tokens",
        link: {RubeWeb.Router.Helpers, :token_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Money Markets",
        link: {RubeWeb.Router.Helpers, :money_market_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "AMM",
        link: {RubeWeb.Router.Helpers, :amm_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "FutureSwap",
        link: {RubeWeb.Router.Helpers, :future_swap_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Perpetual",
        link: {RubeWeb.Router.Helpers, :perpetual_protocol_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Injective",
        link: {RubeWeb.Router.Helpers, :injective_protocol_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Vega",
        link: {RubeWeb.Router.Helpers, :vega_protocol_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Chainlink",
        link: {RubeWeb.Router.Helpers, :chainlink_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Keep3r",
        link: {RubeWeb.Router.Helpers, :keep3r_path, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Prop",
        link: {PropWeb.Router.Helpers, :home_url, [PropWeb.Endpoint, :index]}
      },
      %{
        label: "Workbench",
        link: {WorkbenchWeb.Router.Helpers, :balance_all_url, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Slurpee",
        link: {SlurpeeWeb.Router.Helpers, :home_url, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Livebook",
        link: {LivebookWeb.Router.Helpers, :home_url, [LivebookWeb.Endpoint, :page]}
      },
      %{
        label: "Grafana",
        link: "http://#{grafana_host}"
      },
      %{
        label: "Prometheus",
        link: "http://#{prometheus_host}"
      }
    ],
    slurpee: [
      %{
        label: "Slurpee",
        link: {SlurpeeWeb.Router.Helpers, :home_url, [SlurpeeWeb.Endpoint, :index]},
        class: "text-4xl"
      },
      %{
        label: "Blockchains",
        link: {SlurpeeWeb.Router.Helpers, :blockchain_path, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Log Subscriptions",
        link: {SlurpeeWeb.Router.Helpers, :log_subscription_path, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "New Head Subscriptions",
        link:
          {SlurpeeWeb.Router.Helpers, :new_head_subscription_path, [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Transaction Subscriptions",
        link:
          {SlurpeeWeb.Router.Helpers, :transaction_subscription_path,
           [SlurpeeWeb.Endpoint, :index]}
      },
      %{
        label: "Prop",
        link: {PropWeb.Router.Helpers, :home_url, [PropWeb.Endpoint, :index]}
      },
      %{
        label: "Workbench",
        link: {WorkbenchWeb.Router.Helpers, :balance_all_url, [WorkbenchWeb.Endpoint, :index]}
      },
      %{
        label: "Rube",
        link: {RubeWeb.Router.Helpers, :home_url, [RubeWeb.Endpoint, :index]}
      },
      %{
        label: "Livebook",
        link: {LivebookWeb.Router.Helpers, :home_url, [LivebookWeb.Endpoint, :page]}
      },
      %{
        label: "Grafana",
        link: "http://#{grafana_host}"
      },
      %{
        label: "Prometheus",
        link: "http://#{prometheus_host}"
      }
    ]
  }

# Notifications
config :notified, pubsub_server: Tai.PubSub

config :notified,
  receivers: [
    {NotifiedPhoenix.Receivers.Speech, []},
    {NotifiedPhoenix.Receivers.BrowserNotification, []}
  ]

config :notified_phoenix,
  to_list: {WorkbenchWeb.Router.Helpers, :notification_path, [WorkbenchWeb.Endpoint, :index]}

# Conditional configuration
# dev
if config_env() == :dev do
  # Disable authentication mode during dev
  # config :livebook, :authentication_mode, :disabled

  # config :libcluster,
  #   topologies: [
  #     gossip: [
  #       strategy: Cluster.Strategy.Gossip
  #     ]
  #   ]

  config :prop, Prop.Repo, show_sensitive_data_on_connection_error: true

  # For development, we disable any cache and enable
  # debugging and code reloading.
  #
  # The watchers configuration can be used to run external
  # watchers to your application. For example, we use it
  # with webpack to recompile .js and .css sources.
  config :prop, PropWeb.Endpoint,
    server: true,
    debug_errors: true,
    code_reloader: true,
    check_origin: false,
    watchers: [
      npm: [
        "run",
        "watch",
        cd: Path.expand("../assets", __DIR__)
      ]
    ]

  # Watch static and templates for browser reloading.
  config :prop, PropWeb.Endpoint,
    live_reload: [
      patterns: [
        ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
        ~r"priv/gettext/.*(po)$",
        ~r"lib/prop_web/{live,views}/.*(ex)$",
        ~r"lib/prop_web/templates/.*(eex)$"
      ]
    ]

  config :workbench, Workbench.Repo, show_sensitive_data_on_connection_error: true

  config :workbench, WorkbenchWeb.Endpoint,
    debug_errors: true,
    check_origin: false

  config :history, History.Repo, show_sensitive_data_on_connection_error: true

  config :history, HistoryWeb.Endpoint,
    debug_errors: true,
    check_origin: false

  config :history,
    data_adapters: %{
      binance: History.Sources.Binance,
      bitmex: History.Sources.Bitmex,
      bybit: History.Sources.Bybit,
      gdax: History.Sources.Gdax,
      ftx: History.Sources.Ftx,
      okex: History.Sources.OkEx
    }

  config :rube, Rube.Repo, show_sensitive_data_on_connection_error: true

  config :rube, RubeWeb.Endpoint,
    debug_errors: true,
    check_origin: false

  config :slurpee, Slurpee.Repo, show_sensitive_data_on_connection_error: true

  config :slurpee, SlurpeeWeb.Endpoint,
    debug_errors: true,
    check_origin: false

  # Do not include metadata nor timestamps in development logs
  # config :logger, :console, format: "[$level] $message\n"

  # Set a higher stacktrace during development. Avoid configuring such
  # in production as building large stacktraces may be expensive.
  config :phoenix, :stacktrace_depth, 20

  # Initialize plugs at runtime for faster development compilation
  config :phoenix, :plug_init_mode, :runtime

  config :tai, Tai.Orders.OrderRepo, show_sensitive_data_on_connection_error: true

  config :tai,
    venues: %{
      binance: [
        enabled: true,
        adapter: Tai.VenueAdapters.Binance,
        timeout: 60_000,
        products: "*",
        order_books: ""
      ],
      bitmex: [
        enabled: true,
        adapter: Tai.VenueAdapters.Bitmex,
        products: "xbtusd",
        order_books: ""
      ],
      bybit: [
        enabled: true,
        adapter: Tai.VenueAdapters.Bybit,
        products: "*",
        order_books: ""
      ],
      gdax: [
        enabled: true,
        adapter: Tai.VenueAdapters.Gdax,
        products: "btc_usd",
        order_books: ""
      ],
      ftx: [
        enabled: true,
        adapter: Tai.VenueAdapters.Ftx,
        timeout: 60_000,
        products: "*",
        order_books: ""
      ]
    }
end

# test
if config_env() == :test do
  # Print only warnings and errors during test
  config :logger, level: :warn

  config :prop, Prop.Repo,
    show_sensitive_data_on_connection_error: true,
    pool: Ecto.Adapters.SQL.Sandbox

  # We don't run a server during test. If one is required,
  # you can enable the server option below.
  config :prop, PropWeb.Endpoint, http: [port: 4002]

  config :tai, Tai.Orders.OrderRepo,
    show_sensitive_data_on_connection_error: true,
    pool: Ecto.Adapters.SQL.Sandbox
end

# Prod
if config_env() == :prod do
  config :prop, PropWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"
end
