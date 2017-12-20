Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy3-0004JB-5Y
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy2-000723-7m
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:43 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy2-00071V-1I
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:42 -0500
Received: by mail-wr0-x243.google.com with SMTP id q9so22924988wre.7
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:19 +0100
Message-Id: <1513790098-9815-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/46] MAITAINERS: List Fam Zheng as reviewer
 for SCSI patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Just so that I notice those patches more easily.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20171205072220.885-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8859a50..73a5555 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1011,6 +1011,7 @@ T: git git://github.com/jasowang/qemu.git net
 
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
+R: Fam Zheng <famz@redhat.com>
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
@@ -1271,6 +1272,7 @@ T: git git://github.com/stefanha/qemu.git block
 
 Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
+R: Fam Zheng <famz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: include/scsi/*
-- 
1.8.3.1
