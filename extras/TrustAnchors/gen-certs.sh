#!/bin/bash
# Used to generate certs for BearSSL
curl https://raw.githubusercontent.com/certifi/python-certifi/master/certifi/cacert.pem -o cacert.pem
retCode=$?
if [[ "$retCode" == "0" ]]; then
cat >../../src/BearSSLTrustAnchors.h <<EOF
/*
 * Copyright (c) 2018 Arduino SA. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef _BEAR_SSL_TRUST_ANCHORS_H_
#define _BEAR_SSL_TRUST_ANCHORS_H_

#include "bearssl/bearssl_ssl.h"

// The following was created by running the BearSSL "brssl" tool in the
// extras/TrustAnchors directory:
//
//   brssl ta *.cer

EOF
  ./brssl_x86_linux ta cacert.pem >>../../src/BearSSLTrustAnchors.h
  echo -e "\n#endif" >>../../src/BearSSLTrustAnchors.h
else
  echo "Failed retrieving certs: [$retCode]"
  exit 1
fi

