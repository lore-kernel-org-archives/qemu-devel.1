Received: from eggs.gnu.org ([2001:4830:134:3::10]:54877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPanL-0004IV-AU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPanK-0004wx-7q
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:27 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<44e7883bd17c6867f0ac488bdab6c880b2420a9b.1542819633.git.alistair.francis@wdc.com>
	<0ddaeccd-94fd-22a8-f5e0-91fbafdf1761@deltatee.com>
	<CAKmqyKNitWerbpVzQrNye3KiPj=5DVFXan4SpiN-+br_P-RG+Q@mail.gmail.com>
	<0fac09ca-12d5-1462-4456-66646f168ab5@deltatee.com>
	<CAKmqyKMTxgk41cBz=hW-meCUAi-_20vguqN40f_ThRU-rsaJXA@mail.gmail.com>
	<17256c59-cf5e-2247-985a-84c26f9d64a9@deltatee.com>
	<CAKmqyKMij-hfwFn8snBni0D7puJMwb1bHXiJP939QEPGznENEQ@mail.gmail.com>
	<CAKmqyKPcoouWEC9KqP2z5n0tg-Zf_4FpJD9mDPWbm=z6QXwcJQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1aeba982-3db9-4f29-aa79-be98ff0e363b@deltatee.com>
Date: Wed, 21 Nov 2018 15:16:14 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPcoouWEC9KqP2z5n0tg-Zf_4FpJD9mDPWbm=z6QXwcJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 6/6] hw/riscv/virt: Connect a
 VirtIO net PCIe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>



On 2018-11-21 3:14 p.m., Alistair Francis wrote:
>> and networking works?
> 
> Yep, it should. This is for the -nic option [1]. I misunderstood when
> I was going through it.
> 
> We can drop this patch then.
> 
> 1: https://github.com/qemu/qemu/commit/fea9b3ca9cc4685f89e0b929a61e51098fbb4f49

Ah, ok, that clears it up. You can drop it or keep it, but if you keep
it you should have a similar commit message.

Logan
