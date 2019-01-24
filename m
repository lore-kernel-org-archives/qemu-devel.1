Received: from eggs.gnu.org ([209.51.188.92]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gmfyU-00059n-Lu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gmfyU-0002be-1g
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:27:22 -0500
Received: from mail-eopbgr710098.outbound.protection.outlook.com
	([40.107.71.98]:30592
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gmfyT-0002a2-MQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:27:21 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 24 Jan 2019 14:27:19 +0000
Message-ID: <BN6PR2201MB1251AD2BFD380E057F391444C69A0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1548242160-16039-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/9] target/mips: nanoMIPS: Rename
 macros for extracting 3-bit-coded GPR numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


________________________________________
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Sent: Wednesday, January 23, 2019 12:15 PM
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
Subject: [PATCH v2 3/9] target/mips: nanoMIPS: Rename macros for extracting=
 3-bit-coded GPR numbers

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Rename macros for extracting 3-bit-coded GPR numbers, to achieve
> better consistency with the nanoMIPS documentation.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>=
