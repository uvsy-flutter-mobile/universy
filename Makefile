VENV ?= venv
STAGE ?= dev2


init: clean init-venv

init-venv: clean-venv create-venv update-venv
	@echo ""
	@echo "Do not forget to activate your new virtual environment"

create-venv:
	@echo "Creating virtual environment: $(VENV)..."
	@python3 -m venv $(VENV)

update-venv:
	@echo "Updating virtual environment: $(VENV)..."
	@( \
		. $(VENV)/bin/activate; \
		pip install --upgrade pip; \
		pip install pre-commit boto3==1.16.9 click==7.1.2; \
		pre-commit install; \
	)

clean: clean-venv

clean-venv:
	@echo "Removing virtual environment: $(VENV)..."
	@rm -rf $(VENV)

configure:
	@python3 bin/configure.py --stage $(STAGE)
