Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB6C17498
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075E0217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075E0217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS07Z-00049E-JJ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS03L-0008R5-Vk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS03K-0002is-AU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:43:27 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:45885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS03E-0002fB-3X; Tue, 05 Nov 2019 09:43:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjPYI-1i4EoB2dju-00kyqs; Tue, 05 Nov 2019 15:43:01 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] global: Squash 'the the'
Date: Tue,  5 Nov 2019 15:42:47 +0100
Message-Id: <20191105144247.10301-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105144247.10301-1-laurent@vivier.eu>
References: <20191105144247.10301-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JNoxt4H34KkBSPuWmF9GErgKUZwyQv3Mxe+T2CTt6aHlA2A5yRR
 3E+liXgMDMhesz7bdii/u3mcbwIwTGlzMxclNKuIeSI+Ti/9qyNoUwv7wioMYkVOEoFcOfw
 V50zys+VtgQCtYTjEhZhAIZ9bXG+lxXncNV5qyt11sWNjC7i9v/ePmItrO3v0a+8tgwzJOx
 A/7AjMdEAcs+vG7ryklHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xfx0CyW1lWU=:dIquTygg+lDDE2ngKnWlqC
 CixfxkPGwz3v9iDyscyMwcEo5z/peQAFvuaEJsEIR8T5tLoq3FlR/sWqnncXn0lBmBYnCyM4K
 5mc/JK4O7wNXh6A5T6Ko53e2vHiaSdeHhnOXFDs4zgYRdKd14Yq6Mr8NzlwPpFVlNwaHXosnF
 dSqkL6LPusb9GlFrqyOlcOEQtPIp75XDTTaFy4Vhl7oTsjNgxYDTFLhgrGUhJK6nkQqQj0S4P
 6lzCHZOKM+8Zm9niyqL335Xbc+gRgtZ2NIycOxEs/3icCrOImAShbM799FuMp9hqUSaijj4lU
 k9iF4sCpPDQFWOJk6tWlz/qJVvfjAvR+cnXW5HrcD6+e88GM8+yMI3ADdeb3DmEnS+gcfuxTG
 TGj5EHYFpAleIMrOoMDeIrG3QuIXWtiq/7KQPrn6Z+e5H2CTQkU3R2yaSuaYbY/bAKqv/+cof
 BW2tzRhvFu5k7vD9BS/JuTC+PtFFg1e6/nbiRywH+9LwEsLYvICWJCFqTyYDkVVNa35v7b3hD
 WakILpLSVOYOt3Usa/QaVv4TqwWiJi6AGdFBMMDVd+HKAtHiNDflmaFRUUgn16K4g0Bc9n88v
 pr+5D+o3QTr8+0/PctrR6mkR3EsoTPNsZModvCRfWAU3cAEqDWfExnb1+f3WPSn6UCDiX67ny
 5wt/Fq4yMMYLYvdxKCpLm9qSJrYWjv3l214xEuH/jCHE0xcJngoBIJ8xmsI+zUSAUUTN/Wgno
 brVGdTH1x19OyRGq+1iH2AHsQzsXSdG6caSBdHd/R3icCEpvl5OLXThpCKsG06X00NJtWFgGQ
 crSP4WXP6VxJW+/e+59I+bxgVeorXM4FJRa8L95yVaCFVUHnb0IL8p0p4KeDuOoQivHG/1bRl
 dTGRrI+pqpnXTYf+kdEXsuPFJWTffENDL14Tpm1aA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
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
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 disas/libvixl/vixl/invalset.h       | 2 +-
 docs/interop/pr-helper.rst          | 2 +-
 docs/specs/ppc-spapr-hotplug.txt    | 2 +-
 docs/specs/ppc-xive.rst             | 2 +-
 docs/specs/tpm.txt                  | 2 +-
 include/hw/xen/interface/io/blkif.h | 2 +-
 scripts/dump-guest-memory.py        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/disas/libvixl/vixl/invalset.h b/disas/libvixl/vixl/invalset.h
index ffdc0237b47c..ef5e49d6feb2 100644
--- a/disas/libvixl/vixl/invalset.h
+++ b/disas/libvixl/vixl/invalset.h
@@ -102,7 +102,7 @@ template<TEMPLATE_INVALSET_P_DECL> class InvalSet {
   size_t size() const;
 
   // Returns true if no elements are stored in the set.
-  // Note that this does not mean the the backing storage is empty: it can still
+  // Note that this does not mean the backing storage is empty: it can still
   // contain invalid elements.
   bool empty() const;
 
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


