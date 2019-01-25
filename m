Received: from eggs.gnu.org ([209.51.188.92]:49819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gn1u0-0006Kp-E2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gn1pR-0002KY-4O
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:47:31 -0500
Received: from mail-eopbgr790114.outbound.protection.outlook.com
	([40.107.79.114]:22144
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gn1pH-0002GZ-6U
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:47:21 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 25 Jan 2019 13:47:15 +0000
Message-ID: <BN6PR2201MB1251D66A2A0112B2FCF5209FC69B0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 00/14] MIPS queue for January 25, 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PULL 00/14] MIPS queue for January 25, 2019

Hello, Peter,

There are 4 checkpatch warnings. Please ignore them, for these circumstance=
s. Three are about the potential need for MAINTAINERS updates (but they are=
 not necessary, new files and directories will be covered by existing items=
 in MAINTAINERS file), and the fourth is about a comment format in test_dsp=
_r2_dpaqx_s_w_ph.c (however, the point of the test reorganization is to mov=
e the file as-is, I would like to restrict the patch only to moving files i=
n case of test source files).

Regards,
Aleksandar=
