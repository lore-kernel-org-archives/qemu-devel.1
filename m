Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BCEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369A72074B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369A72074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIl9t-0008Fd-0Y
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 00:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIl6O-000391-Qq; Thu, 17 Sep 2020 00:00:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33754 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIl6M-0001E9-0H; Thu, 17 Sep 2020 00:00:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0907B3AAB3DBC4F0EB91;
 Thu, 17 Sep 2020 11:57:10 +0800 (CST)
Received: from localhost (10.174.187.87) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:56:59 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 10/10] contrib/: fix some comment spelling errors
Date: Thu, 17 Sep 2020 11:54:13 +0800
Message-ID: <20200917035413.701-11-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200917035413.701-1-zhaolichang@huawei.com>
References: <20200917035413.701-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.87]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:20:51
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the contrib folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/filetypes.txt             | 6 +++---
 contrib/ivshmem-client/ivshmem-client.h | 2 +-
 contrib/libvhost-user/libvhost-user.c   | 4 ++--
 contrib/libvhost-user/libvhost-user.h   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 9e9c505205..d2d6f6db8d 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -22,7 +22,7 @@
 # in the gitdm sample-config directory.
 #
 # This file contains associations parameters regarding filetypes
-# (documentation, develompent, multimedia, images...)
+# (documentation, development, multimedia, images...)
 #
 # format:
 # filetype <type> <regex> [<comment>]
@@ -59,8 +59,8 @@ filetype code \.s$	# Assembly
 filetype code \.S$	# Assembly
 filetype code \.asm$	# Assembly
 filetype code \.awk$	# awk
-filetype code ^common$  # script fragements
-filetype code ^common.*$  # script fragements
+filetype code ^common$  # script fragments
+filetype code ^common.*$  # script fragments
 filetype code (qom|qmp)-\w+$  # python script fragments
 
 #
diff --git a/contrib/ivshmem-client/ivshmem-client.h b/contrib/ivshmem-client/ivshmem-client.h
index fe3cc4a03d..fc45a38060 100644
--- a/contrib/ivshmem-client/ivshmem-client.h
+++ b/contrib/ivshmem-client/ivshmem-client.h
@@ -174,7 +174,7 @@ int ivshmem_client_notify_all_vects(const IvshmemClient *client,
                                     const IvshmemClientPeer *peer);
 
 /**
- * Broadcat a notification to all vectors of all peers
+ * Broadcast a notification to all vectors of all peers
  *
  * @client: The ivshmem client
  *
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 53f16bdf08..9d30ff2283 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -684,7 +684,7 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
 
     /*
      * If we are in postcopy mode and we receive a u64 payload with a 0 value
-     * we know all the postcopy client bases have been recieved, and we
+     * we know all the postcopy client bases have been received, and we
      * should start generating faults.
      */
     if (track_ramblocks &&
@@ -973,7 +973,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     for (i = 0; i < dev->max_queues; i++) {
         if (dev->vq[i].vring.desc) {
             if (map_ring(dev, &dev->vq[i])) {
-                vu_panic(dev, "remaping queue %d during setmemtable", i);
+                vu_panic(dev, "remapping queue %d during setmemtable", i);
             }
         }
     }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 844c37c648..287ac5fec7 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -424,7 +424,7 @@ typedef struct VuVirtqElement {
  * @remove_watch: a remove_watch callback
  * @iface: a VuDevIface structure with vhost-user device callbacks
  *
- * Intializes a VuDev vhost-user context.
+ * Initializes a VuDev vhost-user context.
  *
  * Returns: true on success, false on failure.
  **/
-- 
2.26.2.windows.1


