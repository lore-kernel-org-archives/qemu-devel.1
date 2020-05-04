Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE3FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA22206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA22206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdYO-00043M-M8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVt-0001Ii-11; Mon, 04 May 2020 12:00:13 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVq-0005kd-W3; Mon, 04 May 2020 12:00:12 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXop2-1jdLB51vEy-00Y7KN; Mon, 04 May 2020 18:00:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/19] MAINTAINERS: Update Keith Busch's email address
Date: Mon,  4 May 2020 17:59:45 +0200
Message-Id: <20200504155956.380695-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QMHV9+K8XV5X/uJSLqhq68a1uasN6RUvj//hYo3bwz6NDc6/nYl
 Y5SAi4QBFrYQAePfwOzVSbcM+ZuzW44tKRxZsF7zSIHKBCNY9JWEv54VZlURR3sNei/x3vX
 BADCzOewrI1TJg8o616WfjfK/vnK7gr99+Pu7BOXfiAoUL5TGsWA342tvsUEd4ArAu9+6oi
 VLwsQC+U6/WAVWPLQbACw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mW6I6tShjs4=:6HTnuURBUNvVfv15FSIJvA
 r4BI57D7E6cs6eNZagoTZxz4Y7xsvXkGXB0Wej52bdSJLsF+o2Y0whG+fXGt/m5tSTqnH7GVq
 Blniib3QrvAa/S6bBZgUROcNbflZwmXaP/4XEYZqRV7bNiRmcivWkUeL0hVWic9rlbCSLimgs
 2+igdDD4uOuUlZniFMTZSkdf2WsGMj8yhxkBCQyf+MKWJJqQ7ZhdUm99NVO6TsQF9APZR/KQ6
 fOwUJIjZdMiU9NPYLfrAKyfF8we1YIqOzHMiPSJ53728N7pc2UxnSlYjPbA/i4SL8QWruJAox
 qoKJiVvvGHcHucQLeo7jME3DQ7xXQTAh+8WXJpb/POfJiF9deZmqnihY2rCyrdnzS/EjSjymc
 mRAyyujhNAU4z/J84IsTT+LZrNMD8rU2l76a9WM9lT1rIeH4EZFrUdrU9/Hga/cA8RbO9ftn8
 Ahq7K6JFCfjL/hknCGH73Pmt+FrLHpNPqkCQXeKd3CKZqvgedPd1MdBvyXpdJBmZ2YAWOpBGE
 fZ04iJVM8lkDiqN7YfjJw9K5mQH037nU8WlrpBP1cA3n6nfn3+fypmia7rdfvZoAGis4NQ2Vi
 jMNtSePrMXibYxTXbap5in/OtEs4uOrssvCcD6Pu74uncxzP8lnZ/pEiZ5ULcyfvhUKyiE2uK
 NiwoDHQSoOIArNEFmqQ8PUydhaviPBDDREVwOJO9JaPZVHH29AeIuZkL6jHRMtDDJIreDIAAL
 dqA/m1q76BTl/vBJ6sQcqxnwuPLoDHHbTudg7QxSjUFODhATNqPsvleX4bAMgW+WXG4gpMtJ0
 9qqBW7rEr3xh/pBeRtRQZ/RvENVtLL08otoSEtlZRCrnjyiPsIMoOghPWmY5DlRTvtA3eix
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

keith.busch@intel.com address is being rejected.
Replace by the email address Keith is actively using.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200421122236.24867-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6886be13159..1f84e3ae2c6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1735,7 +1735,7 @@ F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
 nvme
-M: Keith Busch <keith.busch@intel.com>
+M: Keith Busch <kbusch@kernel.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
-- 
2.26.2


