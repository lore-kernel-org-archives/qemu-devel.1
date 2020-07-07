Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD4BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046DE206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046DE206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslEc-0002wj-9b
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDn-0001Lo-Sl; Tue, 07 Jul 2020 06:53:07 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDl-0000MN-UM; Tue, 07 Jul 2020 06:53:07 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5wc7-1k0BD409Sl-007Rlp; Tue, 07 Jul 2020 12:53:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] MAINTAINERS: Update Radoslaw Biernacki email address
Date: Tue,  7 Jul 2020 12:52:52 +0200
Message-Id: <20200707105255.362318-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vZbkaxH1Amsgd4zzOOBctgrcih18cdhnf/9ybe0jkkVlgJIOuxx
 NQPKq1/ij/fP5L2nKtm6MWk5Ana5+Sey+tDH2J0iztngluPOSUQElZZZd4483pMrVMiaF1L
 nPIoG3P31JAo6GcNRzYx63lWd8hZI8+4A9TwyHntIbNzN/b1H0VlPypCjSYeH41+OQS8uPL
 qjKBpSOSPVmiN2LMX9ZzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V7BRua9kco8=:JwZ77jTd69fVUTwJbsT+bp
 gyxaDAnZftWlXrMKViUmNHlxdkPj0DVW17Tw/DrbZ70a+5twNPuzvNQZumv/Uh1cBg+xnjVPv
 HU7+U8bWd2yxoGyb78xPJmGp2zpXKlzLZoELDKj/B0yuuqyU0EvBCC4gvtZpSp4eMeNxqTtGi
 Nm4mGp6wsR55tozI8d9BoJuRYvHdJvz7+RQvw8fAdMq0MrImg5Lnt1uIDpK2CM6LkF+AiLeKr
 wnrYJfLfSfpJO/OJ5W36HrH+d9bbiFvYAv0bxavJ7q4rVFdiFTxGcJEkI8UY58PUJze1YnPYh
 7Feb2bRdDRkugjc1X/Nl3IekTY2GaF5olMwnaJy1HfYgo2wrAl5xvm+3zk1wW6Q8HBsWrM0F0
 8sKNBzPGdKWowXNxJV1aBdFYEMN0H7OL9FsX8fh1RTNYGgBR93o7h8CwnhbZEknWwVLtN+2bu
 2DdVbf9Ufy+MKqHf1VWAY4veF6U1LW+Bnp+syrPUq1XC28JW7BlDsxEts26pTyWNXqPR5arna
 gLOrC3tEqmhEp7458ImSO//c9Zg9Rv4HojTn6AodKPuntowg8o640g7b0gKJbYFcL0EJ7z4dG
 JJ83URe/FQA70HMZjLRVEnlxg3Qq8Q6QeTnnXV1lHUDGiaFZWtnl5DZnA34SJ6Lvdvnsf2TPw
 fWwv8imQJ4YJ/a1ws0KJxn4ohEvbRVc3w4qozHFRn5E+o9acaklltzhNGlJmYH1VzQ2IPqK0l
 eKaA7Hf4NQIWrrBavADTnpqYtu8MllWlu9ybojOOtT8Yc76jGyvmultfC+TkRzSk016m6qNJW
 2tDNOyPnvpk2Y4oJM1MP6q49pqG52iHFrPyOwNZuOnEjsM8rfK4Xp+rpQHjoFsRn6E9Keur
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:53:04
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
Cc: qemu-trivial@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Radoslaw Biernacki <rad@semihalf.com>

My Linaro account is no longer active and stop forwarding emails to me.
Changing it to my current employer domain.

Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Leif Lindholm <leif@nuviainc.com>
Message-Id: <20200512170704.9290-1-rad@semihalf.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index e46e6c73023c..81c2ce09370c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -50,6 +50,7 @@ Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
+Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index c31c878c635c..36dce13bcc32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -809,7 +809,7 @@ F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
 
 SBSA-REF
-M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
+M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif@nuviainc.com>
 L: qemu-arm@nongnu.org
-- 
2.26.2


