Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6DAC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADD020723
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADD020723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi1c-0008Lr-Nn
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrv-0006QV-Cj; Sat, 19 Sep 2020 14:45:56 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhri-0001Sa-9b; Sat, 19 Sep 2020 14:45:52 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVrXh-1jsS4z0XG1-00RmE9; Sat, 19 Sep 2020 20:45:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] scripts/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:46 +0200
Message-Id: <20200919184451.2129349-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ToRF9ijQbLwKLUOyNUID350EhQHEUJaEBCR5GZRbDaA4yqRPpwO
 +3nZ5HNFcERP19jm/r+HzyJnPqechdUX16e6mh8EqaYu8AhisSuWIkeAAjA1CRINQ0NuEto
 pQLIul7JnU4+5LXzBUI/YlvC1eJkSG3q1agAsrFQfaJZDgoJikdNrq6HLcqu2IgkLG1A/2O
 1VDyQv4pf4gOsvcVtKF8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gkVeuz2F/kQ=:wAj3wbq3wtVHME79IbxU8K
 2Q3+/WoOtXsvTg5g1P32rwYJguWh6JQ8YY0feKmt3E1s1gUhhjMUaAjh4vex9jzJiv56CC839
 y76kv8gBqvMOiHtDP3fgrczW4r6EWUVUppAssZq+gW4lYk7lwGu8jah+YH44ArUatG512vFSb
 nPwDA604QDsCAYiADazN26M61tWWHnluf1gQvOAdMat8NGkj+zFhMnKDH9h3qiPUls9nstI2J
 LheGOay3OIdPCq6ZtYOvvbB1qIEyqRSI0dEBeMlb3w4lKU756VWdMC3fjCOu/87t2J8WF5NQr
 b3fTc3IgiK5Ce49P0JdWHns+8QLFE1uRSAsmAgmhlATKiOh4vNFOqZG2ZZrYjf7iLCwvfFxeW
 KAZEg/X9/WKQehKH7B1vUMZ4yFgTKHCNZCCNiN8SzwnfxHOIEmxWUurmY42D9vktfBkWSCuse
 L714LdPxRSkXixHfTSJ36W3d9xfaq2wP61Cl9RZQQCYfVZbmTrWxrUyb9ZgVaFvdcIZ12NIOH
 L2LrPWJJxd4EuS4QsNumQysIdlKWsdOea/lNyV9KEQwocU3eHa3vfIvknlXbR9tAsHAoUu0zU
 MFShzWcuSpuWIR/VSae8/rnHZjmmM9XGOG1sgyM4IyLfzMiZr7c0JKSHMys+IYdI8pKNWlFxn
 VI6axrtdATgkcP2O91ME9WvIwByJ1BcSSvwkX+uYNkBAvIvsprca+RssvKhfU2s0zEgbHXDD2
 nCXoTrDBidcufmj2krixTlRTYNbI7AU/tn+07F8+6jvLX6AIbG6OGf4vHOBOirRqoSz/jvy1q
 gN4tLuw9Mp3GN8skaTL7dyhoJZ136EdlFK5URv8VNuZUyvbr2US8SduuU63URIM60FyGpn8
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the scripts folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200917075029.313-5-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/checkpatch.pl          | 2 +-
 scripts/clean-header-guards.pl | 2 +-
 scripts/decodetree.py          | 6 +++---
 scripts/oss-fuzz/build.sh      | 2 +-
 scripts/tracetool/__init__.py  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c36..50910899f2ee 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1870,7 +1870,7 @@ sub process {
 			substr($s, 0, length($c), '');
 
 			# Make sure we remove the line prefixes as we have
-			# none on the first line, and are going to readd them
+			# none on the first line, and are going to re-add them
 			# where necessary.
 			$s =~ s/\n./\n/gs;
 
diff --git a/scripts/clean-header-guards.pl b/scripts/clean-header-guards.pl
index f47d673ad5c5..a6680253b1fa 100755
--- a/scripts/clean-header-guards.pl
+++ b/scripts/clean-header-guards.pl
@@ -19,7 +19,7 @@
 # Does the following:
 # - Header files without a recognizable header guard are skipped.
 # - Clean up any untidy header guards in-place.  Warn if the cleanup
-#   renames guard symbols, and explain how to find occurences of these
+#   renames guard symbols, and explain how to find occurrences of these
 #   symbols that may have to be updated manually.
 # - Warn about duplicate header guard symbols.  To make full use of
 #   this warning, you should clean up *all* headers in one run.
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index c02de9865b27..60fd3b5e5f66 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -94,7 +94,7 @@ def str_indent(c):
 
 
 def str_fields(fields):
-    """Return a string uniquely identifing FIELDS"""
+    """Return a string uniquely identifying FIELDS"""
     r = ''
     for n in sorted(fields.keys()):
         r += '_' + n
@@ -814,7 +814,7 @@ def parse_generic(lineno, parent_pat, name, toks):
     arg = None
     fmt = None
     for t in toks:
-        # '&Foo' gives a format an explcit argument set.
+        # '&Foo' gives a format an explicit argument set.
         if re.fullmatch(re_arg_ident, t):
             tt = t[1:]
             if arg:
@@ -903,7 +903,7 @@ def parse_generic(lineno, parent_pat, name, toks):
     elif not (is_format and width == 0) and width != insnwidth:
         error(lineno, 'definition has {0} bits'.format(width))
 
-    # Do not check for fields overlaping fields; one valid usage
+    # Do not check for fields overlapping fields; one valid usage
     # is to be able to duplicate fields via import.
     fieldmask = 0
     for f in flds.values():
diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index d16207eb6726..0c3ca9e06f02 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -69,7 +69,7 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 
 if ! make "-j$(nproc)" qemu-fuzz-i386; then
     fatal "Build failed. Please specify a compiler with fuzzing support"\
-          "using the \$CC and \$CXX environemnt variables"\
+          "using the \$CC and \$CXX environment variables"\
           "\nFor example: CC=clang CXX=clang++ $0"
 fi
 
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 3ccfa1e1163d..3ee54be223c6 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -34,7 +34,7 @@ def error(*lines):
 def out(*lines, **kwargs):
     """Write a set of output lines.
 
-    You can use kwargs as a shorthand for mapping variables when formating all
+    You can use kwargs as a shorthand for mapping variables when formatting all
     the strings in lines.
     """
     lines = [ l % kwargs for l in lines ]
-- 
2.26.2


