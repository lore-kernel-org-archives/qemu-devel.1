Received: from eggs.gnu.org ([2001:4830:134:3::10]:52861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5ZNq-0008Ha-Nt
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5ZNm-0004Mc-O7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:11:06 -0400
Date: Mon, 9 Apr 2018 12:11:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180409161101.GB18168@flamenco>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<cbad2760-7a64-7602-5734-eea0747c620f@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbad2760-7a64-7602-5734-eea0747c620f@mail.uni-paderborn.de>
Subject: Re: [Qemu-devel] [PATCH v2 00/17] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc/riscv targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Michael Clark <mjc@sifive.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On Mon, Apr 09, 2018 at 16:01:36 +0200, Bastian Koppelmann wrote:
> Thanks for doing this grunt work. Me and a colleague were planning to do
> this as well after converting the RISC-V frontend to decodetree. Do you
> have any plans to do this for the TriCore frontend as well? I have the
> same plan for Tricore: Convert it to decodetree, then to translation loop.

I won't do any further conversions in the near future, so please go
ahead with your plans :-)

Thanks,

		Emilio
