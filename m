Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gG1um-00013U-MN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gG1ue-0004u1-7e
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:12:34 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:33290
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gG1uY-0004nj-Nv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:12:24 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992869AbeJZNMTjxzQw (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Fri, 26 Oct 2018 15:12:19 +0200
Date: Fri, 26 Oct 2018 14:12:19 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <a6a9b9eb-3bb3-eeba-84c2-65097185cea4@linaro.org>
Message-ID: <alpine.LFD.2.21.1810261406391.19280@eddie.linux-mips.org>
References: <20181023203710.GA2239@sx9>
	<9aea2b05-24d7-f845-d899-0c6fec033672@linaro.org>
	<20181025170128.GA2309@sx9>
	<alpine.LFD.2.21.1810251839110.19280@eddie.linux-mips.org>
	<a6a9b9eb-3bb3-eeba-84c2-65097185cea4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Fredrik Noring <noring@nocrew.org>, Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On Fri, 26 Oct 2018, Richard Henderson wrote:

> > Overall this source file is clearly a modified copy of an ancient version 
> > of the opcode table included with the opcodes library from binutils and I 
> > think it would benefit from a refresh.
> 
> You can't do that because of GPL v3, sadly.

 I've been aware of that, however the changes I mentioned are pretty 
mechanical and can be easily made from scratch by someone them who hasn't 
looked at binutils, even based on the description I already made.  You 
don't copyright an idea, only actual written code.

  Maciej
