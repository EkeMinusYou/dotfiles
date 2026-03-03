return {
  'HakonHarnes/img-clip.nvim',
  event = 'VeryLazy',
  opts = {
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        enabled = false,
      },
      dir_path = 'assets',
      extension = 'png',
      file_name = '%Y-%m-%d-%H-%M-%S',
      use_absolute_path = false,
    },
  },
}
