Received: from eggs.gnu.org ([2001:4830:134:3::10]:36468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1epAJN-0003WP-Lh
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1epAJK-0006AH-GT
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:10:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1epAJK-000670-AP
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:10:38 -0500
Date: Fri, 23 Feb 2018 10:10:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180223101032.GA31076@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Feb 23, 2018 at 01:11:46PM +1300, Michael Clark wrote:
> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
> 
> This is hopefully the "fix remaining issues in-tree" release.

This code seems to be a mixture of LGPLv2+ and MIT licensed code. The
preferred license for QEMU contributions is GPLv2+. Is there a reason
you need to diverge from this or can it be changed to be all GPLv2+ ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
