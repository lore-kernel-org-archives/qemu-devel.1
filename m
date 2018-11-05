Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gJhal-0004ho-9h
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gJhP0-0001zt-In
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:07:09 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:33936
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gJhP0-0001VT-7e
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:06:58 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23990901AbeKEQG2HaLf- (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Mon, 5 Nov 2018 17:06:28 +0100
Date: Mon, 5 Nov 2018 16:06:28 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181105154046.GA2383@sx9>
Message-ID: <alpine.LFD.2.21.1811051604490.20378@eddie.linux-mips.org>
References: <cover.1541174426.git.noring@nocrew.org>
	<fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
	<1001e61e-b6c0-1a41-9e9f-e2fd5a51f7b5@linaro.org>
	<20181104131236.GA30862@sx9>
	<alpine.LFD.2.21.1811041503590.20378@eddie.linux-mips.org>
	<20181105154046.GA2383@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Fix decoding mechanism of
 R5900 MFLO1, MFHI1, MTLO1 and MTHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org

On Mon, 5 Nov 2018, Fredrik Noring wrote:

> where ac can range from 0 to 3. Do you have a link to a better reference,
> by chance, that isn't tied to microMIPS?

 Here: <https://www.mips.com/downloads/> you'll find everything you need I 
believe.

 HTH,

  Maciej
