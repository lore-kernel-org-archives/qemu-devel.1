Received: from eggs.gnu.org ([2001:4830:134:3::10]:35757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gRCqr-0001ei-Sy
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gRCqo-00032M-PQ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:06:45 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:49970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gRCqo-00031a-Ca
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:06:42 -0500
References: <20181126032038.22044-1-maozhongyi@cmss.chinamobile.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <d17b7767-a72f-a84a-a65d-d848db42d030@mail.uni-paderborn.de>
Date: Mon, 26 Nov 2018 10:06:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181126032038.22044-1-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH] riscv/cpu: use
 device_class_set_parent_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com, philmd@redhat.com

On 11/26/18 4:20 AM, Mao Zhongyi wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>   target/riscv/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,

Bastian
