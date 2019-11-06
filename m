Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04879C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B3A2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B3A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSO8G-0004ST-TR
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSO6T-0002au-2N
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSO6R-0000I6-NL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:16 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSO6R-0000HI-Da
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:24:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8yU2-1iXK3Q30g2-0069Yt; Wed, 06 Nov 2019 17:24:10 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 3/3] global: Squash 'the the'
Date: Wed,  6 Nov 2019 17:24:06 +0100
Message-Id: <20191106162406.27030-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106162406.27030-1-laurent@vivier.eu>
References: <20191106162406.27030-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XEdVWtA5HY1feE8iQtxEShbY8h+fghhbUFGdd51gkZIq/jb0DeN
 IOPxCF+fOBcuIPQ899MQBeAoOFf3Qu6HutgatHBeKQ2GuAou9HYESk1ZJ7Ke0jgxZc8JHZk
 RgPfeXM8886nkQYYPTIRKKy2VpKsFwc3w3AFDmrf6R1JUNoySFZSmBWczuF/CdgX/BYQidC
 +9Zdj5RFEssn9nE9yA+Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3vcKe5r2Ak=:22Ni7v0Qp5XGnhS1wvXh+6
 9pTGI/ffrCEB2nAOFyu8LEbUVWMvUpRjrv+ddBxBgd78EGXCZ/reYM4+iC5uv4DhuoDBvrwUT
 CDlV3abGIe6UZabJyktM0zcFsOXZAZALdzY+RX4m4ybmlyX5KA467uIN2FM57uVd1nM1DaJKs
 DkHcEVnXH0oBkP3HjBTsByGt5Fjx1waSw6eFLSsaYZQlH6ZzbWmHNjnhix15x3FyA+/JNk5Z0
 C+OuVlzrPH4t7xBQ109yET1STUXpgTORwCzM5/rG7rB4XFR4hxB8VMjj8RkDi5zZ+PwRVi3OU
 IFf0SkicBlWA17aEtVXUOtxvqHdooai3/5cEI38vivMHHe7a1AToW9qJY1GR8BcpYkYgpD+oq
 draqBV5yW9QYr3dcK3AAXsezYM48yawpWxigvs2U7hp6LhkxnMDoffytWSR6oanFEXl5jns5y
 oAKKyQKeDK75vdBZi9tz0LPiqAMsgJXzf8VADIZxqfPs8973USEYopHjtjv11na5zaW147OOl
 0As5gyX6sg53Nkn3D7Z7l+XZdwYZjgNOzk+d/EJxf/kNMn0uO1E0orsCuekEhL0Sx72NESSLk
 1t+yO7FETuLubGIvrv9Dwf2sNVUs5bVKiOZ5THjhvhxp1BXk6iIcKbxgwtFpitRmy2qq19ja6
 UpyxNDiH04hrSpDeGkRX2if8J6cLvGhccW/scd2jN2amo9hRLz/sR4qJxcN8DZ1zRKhu3EinP
 yXcqjFA3nH0J9fkekCtGY/Ok3JJgK7QeOdZPqcCcsig7SJ8rzSrUbhhjLvbMdeYzUvpbmv+aQ
 MPWz/abgiPp4nRBkQWIAj3gr4oVD5LdVBUEWH0wsM0q4nHlpecH4PGbZyQCk+E482L8alnUfi
 soW366m+QqCgL6xboDavHpPMxw9fgxpFS8Syoa0II=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

'the' has a tendency to double up; squash them back down.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191104185202.102504-1-dgilbert@redhat.com>
[lv: removed disas/libvixl/vixl/invalset.h change]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/interop/pr-helper.rst          | 2 +-
 docs/specs/ppc-spapr-hotplug.txt    | 2 +-
 docs/specs/ppc-xive.rst             | 2 +-
 docs/specs/tpm.txt                  | 2 +-
 include/hw/xen/interface/io/blkif.h | 2 +-
 scripts/dump-guest-memory.py        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
index 9f76d5bcf98f..e926f0a6c9cb 100644
--- a/docs/interop/pr-helper.rst
+++ b/docs/interop/pr-helper.rst
@@ -10,7 +10,7 @@ can delegate implementation of persistent reservations to an external
 restricting access to block devices to specific initiators in a shared
 storage setup.
 
-For a more detailed reference please refer the the SCSI Primary
+For a more detailed reference please refer to the SCSI Primary
 Commands standard, specifically the section on Reservations and the
 "PERSISTENT RESERVE IN" and "PERSISTENT RESERVE OUT" commands.
 
diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplug.txt
index cc7833108e12..859d52cce6c8 100644
--- a/docs/specs/ppc-spapr-hotplug.txt
+++ b/docs/specs/ppc-spapr-hotplug.txt
@@ -385,7 +385,7 @@ Each LMB list entry consists of the following elements:
   is used to retrieve the right associativity list to be used for this
   LMB.
 - A 32bit flags word. The bit at bit position 0x00000008 defines whether
-  the LMB is assigned to the the partition as of boot time.
+  the LMB is assigned to the partition as of boot time.
 
 ibm,dynamic-memory-v2
 
diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
index 148d57eb6ab2..83d43f658b90 100644
--- a/docs/specs/ppc-xive.rst
+++ b/docs/specs/ppc-xive.rst
@@ -163,7 +163,7 @@ Interrupt Priority Register (PIPR) is also updated using the IPB. This
 register represent the priority of the most favored pending
 notification.
 
-The PIPR is then compared to the the Current Processor Priority
+The PIPR is then compared to the Current Processor Priority
 Register (CPPR). If it is more favored (numerically less than), the
 CPU interrupt line is raised and the EO bit of the Notification Source
 Register (NSR) is updated to notify the presence of an exception for
diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 5d8c26b1adba..9c8cca042da8 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -89,7 +89,7 @@ TPM upon reboot. The PPI specification defines the operation requests and the
 actions the firmware has to take. The system administrator passes the operation
 request number to the firmware through an ACPI interface which writes this
 number to a memory location that the firmware knows. Upon reboot, the firmware
-finds the number and sends commands to the the TPM. The firmware writes the TPM
+finds the number and sends commands to the TPM. The firmware writes the TPM
 result code and the operation request number to a memory location that ACPI can
 read from and pass the result on to the administrator.
 
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 8b1be50ce81e..d07fa1e07822 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -341,7 +341,7 @@
  *      access (even when it should be read-only). If the frontend hits the
  *      maximum number of allowed persistently mapped grants, it can fallback
  *      to non persistent mode. This will cause a performance degradation,
- *      since the the backend driver will still try to map those grants
+ *      since the backend driver will still try to map those grants
  *      persistently. Since the persistent grants protocol is compatible with
  *      the previous protocol, a frontend driver can choose to work in
  *      persistent mode even when the backend doesn't support it.
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 2c587cbefc57..9371e4581308 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -170,7 +170,7 @@ class ELF(object):
         self.ehdr.e_phnum += 1
 
     def to_file(self, elf_file):
-        """Writes all ELF structures to the the passed file.
+        """Writes all ELF structures to the passed file.
 
         Structure:
         Ehdr
-- 
2.21.0


