Received: from eggs.gnu.org ([2001:4830:134:3::10]:60611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqGgO-0002EH-9h
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqGgL-0008QQ-2N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:43:16 -0400
Received: from mail-bl2nam02on0716.outbound.protection.outlook.com
	([2a01:111:f400:fe46::716]:8857
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqGgK-0008QC-TF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:43:12 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 11:43:10 +0000
Message-ID: <BN7PR08MB4868B337F36BDD9CE705B86EC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<153440739836.16762.17614063002249746532@502c9da6d61e>
In-Reply-To: <153440739836.16762.17614063002249746532@502c9da6d61e>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 00/87] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "aleksandar.markovic@rt-rk.com" <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: no-reply@patchew.org <no-reply@patchew.org>
> Sent: Thursday, August 16, 2018 10:16 AM
>
> Subject: Re: [Qemu-devel] [PATCH v8 00/87] Add nanoMIPS support to QEMU
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
more information:
>=20
> ...
>

We are aware of all these warnings. As Stefan explained earlier, they are a=
ll "false positives" for given circumstances, and we don't plan to fix any =
of the patches.

Yours,
Aleksandar=
