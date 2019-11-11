Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D16C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DCF2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DCF2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9eL-0003oL-IQ
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iU9dT-0003NS-2B
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iU9dS-0001V4-1w
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:21:38 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:32972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iU9dR-0001Bk-Qz
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:21:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 372463402;
 Mon, 11 Nov 2019 14:21:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8H5zqt7xxnsQ; Mon, 11 Nov 2019 14:21:33 +0100 (CET)
Received: from function (unknown [IPv6:2a01:cb19:979:800:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 11C393189;
 Mon, 11 Nov 2019 14:21:32 +0100 (CET)
Received: from samy by function with local (Exim 4.92.3)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iU9dM-0008HP-4q; Mon, 11 Nov 2019 14:21:32 +0100
Date: Mon, 11 Nov 2019 14:21:32 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: slirp: Remove myself as maintainer
Message-ID: <20191111132132.h6f32my3vudgcrfv@function>
References: <759f8f44-9a01-a9f1-c7cf-65d40151a93a@web.de>
 <CAJ+F1C+tRzRXzTWE1E7Uyvz1q_XU-6i_+utD461i-WbJ+wdR2w@mail.gmail.com>
 <0f57bc71-5a71-6cbf-0ee6-6a83af049959@siemens.com>
 <c32f8dfd-6004-869b-0efe-bbd85e91d047@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32f8dfd-6004-869b-0efe-bbd85e91d047@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth, le lun. 11 nov. 2019 14:15:36 +0100, a ecrit:
> On 11/11/2019 08.57, Jan Kiszka wrote:
> > May I point out that this one was never merged?
> > 
> > Sorry, I really can't help in this area anymore.
> 
> I'm planning to send a "qtest + misc" PULL request tomorrow ... I can
> add the patch there if Samuel does not have anything else pending
> related to SLIRP right now...

I don't have anything, please add it.

Sorry I didn't realize that I should do more than just ack-ing the
change.

Samuel

