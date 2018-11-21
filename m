Received: from eggs.gnu.org ([2001:4830:134:3::10]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPXjU-0003Ak-Vf
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPXjU-0008Cc-AP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:00:16 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<a2c70c88a145d2e239f113e28979c7a50d71aedf.1542819633.git.alistair.francis@wdc.com>
	<ff4ef556-0989-ec47-0424-3f153f10a8d0@deltatee.com>
	<CAKmqyKOMsBda223ptqt2iVFi6oVifK_0L+=Mne=v9p_umwxVLg@mail.gmail.com>
	<ed679475-5ba2-c2ce-c468-b531188d6b7e@deltatee.com>
	<CAKmqyKOA0xa0RhNatt9JybpGMLGds+E8CytOXr8rQuSYi7VrxA@mail.gmail.com>
	<a751fd52-28c7-043a-234c-7f7b5251b9ad@deltatee.com>
In-Reply-To: <a751fd52-28c7-043a-234c-7f7b5251b9ad@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 10:59:46 -0800
Message-ID: <CAKmqyKOaAYkPkJ3h2_smaE+wL2cmtBdNaC6sD_Ztwr7=YDYOMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 1/6] hw/riscv/virt: Increase the
 number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>

On Wed, Nov 21, 2018 at 10:56 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 11:49 a.m., Alistair Francis wrote:
> > Agreed. It's the same number as the last interrupt in the QEMU SiFive
> > U machine. So that is where it came from.
>
> Ok, can we have a comment for that?

I don't think we really need a comment. It's just a made up number. It
just has to be higher then the actual number of used interrupts. It
can be changed in the future if required.

Alistair

>
> Logan
