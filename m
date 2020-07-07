Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA38206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA38206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslHD-0008SN-LZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDm-0001JD-Es; Tue, 07 Jul 2020 06:53:06 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDk-0000M8-HO; Tue, 07 Jul 2020 06:53:06 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWRi7-1kQXnb11xr-00Xwqn; Tue, 07 Jul 2020 12:53:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] .mailmap: Update Alexander Graf email address
Date: Tue,  7 Jul 2020 12:52:51 +0200
Message-Id: <20200707105255.362318-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6sr87K2zwywnyZ7bEshsu72nG44Imnr6WEbFT/Ke/GUhx7O260V
 AMukuFUMDakA4MIP5Zhli7dU4Ct/pUDwPkuqO6B3HEJvPDPNfO/4vym1P1zclKRYFWurS1S
 mB7U0wVPEi0fNjlP5zuJMnZ5LyC5CnuDP9sdGYhFG6CA59IbAjobTyzkuTrovZdNmp3OEGo
 6VVa6jR6wiQUHXeQPwYtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NxMsdwc0EfY=:nmp69OHLFgQcTIPIghzUhp
 ymcm3MJ1r0aBhKKw8+Jd5CYD2/XwY90AEFArH8pzmMayTbDjTypi0spGczmHTEdSri5xQOTnw
 du8dlmHihdIFJnqglLuwV6QT0xoFmlfBODkxu5nG9RVM8iHj/JP3zDKPws4kXIwdF0LqUJsQO
 5maKBgYNbaCma9wREObWjuGpyJknZLGcyqXkskUot7oY+hQ1oB+fzoUNOZ4zTPlXuIjLZz2fu
 PIjCQJkklMr8AH11Bt/wsEYH0GqhXt+DuxzOfXgqDfnPYANxtmmwgRt0AM9hu4TbCVOek5l7L
 fI8B9r5I6XWI7zgq1cZv8Nf6lYiu06KrBfKmQYMswZECJwu9c3h1YkFmzejj7TE9E9sgSTVXB
 /6NIzuIh5kPM0Aw5TkVKh3e9k0eAfGNOLgwKHAkC8v2l7jypomjL2DCki19/peczZpJK5H/LF
 kyPPm0dGkBBKTs1d432uwGLTBABvpthH65Kqjv4PFy4rnPYtmcqBKhf8juBi8lfCvjVTqLzHq
 Y4nGjBVQiAovwjtBpO1PiGbjBhvggJxdy2NhYxE38SARUppPg/h0VAkoRpirl+pYkVDCDqkqt
 MoFajQEePfmHglA0C17eVA9wAD9E510LukbxMzQOQq3VBkxPdnT4k0yP3dpaRVcygL3LRnA52
 Xr7oqn5+O9v71CVPVHp8bC1Xx1Zat0bw0HEgGF1k4DYyEEr1v1qsHSobMKVb6xgILdkT8FWDs
 KTeCeHDoBjzx7sVbgk7QnlD/A6R48UepM3xfeRBlQsz5B9fFIYL4Jn68StZgb4XAAgbAib6eP
 5YQhS7PwLWhZ1aMZlkB5cK5qsvHrSxtvc3BGDRW6jAjWwP25Y1Y+Oaj2zTfEJrZbplaWyPB
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:53:03
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
Cc: qemu-trivial@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Update Alexander Graf email address to avoid emails bouncing.

Suggested-by: Alexander Graf <agraf@csgraf.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alexander Graf <agraf@csgraf.de>
Message-Id: <20200702173818.14651-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 926cac6bb8b2..e46e6c73023c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -44,6 +44,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgte
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
+Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
-- 
2.26.2


