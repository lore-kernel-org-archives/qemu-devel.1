Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74283C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B42206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B42206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0YQ-0004mW-C0
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Um-0007fp-HN; Wed, 10 Jun 2020 09:10:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41555)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ul-0003YD-F5; Wed, 10 Jun 2020 09:10:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhDEo-1jEbLx1VsA-00eLLE; Wed, 10 Jun 2020 15:10:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/16] .mailmap: Update Fred Konrad email address
Date: Wed, 10 Jun 2020 15:09:58 +0200
Message-Id: <20200610131011.1941209-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aTIGPe841mZtN90PlWEZkR07pjm50oT/zey3EVHP5vYBhRPOEsU
 B5Jb7F6qliljDSDhaaCXMBUcZMiMDjdmqHa2seQrEe5eBJ6y2yAmz51c8cmx/+61ENbptGb
 t7AIgQRU97Fc8bWiJhqMcyufBWMFDgznqLNMweB76I2z3ONTynrNNu+TyWDsfKkmL9mGQ0Y
 bLEg1pJDUbvuDyFSptfng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GqaU1epEMdM=:W4SbNrzNS8DoGB5kvXPcy1
 M/Kx5eQNcOaGLj4AlaLj+xJtxTOB1H2OIfhuzMrf6dakWPjNvhpjs9p1D7Y6/FyRV2Ju/B570
 PAqjpY56TyL/ksscj9E2Ynfig4K2zUx/fVqB+Rj6HPM2rAlyJztMlZWOtH8jUgJPk0uXoUliW
 JoXG72+aeh1vjUz8Gln//gQr1piZx3dM5uQAJ0Io9SNN5Geax9+5JlHt6NFMUd73HjhmsYtAd
 KwAbrUnUKLLmqfiqgh2frlXYCmhZpNDAPFuf0xl5xGApZOB2Hfl41cfK+Cchl9oG3icmrQ2dU
 oUBe0cJpdcjeOoUi6DAyJOLYLzeG4blKYTxh1Nav9sspN96Kb8pGzzDeaJ3y77qH8rlSmBMA3
 BL5MPVAJSq8fCvBI6HBZd2hrYXuFPJxh+gft7xSUzJl534890pLsUuCAnmMLAuFiDXNPEkx7/
 TJG0M0sql4qCdtD27xEFudtAVn66SlXeQ0U/sNu9CMMYNN+uqcufJr/bfO79daoKEqHSz+Mf9
 dqApPYdwRklI4ZeE0pKBlbZvXNrDmDmAhqERiDSTAKSwgXiBgDcuGCaXShvp8ghiR3xtnMj7v
 j6QYLkRgZs60hZBisrlVQ2F99MdBa2WqZdHXt1ZPvevJwL9qjzUGlVs7pCDfK20g615yycnY4
 +c96n4Cua451/DfgRutEdvKZg1BkTUnPpxyDdpTE+MVLEF7AqAwKxd06ncpIhbjurnBQvD3xM
 RXdIyhsi/n3ugI0kKZNu7NCeGK6VK2sTJ19URvDFAU5jaiLAYJqcva/mxB1xyZA9RHqrUG7fZ
 //Fx0dQWRFyaPAuD1E4T6c7XKsPxDzWUkxhfeJVu0LqVdbb9l9TS0W0pP+3hvhxnBTGFcSn
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Update Fred Konrad email address to avoid emails bouncing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200518103920.10699-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e3628c7a6613..d6bd1b2fec02 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-- 
2.26.2


