Received: from eggs.gnu.org ([2001:4830:134:3::10]:34441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1fybSN-0001YL-N0
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1fybSJ-00018l-NP
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:31:15 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:55222
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1fybSI-0000yG-AU
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:31:11 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23994059AbeIHLbAUy7Je (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Sat, 8 Sep 2018 13:31:00 +0200
Date: Sat, 8 Sep 2018 12:31:00 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20180907191619.GA11275@r52>
Message-ID: <alpine.LFD.2.21.1809081228590.764@eddie.linux-mips.org>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
	<20180907191619.GA11275@r52>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: Initial support for MIPS
 R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Fredrik,

> Aleksandar, Aurelien, Maciej -- are you happy with this initial v2 patch?

 I have skimmed over and I have a couple of comments.  I'll try to 
finalise them ASAP, however I'm currently at the GNU Tools Cauldron and 
much of my time is taken by the event.

  Maciej
