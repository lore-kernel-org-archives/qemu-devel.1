Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 11:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B146A2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 11:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146A2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYtP-0008TL-U9
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 06:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iZYsI-0007Ux-0k
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iZYsF-0006Vy-30
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:19:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:41067)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iZYsD-0006Px-Bv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:19:15 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id F18837456FE;
 Tue, 26 Nov 2019 12:19:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D2C407456CD; Tue, 26 Nov 2019 12:19:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D160E7456F8;
 Tue, 26 Nov 2019 12:19:03 +0100 (CET)
Date: Tue, 26 Nov 2019 12:19:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [EXTERNAL]Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership
 for Fulong 2E board
In-Reply-To: <c6779bb7-7353-7c4a-e458-b0d60ca662de@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.1911261210130.87139@zero.eik.bme.hu>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
 <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CABDp7VoVpZsQpDc7U4uJ1B7ZVCc8A2KO5qNaOucHQH6xUdX8tQ@mail.gmail.com>
 <4a94a570-301b-e2db-6090-929e63f907cd@redhat.com>
 <c6779bb7-7353-7c4a-e458-b0d60ca662de@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1326382013-1574767143=:87139"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: chen huacai <zltjiangshi@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1326382013-1574767143=:87139
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Zoltan,
>
> On 11/14/19 2:50 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> ---
>>>>>=20
>>>>> But let's wait to see what Huacai Chen thinks of it, before posting=
 it.
>>=20
>> Aleksandar, can you stay as co-maintainer?
>>=20
>> The patch would be:
>>=20
>> -- 8< --
>>  =C2=A0=C2=A0 Fulong 2E
>> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>  =C2=A0M: Aleksandar Markovic <amarkovic@wavecomp.com>
>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>
> You are a prolific contributor of the Fuloong, are you OK to be listed =
as=20
> reviewer in this section?

Aleksandar M. has already asked me but no thanks. I've only contributed t=
o=20
Fulong 2E because it happens to use the same or similar components that=20
I'm interested in for PPC machines emulation (VIA superio for Pegasos2 an=
d=20
ati-vga) and it was a good way to cross check these with something else=20
but otherwise I don't use the MIPS boards.

Regards,
BALATON Zoltan
--3866299591-1326382013-1574767143=:87139--

