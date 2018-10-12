Received: from eggs.gnu.org ([2001:4830:134:3::10]:38288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxat-0000hn-44
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxar-0000B4-QB
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:35:07 -0400
Received: from mail-bn3nam04on070f.outbound.protection.outlook.com
	([2a01:111:f400:fe4e::70f]:31555
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAxap-0008RR-Pu
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:35:05 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 13:34:57 +0000
Message-ID: <BN6PR2201MB1251096796D406C99691C752C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539256947-22807-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-16-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 15/22] target/mips: Fix emulation of
 microMIPS R6 SELEQZ.<D|S> SELNEZ.<D|S>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>

> From: Matthew Fortune <matthew.fortune@mips.com>
>=20
> Fix emulation of microMIPS R6 SELEQZ.<D|S> SELNEZ.<D|S> instructions.
> Their handling was permuted.

"<SELEQZ|SELNEZ>.<D|S>" can be used in the title and commit message..

Other than this:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
