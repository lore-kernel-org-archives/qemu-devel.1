Received: from eggs.gnu.org ([2001:4830:134:3::10]:54192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPees-0002UU-3V
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPeer-0004I4-2V
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:23:58 -0500
MIME-Version: 1.0
References: <9ee74477-105f-db2e-b69c-e67d485b9c2f@deltatee.com>
	<mhng-105c249c-fc1f-4d85-bf75-5aeb17d95854@palmer-si-x1c4>
In-Reply-To: <mhng-105c249c-fc1f-4d85-bf75-5aeb17d95854@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 18:23:26 -0800
Message-ID: <CAKmqyKPVif8MQs_aGXxx=aOi9mrRJz94AFv2B41JVETqY9BQRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Guenter Roeck <linux@roeck-us.net>, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrea Bolognani <abologna@redhat.com>

On Wed, Nov 21, 2018 at 6:13 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 21 Nov 2018 15:26:01 PST (-0800), logang@deltatee.com wrote:
> >
> >
> > On 2018-11-21 4:10 p.m., Guenter Roeck wrote:
> >> FWIW, I absoutely agree. If the board can only be used to boot an initrd,
> >> it is quite pointless to have it around. Actually it is worse than pointless,
> >> since it will result in people wasting their time trying to get it to work.
> >
> > As someone who has wasted their time on it, I second this sentiment.
>
> So it sounds like I should target that deprecation patch set for 3.1?  Who
> wants to review it?

I think it's a little late for 3.1. Let's leave it for 3.2

Alistair
