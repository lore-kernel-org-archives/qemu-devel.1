Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B6D221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B6D221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIowg-0000NC-1O
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIohS-0004mN-Vz; Thu, 17 Sep 2020 03:51:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4755 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIohQ-0005MI-O9; Thu, 17 Sep 2020 03:51:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 892602E1AAE689C3AAC3;
 Thu, 17 Sep 2020 15:51:17 +0800 (CST)
Received: from localhost (10.174.187.87) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 15:51:09 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V3 04/10] scripts/: fix some comment spelling errors
Date: Thu, 17 Sep 2020 15:50:23 +0800
Message-ID: <20200917075029.313-5-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200917075029.313-1-zhaolichang@huawei.com>
References: <20200917075029.313-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.87]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:37:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter
 Maydell <peter.maydell@linaro.org>, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the scripts folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/checkpatch.pl          | 2 +-
 scripts/clean-header-guards.pl | 2 +-
 scripts/decodetree.py          | 6 +++---
 scripts/oss-fuzz/build.sh      | 2 +-
 scripts/tracetool/__init__.py  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c..50910899f2 100755
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
index f47d673ad5..a6680253b1 100755
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
index c02de9865b..60fd3b5e5f 100644
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
index d16207eb67..0c3ca9e06f 100755
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
index 3ccfa1e116..3ee54be223 100644
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
2.26.2.windows.1


