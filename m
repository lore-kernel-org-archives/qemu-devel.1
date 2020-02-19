Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83233C3404D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568CB24658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568CB24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MRf-00061a-EI
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPV-0003HJ-6q
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPS-0004ow-ES
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:52 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:48843)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPS-0004nj-4N; Wed, 19 Feb 2020 05:16:50 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MX0Xf-1ixb8x3bzt-00XLSA; Wed, 19 Feb 2020 11:16:31 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] hw/m68k/next-cube: Remove superfluous semicolon
Date: Wed, 19 Feb 2020 11:16:01 +0100
Message-Id: <20200219101612.1033925-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YwU/YVllBHraEo0Cl8lzUR9IjE0X30kvnGnRfWTuXIFMN2jYT7O
 XrRa4UbDum2mg5AgM704YkBwjUL7jVd7UXk5rBz3BWJQlaFpZ5EwIQs4N5qr0d106HQtpUn
 LMkn+IN+eRdJBgxUOeW/jBH8U0FjMbuD4qT46mC46Zuhzi3qBYJnrdIIhuJSj+mo23nW7Ue
 CGcxfihqg5LiTzw7PX/hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GditWF4XCtQ=:lufd1/0JL3gK9oH6/mi4XW
 n/nIxxMlhQP6oUwHoFT6KhXpVzEZMd5hV52T6YO1hd2mVuJ3JkCuSlB5V/wzj5TUtF5Ar3EB9
 8ma888wx0hkbC0SlRC5n4Z1N8TUMVlWzS+2t3YrA/6Ggj0EO8rSU06xzfZBEgFO+/rqWKR7PO
 qpVudWx/PItAVnk1z9PtdzTMa9VmQOzTFdHYOt1f7Aif/fvE2qMYcExF1l30SxVW2YK4YZhv/
 dM+X0jCtT6MdWKA3Ci5IqfK4Eq3Fu2e2H4fobysDmYf8ImaFG083KETrNurgRavkpetbxmk32
 bwB0glkkvx7H7Y/gK74mLVD+id31/3iaZ//caUCUqYFBu4AmOeEv/Unv2FnEQ5VD7K9ymNVVM
 /TUB5UAahLSujwjnoVkobFyc0GjmwVYOy0KogqW03zBGIskT9NOWVibdUkSkQUzvVFyhjFvyg
 nr3DC6IkcSwAUkXwsHq3RAWvCm77nsF5ljN66IJ5nkwPvtbynn3VX5KJ2RLRZUvxKlpRNGCiU
 aAxSOzXwl9BxkCNDCDApct6iLN+uAO20P3Nci6zLZAeVvhiAASzJ/rkdQxAEUxmX/a0Ak8SHw
 4jcYWo9y7wzMAmK9XC7ukOBL+vp1g9bn9Kmr8hwRS0ORCipP5zof05FWG2IBq8TRcYF5Tq6Ap
 gii4VdzQbsoqV8aKCqz0lnECnDk6/2z66JuvQAJs/oL9AUi/37vvUSD8ohIL/sdTb7951YDTW
 XXJncEPhNolYEP8CK7Q0hEK5ECPmOfSFs5k5Iu63+/My8V+XH+cEhYw80q2E+/Ukpdzkk72n0
 yTVwzDHyU4C8zUK+aWJiw1GGH5IabmOLn7xOq2oP7Mu/SuNynbsPNVV1GKmYa/4fc7jns3I
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fixes: 956a78118bf
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20200218094402.26625-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/next-cube.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e5343348d076..350c6fec78f9 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -734,7 +734,7 @@ void next_irq(void *opaque, int number, int level)
     switch (number) {
     /* level 3 - floppy, kbd/mouse, power, ether rx/tx, scsi, clock */
     case NEXT_FD_I:
-        shift = 7;;
+        shift = 7;
         break;
     case NEXT_KBD_I:
         shift = 3;
-- 
2.24.1


