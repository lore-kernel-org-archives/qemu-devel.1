Received: from eggs.gnu.org ([2001:4830:134:3::10]:39852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dpsL6-0005au-Md
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dpsL2-0006ML-8t
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:39:08 -0400
Date: Thu, 7 Sep 2017 10:38:55 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170907083855.GC2441@vader>
References: <20170901110332.32650-1-otubo@redhat.com>
	<20170901143016.GK7570@localhost.localdomain>
	<20170902091520.bxecfhisvy46o4cb@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170902091520.bxecfhisvy46o4cb@aurel32.net>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] dma/i82374: avoid double
 creation of i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On Sat, Sep 02, 2017 at 11:15:20AM +0200, Aurelien Jarno wrote:
> On 2017-09-01 11:30, Eduardo Habkost wrote:
> > i82374 is compiled in only on ppc and sh4, so I'm CCing the
> > maintainers for those architectures.
> 
> The i82374 device is not useful nor usable on SH4. It has just been
> added in commit 85d3846a39 to be able to run the tests.
> 
> Aurelien
> 

Any word from the ppc guys?

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
