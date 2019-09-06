module HecksApp
  gem_dir = Gem::Specification.find_by_name('soccer_season').gem_dir
  DOMAIN_SCHEMA =
    instance_eval(File.open("#{gem_dir}/Domainfile").read)
    .instance_variable_get(:@parser)
    .domain.freeze
end