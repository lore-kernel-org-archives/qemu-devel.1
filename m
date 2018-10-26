Received: from eggs.gnu.org ([2001:4830:134:3::10]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4eb-0005n1-Av
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4eX-0001A1-Du
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:08:05 -0400
Received: from mail-dm3nam05on0717.outbound.protection.outlook.com
	([2a01:111:f400:fe51::717]:6211
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG4eX-00019X-5v
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:08:01 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 16:07:58 +0000
Message-ID: <BN6PR2201MB12516ED0D72FE02DD5BF3B64C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1540563667-23300-5-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-5-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/6] Read and set FP ABI value from MIPS
 abiflags
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

> Subject: [PATCH 4/6] Read and set FP ABI value from MIPS abiflags
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---

A short commit message is needed. Other than that:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
