class MoveParametersToDockerParameters < ActiveRecord::Migration
  def up
  # All the  DockerContainerWizardStates::PARAMETER are temporary for the wizard step so no need to keep them
   docker_params = select_all("select name, value, reference_id, type from parameters where type in ['EnvironmentVariable', 'ForemanDocker::Dns', 'ExposedPort']")
   docker_params.each do |param|
    DockerParameter.create(param)
   end
  end

  def down
    DockerParams.unscoped.each do |param|
      Parameter.create(param)
    end
  end
end
