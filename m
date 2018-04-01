Received: from eggs.gnu.org ([2001:4830:134:3::10]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1f2i3H-0004Tg-9q
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 14:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1f2i3E-0007af-8C
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 14:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1f2i3E-0007Ze-1t
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 14:50:00 -0400
Date: Sun, 1 Apr 2018 19:49:56 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180401184956.GZ2787@redhat.com>
References: <1522344417-60114-1-git-send-email-mjc@sifive.com>
	<CAHNT7Nvtx85EfQ6g_E1bL5XRvwZYoo=YoarMA6r9V4dER-O3Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Nvtx85EfQ6g_E1bL5XRvwZYoo=YoarMA6r9V4dER-O3Cw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Mar 30, 2018 at 10:08:23AM -0700, Michael Clark wrote:
> Hi Peter,
> 
> I had tested Richard's proper fix but we didn't have a PR or the required
> Reviewed-by and Signed-off-by so I made the PR for the conservative fix,

"Richard" is me or Richard Henderson?  Anyway if you meant Stefan
O'Rear's fix (https://github.com/rwmjones/fedora-riscv-bootstrap/blob/master/stage1-riscv-qemu/force-float-save.patch)
then it is my understanding that this is also just a workaround.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
