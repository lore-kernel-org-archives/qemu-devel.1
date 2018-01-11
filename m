Received: from eggs.gnu.org ([2001:4830:134:3::10]:59832)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eZXkg-00063s-Sh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 02:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eZXkd-0002cv-Pg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 02:58:18 -0500
Received: from verein.lst.de ([213.95.11.211]:47924 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eZXkd-0002a4-Ia
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 02:58:15 -0500
Date: Thu, 11 Jan 2018 08:58:12 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180111075812.GA32651@lst.de>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/21] RISC-V QEMU Port Submission v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Jan 10, 2018 at 03:46:19PM -0800, Michael Clark wrote:
> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10

Same question as for V2:  Why do you want to add code for an obsolete
version of the privileged ISA spec? (which as far as I can tell
can't even be found online).
