Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gO2VH-0004XJ-0j
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gO2VC-0002mR-Pq
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:27:23 -0500
Received: from mail-eopbgr810135.outbound.protection.outlook.com
	([40.107.81.135]:31228
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gO2VC-0002ls-IU
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:27:18 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sat, 17 Nov 2018 15:27:16 +0000
Message-ID: <BN6PR2201MB1251BD45FAF12F7FDBE8E225C6DE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541616663.git.noring@nocrew.org>,
	<0c57a01dc6463a5298037e1b211ea214c1ea245f.1541616663.git.noring@nocrew.org>
In-Reply-To: <0c57a01dc6463a5298037e1b211ea214c1ea245f.1541616663.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 5/6] target/mips: Guard
 check_insn_opc_user_only with INSN_R5900 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: [PATCH v2 5/6] target/mips: Guard check_insn_opc_user_only with =
INSN_R5900 check

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Some minor changes will be made before integrating.=
