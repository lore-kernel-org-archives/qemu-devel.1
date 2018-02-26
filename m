Received: from eggs.gnu.org ([2001:4830:134:3::10]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eqHOH-0004CJ-Cr
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eqHOC-0005dy-Gc
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:56:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:48426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1eqHOC-0005dG-AS
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:56:16 -0500
From: Andreas Schwab <schwab@suse.de>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Date: Mon, 26 Feb 2018 12:56:10 +0100
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com> (Michael
	Clark's message of "Fri, 23 Feb 2018 13:11:46 +1300")
Message-ID: <mvm7er0ufqd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

This is being used to build openSUSE Factory for riscv64 with linux-user
emulation:

https://build.opensuse.org/project/show/openSUSE:Factory:RISCV

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
