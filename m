Received: from eggs.gnu.org ([209.51.188.92]:33799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1golrQ-0008Uy-GD
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1golrP-0001fO-PC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:08:44 -0500
References: <mhng-2dd4c232-3efb-4173-aae1-491b9aa2685b@palmer-si-x1c4>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <603b6279-8670-d614-e1ac-4c13bf870ec9@mail.uni-paderborn.de>
Date: Wed, 30 Jan 2019 10:08:33 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-2dd4c232-3efb-4173-aae1-491b9aa2685b@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v5 00/35] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

Hi Palmer,

On 1/29/19 8:22 PM, Palmer Dabbelt wrote:
> [..]
> Well, that pretty much exhausts my testing scheme :).  I think 
> Alistair might have a setup for booting a 32-bit Yocto-based distro in 
> QEMU.  Assuming he has the flow set up and it boots then I don't see 
> any reason not to merge it.
>
> Thanks for pulling this all together, it's really great to have a 
> cleaner decoder!
>
> Alistair: if that's true, can you give this a shot?
>
> Bastian: do you mind collecting the relevant tags (Reviwed-by, etc) 
> and putting them in a v6?


I already did (see 
http://lists.gnu.org/archive/html/qemu-riscv/2019-01/msg00147.html) :)

Cheers,

Bastian
