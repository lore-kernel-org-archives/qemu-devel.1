Received: from eggs.gnu.org ([2001:4830:134:3::10]:58208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fvs0c-00022i-Mm
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fvroZ-0004dE-RT
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:22:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fvroZ-0004cy-IA
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:22:51 -0400
Date: Fri, 31 Aug 2018 18:22:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180831222249.GA28489@flamenco>
References: <20180810173941.5301-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810173941.5301-1-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/riscv: use
 tcg_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <alistair.francis@wdc.com>

On Fri, Aug 10, 2018 at 13:39:38 -0400, Emilio G. Cota wrote:
> Changes wrt v1: changed patch 3 as suggested by Richard. Also
> added his R-b's.
> 
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/riscv-lookup_ptr-v2

RISC-V maintainers: any plans of picking this up for 3.1?

(Cc'ing Alistair since he recently submitted some riscv-related
pull requests; BTW Alistair, should you be listed as a RISC-V
maintainer?)

Thanks,

		Emilio
