Received: from eggs.gnu.org ([209.51.188.92]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyH2A-0001Zn-0d
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyH29-0004dy-89
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:15:06 -0500
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
	<20190222162555.13764-2-amagdy.afifi@gmail.com>
	<8f36a26e-7e20-1b9c-18bd-a5ce4b3d9c14@redhat.com>
	<CAKV=O7=JK4t7VxQ74LvjVpM9+TQ6MJ0hA9_XX40ud7OEsh30hQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9623b11-0bf9-4dc0-7605-c68601eb1fb5@redhat.com>
Date: Mon, 25 Feb 2019 08:14:50 -0600
MIME-Version: 1.0
In-Reply-To: <CAKV=O7=JK4t7VxQ74LvjVpM9+TQ6MJ0hA9_XX40ud7OEsh30hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] riscv: Add proper alignment check and
 pending 'C' extension upon misa writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amed Magdy <amagdy.afifi@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com

On 2/24/19 2:07 AM, Amed Magdy wrote:
> Thank you so much, Eric.
> 
> Sorry about this unclear description.
> I forgot to fix user name in git configuration before submitting the patch.
> 
> Sorry about any inconvenience.

Don't worry about it. We were all once first-time contributors, and it
can be a large learning curve.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
