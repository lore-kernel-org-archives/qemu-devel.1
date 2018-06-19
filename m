Received: from eggs.gnu.org ([2001:4830:134:3::10]:53882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVEKR-00083a-D5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVEKO-00017Z-4t
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:57:39 -0400
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<alpine.BSF.2.21.1806191218120.6476@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d66a1914-1fbd-93d0-7e9f-879240c6fe94@redhat.com>
Date: Tue, 19 Jun 2018 12:57:33 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806191218120.6476@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Include vga cirrus card
 into the compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 19.06.2018 12:23, BALATON Zoltan wrote:
[...]
> Also what about ppcemb-softmmu? It's deprecated but do we still want to
> update it until it's removed or deprecated means no new features are
> added to it? I've also updated ppcemb config in my other patches to keep
> sam460ex working there the same as with ppc-softmmu.

IMHO it's not worth the effort anymore to update the ppcemb-softmmu
configs. It's going to be removed soon anyway.

 Thomas
