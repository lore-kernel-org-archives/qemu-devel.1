Received: from eggs.gnu.org ([2001:4830:134:3::10]:59190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4jI-0001rJ-RV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4jB-0003VN-Q5
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:12:55 -0400
Received: from mail-by2nam03on0098.outbound.protection.outlook.com
	([104.47.42.98]:43480
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG4jA-0003C9-Vc
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:12:49 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 16:12:15 +0000
Message-ID: <BN6PR2201MB125104740C451A93B7281BD4C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1540563667-23300-2-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-2-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/6] Define MIPS_ABI_FP_UNKNOWN macro
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

> Subject: [PATCH 1/6] Define MIPS_ABI_FP_UNKNOWN macro
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---

A brief commit message is needed. From what kernel or glibc header is this =
constant copied? Other than that:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
