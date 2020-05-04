Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F57FC47258
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089A82073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089A82073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZux-0002Mk-5v
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjq-00031X-I8; Mon, 04 May 2020 07:58:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjo-0001zs-RL; Mon, 04 May 2020 07:58:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUGRh-1jfIdL30tf-00RG4v; Mon, 04 May 2020 13:58:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] MAINTAINERS: Update Keith Busch's email address
Date: Mon,  4 May 2020 13:57:47 +0200
Message-Id: <20200504115758.283914-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Kw1W33UiramJN05FkDK+uqteuGHK9DNSy0wNvsi6LhGV1x1aGnK
 LUzQcOejjGsZP8hegmDlZtxy/WJHzFVeplRBnfiE+may1hT1i3TYmt0DKw8pDd790Upp4g0
 bagpdJbyQyUtgn5S3bbhZGIEaaqDQcJtg+A4gdbB+e9Z8ccpAu0J3xcpw2jPMRpx7l9i2+u
 LaVXz/fZoJj+ZcA6HV2lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6r08Tl0UI+g=:Le3/aX/SokAIznQ7lezQ2c
 GOdJTRwsZnAmcF9EGHEHa7vPmwImBhsgpBwSo0sY4n8xqtetbj0eZBV0i9RNrhHCp0C3twkHb
 fxJuAo28jyZLf7NEejuQoDyJ1W6RKdtD9kXXLmy2/Ru02EKxnfsOZ8wrWylzqT7sIs4dRTM+r
 HAXHiovfQvoiGV6RmG6vhxKtD4Qod2NtunWsLnrOsxflfx2TzX+MJGKH8dKzFA5dH9t2MZUA7
 YQfJjtWYBIeY1HiR3POJ9Q5I+XL9bJJYzCwoOFf/CM1qthCRNvg5wA8ikYBw5JaGwbKi6iF/s
 im/a+O7vaFI9/2Ctx9wRVH0Lw/Fb6OfBVlJcX3dwFWFMFPnvv+bxILY2s4J7ns/8m7R9Wcg80
 PouONWzD21nN2LKgLWLv0d51EnkgUTi6aMrc+5Rz+pHZA+ycbFax5ymM8BVk7KMryqNpJNb8r
 J5wuVsDthUt0oXlk27skkpn4wv3eB8w7kzGtMEpboM9X4GzzyTqZ0wIi7/xgjT8JJkgu+jAYg
 S8uq2M8XAx6yRP+GSbK/02+/PleHseG+CTjQDOSSwF4GF9BTpcG6fWWG/On8Lo6RuqBhDEjqS
 bbXKGdQpjigzps4QjwvsPlOmpiY50c48jAWJwW+NvhMMcWEq+o3lIQ4CfxEycCmj+FqxX43st
 whFid3Wd/WPFgyrmGmPgmo2+suxxtX3m20r4QP1oJfAlvzv2BfLlgdDtyrOtuY3HM4xJ4f5fb
 tG7jib9kg89fQY2cay/kmhLyQknrKOZsi3V20DWo+Jg2xjTQMAj13URMSm8OpxHdFWnpr90xz
 Y0YJ6iEWxnEwdXbqkBFV1JSH2imIBC052Gz0ddsa+bksEsQtNsmT9ZPk8msxoi0yP7AFqNc
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


