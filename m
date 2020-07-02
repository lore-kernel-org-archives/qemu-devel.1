Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0702C20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 22:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0702C20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr7jJ-000879-90
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 18:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1jr7iG-0007XB-DR; Thu, 02 Jul 2020 18:29:48 -0400
Received: from mail.csgraf.de ([188.138.100.120]:34402
 helo=zulu616.server4you.de) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1jr7iC-0001va-Sj; Thu, 02 Jul 2020 18:29:48 -0400
Received: from [100.92.200.170] (ip-109-40-3-10.web.vodafone.de [109.40.3.10])
 by csgraf.de (Postfix) with ESMTPSA id 598B33900153;
 Fri,  3 Jul 2020 00:29:35 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Alexander Graf <agraf@csgraf.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 01/19] .mailmap: Update Alexander Graf email address
Date: Fri, 3 Jul 2020 00:29:34 +0200
Message-Id: <42F63315-911C-437A-AC67-38CDFA8E6EFA@csgraf.de>
References: <20200702173818.14651-2-f4bug@amsat.org>
In-Reply-To: <20200702173818.14651-2-f4bug@amsat.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
X-Mailer: iPhone Mail (17F80)
Received-SPF: pass client-ip=188.138.100.120; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 18:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 02.07.2020 um 19:38 schrieb Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>:
>=20
> =EF=BB=BFUpdate Alexander Graf email address to avoid emails bouncing.
>=20
> Suggested-by: Alexander Graf <agraf@csgraf.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks a lot!

Reviewed-by: Alexander Graf <agraf@csgraf.de>

Alex

> ---
> .mailmap | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/.mailmap b/.mailmap
> index 926cac6bb8..e46e6c7302 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -44,6 +44,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <a=
leksandar.markovic@imgte
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.=
com>
> Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
> Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.=
com>
> +Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
> Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.c=
om>
> Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
> Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
> --=20
> 2.21.3
>=20

