Received: from eggs.gnu.org ([2001:4830:134:3::10]:57458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4dh-0003pQ-Fu
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4db-0000mG-JM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:07:09 -0400
Received: from mail-sn1nam01on0712.outbound.protection.outlook.com
	([2a01:111:f400:fe40::712]:29632
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG4db-0000lo-Cz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:07:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 16:06:57 +0000
Message-ID: <BN6PR2201MB12510E130C76B60DA64DADE4C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1540563667-23300-6-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-6-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 5/6] Determine the desired FPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>

> Subject: [PATCH 5/6] Determine the desired FPU mode
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Floating-point mode is calculated from MIPS.abiflags FP ABI value
> (based on kernel implementation). Illegal combinations are rejected.
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
