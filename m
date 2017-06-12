Received: from eggs.gnu.org ([2001:4830:134:3::10]:51461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dKEAO-0004fD-Hg
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dKEAK-0004rp-9K
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dKEAK-0004rF-2v
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:29:12 -0400
Date: Mon, 12 Jun 2017 09:29:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170612012907.GA14733@lemon.lan>
References: <149710124565.5184.589786790726488850@84b42461e25a>
	<ec44cfad-92a4-664a-4c05-39941bc31480@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec44cfad-92a4-664a-4c05-39941bc31480@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/3] sun4u: move fw_cfg/NVRAM devices to
 ebus PCI IO address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com

On Sat, 06/10 14:31, Mark Cave-Ayland wrote:
> On 10/06/17 14:27, no-reply@patchew.org wrote:
> 
> > Hi,
> > 
> > This series failed build test on s390x host. Please find the details below.
> 
> Well given that it's dependent upon the fw_cfg patchset I posted
> earlier, it's probably going to fail on all hosts :)
> 
> Is there a way to express patch dependencies for the patchew builds that
> I'm not aware of?

There currently isn't one but it's being worked on. I will announce it on
qemu-devel@nongnu.org once it's ready. Thanks!

Fam
