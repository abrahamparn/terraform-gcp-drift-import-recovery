---
name: Terraform Drift Report
description: Track detected Terraform drift
title: "drift: "
labels: ["drift", "terraform", "investigation"]
assignees: []
---

## Summary

Describe the detected drift.

## Detection Source

- [ ] Scheduled drift detection workflow
- [ ] Manual `terraform plan`
- [ ] Manual `terraform plan -refresh-only`
- [ ] Cloud console review
- [ ] Other

## Affected Resources

List Terraform resource addresses:

```text
example: google_compute_firewall.allow_http_internal
```
