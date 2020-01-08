Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF452C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E8020720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E8020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDpm-0000QW-9B
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ipDnH-0005e2-Tg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ipDnG-0001q7-QQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:02:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:56181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ipDnC-0001l3-9a; Wed, 08 Jan 2020 11:02:46 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuDHR-1jgcim0EdZ-00uddu; Wed, 08 Jan 2020 17:02:37 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] MAINTAINERS: Update Yuval Shaia's email address
Date: Wed,  8 Jan 2020 17:02:29 +0100
Message-Id: <20200108160233.991134-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108160233.991134-1-laurent@vivier.eu>
References: <20200108160233.991134-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:etpxR2CQD/P8Mx74yZqxCD10NlNlT1WxkMSCMaddz7551USEPww
 JdezFtWmzZj7ETLfTm8o7qVnCFImN4PnMpPFSxqsz11/AN8GkGKQwFbYG42Mp3PafEDluI5
 Z4Co8PtSG1JA6264e9ZeYjYwd7NwDRj66+g0P7n2J0S+3gyEfU9TgdNEYVq79+DKrY+bWTn
 rCS6ARUf+jxjsw5Ku5aKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:spc/qM3I/Cw=:DF/no3hmC0l74czZf9S96B
 aRY7ZFUhvkSprunFk356cmbXDclEOjkdkTBekbdQcH4I4GBGDKHNcTNkFVqhvnh813xtLpn0G
 hvANNHFalnIOFjPGomGhVJ0fY4WCC/6MdRWwTzQxIOQ39niJ2vlPAPCtAQAHyu90Hq+6klNK4
 BNpKXlcuiS3HY29WAKmtaaQgUsHk/lDYLCGoVJpdgAw3/Xg3bj85sDcwEOO8x73VWKXPSU7SI
 zgCUCc8s9UUOQu/RgkQuM0F6Nfmw8L2bpciyUGzJRiAH1N82gUP+XT7FqDHFrZQtJdrqCqI4X
 6lnU1bQl28er20h836YWjmh3FbPNS1K4ALaDA3TzWml8km6mNln5HGa7pNbM9jobnmjAemuaD
 4nxHHqpVMxLmQd9w/N/h812oyodORg+GBDPEKKejeuYZJ0m94/QzLKGScOmPtrHoXdbVG6POa
 PiATL2ogNnx4Y+L3BBUO0yebNjBLOsZpXX4QH+/+Gp1MbxK2QHmVBTRvUU9By4Ki1eHCF9CfT
 NjbNGwLPPtT6iWcvamcaJ3X/3StqaPbBBIFSWleUSZk6abLjoM4S4SrgB2JMeSNaR3gt0lGhy
 XGeLqTiuuTbIJauVKkVxLKnUdbeGsrWerBSv8SKXWv7vOSadYnBzhg+H3xKC4H3hMcGqooabH
 ObAKKouRnuG5aaWdicwaBjipsU3IPz/hfyKJes57b64/aY1t8qYtc+twfc1QJQcA2L0RZV20L
 2S4+koinZLYbycTph3xtEohGIaoe+7Yep3uZhUqLzdAj83232Pb1R62wTUv1Rg/nuUm5xKI6D
 UuLpgzdzIUOgaseQX43iAo8zR3rFRkNQ1RC9Zlk2P7AW0YLwo+EsCPgzeldlynOdXJghrusdm
 Oxs3Ozn3lKFiy6VclLYw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Yuval Shaia <yuval.shaia@oracle.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuval Shaia <yuval.shaia@oracle.com>

Use gmail account for maintainer tasks.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Acked-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20191126102637.2038-1-yuval.shaia@oracle.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd2dc137a3a9..df0893cd4cfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2659,7 +2659,7 @@ F: tests/test-replication.c
 F: docs/block-replication.txt
 
 PVRDMA
-M: Yuval Shaia <yuval.shaia@oracle.com>
+M: Yuval Shaia <yuval.shaia.ml@gmail.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Maintained
 F: hw/rdma/*
-- 
2.24.1


