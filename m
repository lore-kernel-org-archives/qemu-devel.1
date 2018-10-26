Received: from eggs.gnu.org ([2001:4830:134:3::10]:58603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4hN-0008BC-OZ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4hJ-0002F9-Mq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:10:57 -0400
Received: from mail-dm3nam03on071a.outbound.protection.outlook.com
	([2a01:111:f400:fe49::71a]:19328
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG4hF-0002DY-3q
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:10:49 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 16:10:45 +0000
Message-ID: <BN6PR2201MB1251FF248F74ACD2DB627E10C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1540563667-23300-3-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-3-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/6] Extend image_info struct with MIPS
 specific fp_abi and interp_fp_abi fields
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

> Subject: [PATCH 2/6] Extend image_info struct with MIPS specific fp_abi a=
nd interp_fp_abi fields
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---

A brief commit message is needed. Perhaps with the description of the role/=
purpose of two fields introduced in this patch. Other than that:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
