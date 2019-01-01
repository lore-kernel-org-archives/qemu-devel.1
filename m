Received: from eggs.gnu.org ([208.118.235.92]:54240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1geOlh-00036K-5q
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 13:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1geOle-0006LR-0n
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 13:27:57 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:55715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1geOld-0006Jg-PW
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 13:27:53 -0500
Date: Tue, 1 Jan 2019 19:27:45 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20190101182745.GA17022@sx9>
References: <cover.1541093316.git.noring@nocrew.org>
	<eecae865fc8f7934cc2d51b24cba7d8ac3ec37c6.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/12] tests/tcg/mips: Test R5900
 three-operand MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Thanks Aleksandar!

> > From: Fredrik Noring <noring@nocrew.org>
> > Subject: [PATCH v2 09/12] tests/tcg/mips: Test R5900 three-operand MADDU1
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This patch is selected for integration in the next MIPS pull request scheduled shortly.
> 
> THANKS FOR ALL EFFORTS!

Is this a preparation to revert commit 823f2897bdd7 ("target/mips: Disable
R5900 support")?

Fredrik
