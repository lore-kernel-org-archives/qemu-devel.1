Received: from eggs.gnu.org ([2001:4830:134:3::10]:40034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gO2WD-0005co-Mv
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gO2W7-00039S-UK
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:28:21 -0500
Received: from mail-eopbgr810119.outbound.protection.outlook.com
	([40.107.81.119]:26816
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gO2W6-00036n-AP
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:28:15 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sat, 17 Nov 2018 15:28:12 +0000
Message-ID: <BN6PR2201MB12517F022001DA07FAE0C77FC6DE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541616663.git.noring@nocrew.org>,
	<3275cefbe30ccac35da7f5fc99fb038d46149192.1541616663.git.noring@nocrew.org>
In-Reply-To: <3275cefbe30ccac35da7f5fc99fb038d46149192.1541616663.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/mips: Fix decoding mechanism
 of R5900 MFLO1, MFHI1, MTLO1 and MTHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: [PATCH v2 1/6] target/mips: Fix decoding mechanism of R5900 MFLO=
1, MFHI1, MTLO1 and MTHI1

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
