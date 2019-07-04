/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

locals {
  tags = {
    Terraform = "true"
  }
}

// Policy - AWS Service
data "aws_iam_policy_document" "aws_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        var.aws_service_name,
      ]
    }
  }
}

// Policy - AWS Account
data "aws_iam_policy_document" "aws_account" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root",
      ]
    }
  }
}

// Policy - SAML Federation
data "aws_iam_policy_document" "saml_federation" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithSAML"]

    principals {
      type = "Federated"

      identifiers = [
        "arn:aws:iam::${var.saml_account_id}:saml-provider/${var.saml_identity_provider}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = [var.saml_aud]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root",
      ]
    }
  }
}

// Role
resource "aws_iam_role" "aws_service" {
  count = length(keys(var.aws_service_roles))

  name        = element(keys(var.aws_service_roles), count.index)
  description = element(values(var.aws_service_roles), count.index)

  assume_role_policy = data.aws_iam_policy_document.aws_service.json

  tags = merge(var.tags, local.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "aws_account" {
  count = length(keys(var.aws_account_roles))

  name        = element(keys(var.aws_account_roles), count.index)
  description = element(values(var.aws_account_roles), count.index)

  assume_role_policy = data.aws_iam_policy_document.aws_account.json

  tags = merge(var.tags, local.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "saml_federation" {
  count = length(keys(var.saml_roles))

  name        = element(keys(var.saml_roles), count.index)
  description = element(values(var.saml_roles), count.index)

  assume_role_policy = data.aws_iam_policy_document.saml_federation.json

  tags = merge(var.tags, local.tags)

  lifecycle {
    create_before_destroy = true
  }
}
