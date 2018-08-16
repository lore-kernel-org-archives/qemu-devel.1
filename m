Received: from eggs.gnu.org ([2001:4830:134:3::10]:35834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLUX-0004ep-O5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLUN-0004ps-KR
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:51:19 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com
	([104.47.38.106]:47137
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqLUK-0004l5-KP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:51:09 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 16:51:05 +0000
Message-ID: <BN7PR08MB48683EC8A6E02576FD94965FC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-16-git-send-email-aleksandar.markovic@rt-rk.com>,
	<08f5df8c-418d-648f-d133-883c2729e178@linaro.org>
In-Reply-To: <08f5df8c-418d-648f-d133-883c2729e178@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 15/84] qemu-doc: Amend MIPS-related items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, August 16, 2018 5:58 PM
>=20
> Subject: Re: [PATCH v9 15/84] qemu-doc: Amend MIPS-related items
>=20
> On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> > +@command{qemu-mips64} executes 64-bit big endian MIPS binaries (MIPS O=
64 ABI).
> > +
> > +@command{qemu-mips64el} executes 64-bit little endian MIPS binaries (M=
IPS O64 ABI).
>=20
> These use N64.  We don't have an O64 configuration.
>=20
>=20
> r~

An honest mistake. Will be fixed.

Thanks,
Aleksandar
