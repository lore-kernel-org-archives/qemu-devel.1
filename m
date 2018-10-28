Received: from eggs.gnu.org ([2001:4830:134:3::10]:49075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGp22-00064Q-Fr
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 13:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGp1k-0005t4-Tl
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 13:39:14 -0400
Received: from mail-bn3nam01on071f.outbound.protection.outlook.com
	([2a01:111:f400:fe41::71f]:20640
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gGp0x-0005RL-3h
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 13:38:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sun, 28 Oct 2018 17:37:45 +0000
Message-ID: <BN6PR2201MB1251A2C1CD591676D1EAABC5C6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1540383527-7923-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 07/20] target/mips: Add bit encoding for
 MXU accumulate add/sub 2-bit pattern 'aptn2'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

> Subject: [PATCH v7 07/20] target/mips: Add bit encoding for MXU accumulat=
e add/sub 2-bit pattern 'aptn2'
>=20
> From: Craig Janeczek <jancraig@amazon.com>
>=20
> Add bit encoding for MXU accumulate add/subtract 2-bit pattern
> 'aptn2'.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
