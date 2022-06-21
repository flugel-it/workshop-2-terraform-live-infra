package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestMain(t *testing.T) {

	// The folder where we have our Terraform code # TODO: use SaveString on it
	tfDir := "../"

	// At the end of the test, destroy the AMI Created and Tf
	defer test_structure.RunTestStage(t, "cleanup", func() {
		// Clean up Tf
		destroyTerraform(t, tfDir)
	})

	// Stage to Deploy Terraform
	test_structure.RunTestStage(t, "terraform-create", func() {
		deployUsingTerraform(t, tfDir)
	})

}

// Undeploy the app using Terraform
func destroyTerraform(t *testing.T, tfDir string) {
	// Load the Terraform Options saved by the earlier deploy_terraform stage
	terraformOptions := test_structure.LoadTerraformOptions(t, tfDir)

	// Destroy Tf
	terraform.TgDestroyAll(t, terraformOptions)
}

// Deploy the app using Terraform
func deployUsingTerraform(t *testing.T, tfDir string) {

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tfDir,

		// Binary used in test
		TerraformBinary: "terragrunt",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{},
	}

	// Save the Terraform Options struct, instance name, and instance text so future test stages can use it
	test_structure.SaveTerraformOptions(t, tfDir, terraformOptions)

	// Performs Terragrunt Init
	terraform.Init(t, terraformOptions)

	// Performs Terragrunt Plan-ALl
	terraform.TgPlanAllExitCode(t, terraformOptions)

	// Performs an Apply-All
	terraform.TgApplyAll(t, terraformOptions)
}
