Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87955C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CED206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CED206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD78f-0000Jp-AB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zM-0005V6-5C; Tue, 01 Sep 2020 10:10:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zH-0003np-4x; Tue, 01 Sep 2020 10:10:19 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MplPh-1kwe1l2Won-00q7Qu; Tue, 01 Sep 2020 16:10:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/44] Revert "mailmap: Update philmd email address"
Date: Tue,  1 Sep 2020 16:09:27 +0200
Message-Id: <20200901140954.889743-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ChtALlJkZgJpiF96Cn17CCN5tia8WPa0gmyMFO9vzh2KNErH/3p
 1MWld+uKMHrIzYVOqrquGvgScUiCphJcVEUEN1ed8XjHDNoYpteyKh3UTDeQFQhdX7HD8kJ
 O2u4eBI+JASfBmNnL+mWqflMsnSIuf7EB1pMDXo5WwKwORZpXFiGEeB067wnSmlFSUMwa0y
 IE3UEB9IBiMqrJsaGIjew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hyd1NQj9Bdk=:evSdRF+5+e+oaDyNbJ4FPJ
 z8dEhxaPiSPs8Bwb8llDbJzL7F5FseE9L2OMUKBvo8J/4rFA2d7uS73x3tO1MWgYaMr2Fxf/w
 aZAMUjbnj9I1P1hcnExjhfn3TZjkra0oHN7HHcV+REC7iOximSq52s9D52jnxTum62tZTp0U0
 /lnk/iJAT2E81i8guN8Wwirko+UIkMQkt2N4vAQEIpLqVb2THINDsR3K57/clT3wg3zBICR6c
 okk327mZD69DOUfsXGFMwuQbPmc5NMssVvkWStr5/Wyw5gomJxsAxR/gYVYWffoayELB7Wl+j
 BpynW1LRe2F1bDnF9XFcwOd+GlgJL+tPybwUO6GuujmYg18xysSQBPeh2TKzOaZR+J0DXmsNr
 golo44nfkUWZH9IvKwiaVwHk8UBgpBzIOkjEDraycfozj/J6PEuqw/ZQ4QtjO/HszIURq4Ahg
 inDIk4NVLcAkbFrLuPHNVtZ3qDxaZlcoWg4E4p0OfAxy0QMDbmPViA41W3Hvdr/vOIEc/V8Vz
 qoiObjCJf1CO+NkNylVUeviKcZr2XRw2DVK7eJoE5fTS5TOC3LQCli0Z+odzcJlFQi3YYXoXP
 bcK65h6dAVEl92kVmP07RYMX62uEJcYL0BFsqQD+UylhR4Cs6WAGqkh4IAX1C06UCOTgHrmqi
 FXQI4QIX/3s0psujJoX9lF0DWoxKMYaoJVWa2Xcn2wt/IVj9jtiQ6O13ROm+06MyRmbqIPCUO
 MofVTzX5Uhf+oTNErwuhBNyAZZku270+kelRhMD+Pw6ddEnqM3laKN0JH82WLbcCxlBX6VrnS
 Vh1u/ZbtyfAyLNzCiCf32Y83ymi5JXHcT2TBVm4Mb4kTEHCuW1ytMN3KNRW4Otie7HzAB0S
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This mailmap entry does not work as I expected. I am receiving
emails related to my hobbyist contributions in my work mailbox
and I get distracted :) Remove the entry to keep things separated.

This reverts commit 289371239153b24cb7bd96b6948c6b40b4627a9b.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200806135832.2319-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 81c2ce09370c..2d97a14af3c6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -54,7 +54,6 @@ Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
-Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
-- 
2.26.2


