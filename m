Received: from eggs.gnu.org ([2001:4830:134:3::10]:49803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPbsp-000613-Ik
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPbsm-0002H6-FL
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:26:11 -0500
References: <CAKmqyKNpSWpaUVzJobNPvB=_T+tXhGdiWPTkWmQxdKQf8SHbig@mail.gmail.com>
	<mhng-dc5c5bfa-47d8-41c6-8240-fdb97d24555e@palmer-si-x1c4>
	<20181121231005.GB1421@roeck-us.net>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9ee74477-105f-db2e-b69c-e67d485b9c2f@deltatee.com>
Date: Wed, 21 Nov 2018 16:26:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181121231005.GB1421@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
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
To: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@sifive.com>
Cc: alistair23@gmail.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, abologna@redhat.com



On 2018-11-21 4:10 p.m., Guenter Roeck wrote:
> FWIW, I absoutely agree. If the board can only be used to boot an initrd,
> it is quite pointless to have it around. Actually it is worse than pointless,
> since it will result in people wasting their time trying to get it to work.

As someone who has wasted their time on it, I second this sentiment.

Logan
