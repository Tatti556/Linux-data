local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------
-- 基本設定
----------------------------------------------------

-- 設定ファイルを保存すると自動で再読み込み
config.automatically_reload_config = true

-- デフォルトシェル（現在の設定を維持）
config.default_prog = { "/usr/bin/zsh", "-l" }

-- フォントサイズ
config.font_size = 12.0

-- IMEを有効化
config.use_ime = true

----------------------------------------------------
-- 外観
----------------------------------------------------

-- 背景色
config.colors = {
  background = "#000000",

  tab_bar = {
    inactive_tab_edge = "#000000",
  },
}

-- 背景の不透明度
-- 1.0 = 不透明 / 0.0 = 完全透明
config.window_background_opacity = 0.85

-- Waylandを有効化
config.enable_wayland = true

-- macOS専用の背景ぼかし設定は使用しない
-- KDE Plasmaの背景ぼかしについては後述

----------------------------------------------------
-- ウィンドウ
----------------------------------------------------

-- タイトルバーを非表示、リサイズ枠は維持
config.window_decorations = "RESIZE"

----------------------------------------------------
-- タブバー
----------------------------------------------------

config.enable_tab_bar = true

-- タブをタブバーに表示
config.show_tabs_in_tab_bar = true

-- タブが1つのときはタブバーを非表示
config.hide_tab_bar_if_only_one_tab = true

-- Fancy Tab Barを使用
config.use_fancy_tab_bar = true

-- 新規タブ追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- タブバーの背景
config.window_frame = {
  active_titlebar_bg = "#000000",
  inactive_titlebar_bg = "#000000",
}

-- タブ幅
config.tab_max_width = 32

----------------------------------------------------
-- タブの形状・色
----------------------------------------------------

-- Nerd Fontの三角形アイコン
local SOLID_LEFT_ARROW =
  wezterm.nerdfonts.ple_lower_right_triangle

local SOLID_RIGHT_ARROW =
  wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(
  tab, tabs, panes, config, hover, max_width
)
  -- 非アクティブなタブ
  local background = "#5c6d74"
  local foreground = "#ffffff"

  -- アクティブなタブ
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#ffffff"
  end

  -- タブの周囲の背景色
  local edge_background = "#000000"

  -- タブタイトル
  local pane_title = tab.active_pane.title or "zsh"

  local title = " "
    .. wezterm.truncate_right(
      pane_title,
      math.max(1, max_width - 4)
    )
    .. " "

  return {
    -- 左側の三角形
    {
      Background = { Color = edge_background },
    },
    {
      Foreground = { Color = background },
    },
    {
      Text = SOLID_LEFT_ARROW,
    },

    -- タブ本体
    {
      Background = { Color = background },
    },
    {
      Foreground = { Color = foreground },
    },
    {
      Text = title,
    },

    -- 右側の三角形
    {
      Background = { Color = edge_background },
    },
    {
      Foreground = { Color = background },
    },
    {
      Text = SOLID_RIGHT_ARROW,
    },
  }
end)

----------------------------------------------------
-- キーバインド
----------------------------------------------------

-- 標準ショートカットを維持する
config.disable_default_key_bindings = false

-- Leaderキー
config.leader = {
  key = "q",
  mods = "CTRL",
  timeout_milliseconds = 2000,
}

-- 別ファイルからキーバインドを読み込む
local keybinds = require("keybinds")

config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

return config
