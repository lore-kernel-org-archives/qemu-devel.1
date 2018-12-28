Received: from eggs.gnu.org ([208.118.235.92]:35505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcw06-0005ro-VA
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcvzz-0000dU-S2
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:32:46 -0500
Received: from mail-eopbgr800137.outbound.protection.outlook.com
	([40.107.80.137]:2697
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcvzz-0000bG-IS
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:32:39 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 28 Dec 2018 17:32:33 +0000
Message-ID: <BN6PR2201MB1251659DC25FE3A8741F50ECC6B70@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
	<CAL1e-=hfFv1TsG_viYi6-0z0qN8GnTP-70ZLMrDMmLVz9iBWQA@mail.gmail.com>
	<87imzpa4gx.fsf@linaro.org>
	<CAL1e-=hyKFR=9PHSnNdqFd=XFo2PoQK7qVrtM9GNM3V47V=2Mg@mail.gmail.com>,
	<878t0aq728.fsf@linaro.org>
In-Reply-To: <878t0aq728.fsf@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 04/13] tests/tcg/mips: enable
 mips32-dsp/mips32-dspr2/mipsr5900 linux-user (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "shorne@gmail.com" <shorne@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "michael@walle.cc" <michael@walle.cc>, Stefan Markovic <smarkovic@wavecomp.com>

> Will you be testing the build as is with the current Makefiles?

I will, but they should be replaced with your versions - in new directories=
.

v1 of my reorganization series seems to be broken on the list for some reas=
on, but I will send v2 (hopefully more complete and improved) after New Yea=
r.

Thanks!!
Happy holidays!

Aleksandar
