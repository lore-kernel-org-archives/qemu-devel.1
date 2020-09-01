Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE261C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94214206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94214206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD78E-0007lM-Mk
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zL-0005S8-81; Tue, 01 Sep 2020 10:10:19 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zH-0003nk-2p; Tue, 01 Sep 2020 10:10:18 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlwBf-1kv0OQ3GUt-00iypq; Tue, 01 Sep 2020 16:10:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 19/44] .mailmap: Update Paul Burton email address
Date: Tue,  1 Sep 2020 16:09:29 +0200
Message-Id: <20200901140954.889743-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g8Ho16oUxUbOqmfmigPDkiytVMUWXcCfrpPunxSV76MaDLvpp+S
 sRFosgigpHiyzxSd93VOHWobCOuk+WEI+hzz0HAzrEDVVUfi7js1r3OTXynH9/pt5c5fnV6
 a14TDsFfisVo6VhXBZoTxnBMtUjvceH+etwGQh6rXEuJzxSq+ojyX5NauXXFXrfBcNtbFLr
 4MnGH7J4Y7IrLm14zWuQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QNr4C/M9WYU=:ouBpm/ttmPOKg0yBmeS+Tg
 zmCzi5FZBWCoe5+sDhGurxz10RxViJHHJY0XI8Sg4kz2Je3xHZosuUwIVcQuJv7lnPizwXX+4
 C+QgreV8Izj6V9yLVkcfW+iDiVhOPMsUsKgLarHNq8vHP178EAfAjA8D2HrjBn+i4zH9E19IM
 wpLBf649Lxk1MWU+kEDnyO49gDUarrkOxSH3QUkRBvpqIypaC86MMKE+rErspg3lItefUdxDo
 jSwHabuB3u48zdo/kjAX+v/eGkJGiICqnFXjrgV0f+nmMUEf4utWOognOo5Gb5/5dw8WmjaB7
 lsdKIWS5cEuPQA7f+XRV01tIEEb+1tfj1Hdx5/JkwPhqWRgDTDXbyE13kFeYWvag2ZubN3r7o
 /kNU2LjmHblfTUCzHzRxjAN3bE/mYLp07oJQi5/QbqZR5o8a+nsSuRd93THyLobOuy8zIIX6p
 Ncp6zN9YBui9zE9sgW6Xv271kpevtev6IgkO03yO9liUbcsj0T56/NRhOFRrpZXKcB6+G7prP
 EsdNkwcLsCcoS2pNjeVFLiEXfRqs/hDGwQRn9ELjX7AzwOs2hfMPElXODmOJfnvB9kvV9kIgZ
 FBd+o/prOqsfDGsN6G0Rtf21yuZeJoaBHmSZZ1yfA9/fStJZxWJFhHZknbegUbAf8Lzfdtxi9
 RoUVnWDDsU8zAyRRi/u2Tkb8WCCIOa6dlr0TQru/8KZKmj0yXLQPnBYEyrQcXD7+wABDzdzs5
 CkC9ALrzkyr8LWv1cIcD2paReV+xgjaA87cjIv1pS7SOsElvBcBynxLAc44gxoQzJxgGtRtkT
 TO1holQX2nwSWVyEWmHyudjm7/xjM3uLiLh34cTxV35mSBpGr5S7xsJJxBzJ09c6FjAq8ji
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Following the Linux kernel equivalent patch posted on
linux-mips@vger.kernel.org [*], update Paul Burton email
address to avoid emails bouncing.

[*] 'MAINTAINERS: Use @kernel.org address for Paul Burton'
https://lore.kernel.org/patchwork/patch/1140341/

Cc: Paul Burton <paulburton@kernel.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Paul Burton <paulburton@kernel.org>
Message-Id: <20200707022544.24925-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2d97a14af3c6..4f40d1cc6e1b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -51,9 +51,10 @@ Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
-Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
+Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
-- 
2.26.2


