# CLAUDE.md - AI Assistant Guidelines

This document provides guidance for AI assistants working with the **Módulo Integrado de Dor** (Integrated Pain Management System) codebase.

## Project Overview

**Name**: Módulo Integrado de Dor (Integrated Pain Module)
**Description**: Integrated Pain Management System - Module X
**License**: MIT
**Language**: Python
**Author**: drvictoratalves-del

### Purpose

This is a healthcare-related software project focused on pain management. The system is likely intended for clinical or research use to help medical professionals assess, track, and manage patient pain.

## Repository Structure

```
M-dulo-Integrado-de-Dor/
├── .gitignore          # Python-specific ignore patterns
├── LICENSE             # MIT License
├── README.md           # Project description
└── CLAUDE.md           # This file - AI assistant guidelines
```

### Planned/Recommended Structure

As the project grows, consider this standard Python project structure:

```
M-dulo-Integrado-de-Dor/
├── src/                    # Source code
│   └── modulo_dor/         # Main package
│       ├── __init__.py
│       ├── core/           # Core functionality
│       ├── assessment/     # Pain assessment tools
│       ├── tracking/       # Pain tracking features
│       └── reports/        # Reporting functionality
├── tests/                  # Test files
│   ├── __init__.py
│   ├── test_core.py
│   └── ...
├── docs/                   # Documentation
├── data/                   # Sample data (non-sensitive)
├── pyproject.toml          # Project configuration
├── requirements.txt        # Dependencies (or use pyproject.toml)
└── ...
```

## Development Guidelines

### Python Conventions

- **Python Version**: Use Python 3.10+ for modern features and type hints
- **Code Style**: Follow PEP 8 guidelines
- **Type Hints**: Use type annotations for function signatures and complex variables
- **Docstrings**: Use Google-style or NumPy-style docstrings consistently

### Naming Conventions

- **Modules/Packages**: `snake_case` (e.g., `pain_assessment.py`)
- **Classes**: `PascalCase` (e.g., `PainScale`, `PatientRecord`)
- **Functions/Variables**: `snake_case` (e.g., `calculate_pain_score`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `MAX_PAIN_LEVEL`)

### Code Quality Tools

The .gitignore suggests support for these tools:

- **Linting**: Ruff (`.ruff_cache/` is ignored)
- **Type Checking**: mypy (`.mypy_cache/` is ignored)
- **Testing**: pytest (`.pytest_cache/` is ignored)
- **Coverage**: coverage.py (`.coverage` files ignored)

### Recommended Commands

```bash
# Install dependencies (when requirements.txt exists)
pip install -r requirements.txt

# Or with pyproject.toml
pip install -e .

# Run tests (when tests exist)
pytest

# Run tests with coverage
pytest --cov=src/modulo_dor

# Lint code
ruff check .

# Format code
ruff format .

# Type check
mypy src/
```

## Healthcare Software Considerations

### Data Privacy & Security

This is a healthcare application. When contributing:

1. **Never commit real patient data** - Use synthetic/mock data only
2. **Environment variables** - Store sensitive configuration in `.env` (already gitignored)
3. **Logging** - Never log personally identifiable information (PII)
4. **Input validation** - Always validate and sanitize user inputs
5. **Encryption** - Consider encryption for data at rest and in transit

### Medical Software Best Practices

- **Accuracy**: Pain assessment calculations must be precise and validated
- **Validation**: Cross-reference implementations with medical literature
- **Audit Trail**: Consider logging for clinical decision support features
- **Accessibility**: UI components should follow WCAG guidelines
- **Localization**: Support Portuguese (primary) and English (secondary)

### Regulatory Awareness

When implementing features, consider:
- LGPD (Lei Geral de Proteção de Dados) - Brazilian data protection law
- HIPAA concepts if international use is intended
- Medical device software regulations if applicable

## Git Workflow

### Branch Naming

- Feature branches: `feature/description`
- Bug fixes: `fix/description`
- Claude AI branches: `claude/description-sessionid`

### Commit Messages

Use clear, descriptive commit messages:
```
feat: add visual analog scale component
fix: correct pain score calculation for pediatric patients
docs: update assessment documentation
test: add unit tests for pain tracking module
```

### Pull Requests

- Include description of changes
- Reference any related issues
- Ensure tests pass before merging

## Testing Guidelines

### Test Structure

```python
# tests/test_example.py
import pytest
from modulo_dor.core import calculate_pain_score

class TestPainScore:
    def test_valid_score_range(self):
        """Pain scores should be between 0 and 10."""
        score = calculate_pain_score(...)
        assert 0 <= score <= 10

    def test_edge_cases(self):
        """Test boundary conditions."""
        ...
```

### Test Categories

- **Unit tests**: Test individual functions and classes
- **Integration tests**: Test component interactions
- **Validation tests**: Verify medical accuracy of calculations

## AI Assistant Instructions

### When Working on This Codebase

1. **Read before modifying**: Always read existing files before making changes
2. **Healthcare context**: Remember this is medical software - accuracy is critical
3. **Portuguese context**: Comments and user-facing text may be in Portuguese
4. **Privacy first**: Never suggest storing or logging patient data insecurely
5. **Test coverage**: Suggest tests for any new functionality
6. **Documentation**: Keep documentation updated with changes

### Common Tasks

- **Adding a pain scale**: Follow existing assessment patterns, validate against medical standards
- **Creating reports**: Ensure data aggregation doesn't expose individual patient data
- **API endpoints**: Implement proper authentication and authorization

### Things to Avoid

- Hardcoding sensitive configuration
- Committing mock data that resembles real patient information
- Implementing features without input validation
- Making breaking changes without migration paths
- Ignoring error handling in clinical workflows

## Dependencies (Anticipated)

Based on the .gitignore and project type, likely dependencies include:

```
# Core
python >= 3.10

# Web Framework (if applicable)
fastapi or flask or django

# Data Processing
pandas
numpy

# Database
sqlalchemy
# or specific database driver

# Testing
pytest
pytest-cov

# Code Quality
ruff
mypy
```

## Contact & Resources

- **Repository**: M-dulo-Integrado-de-Dor
- **License**: MIT
- **Author**: drvictoratalves-del

---

*Last updated: 2025-11-28*
