Received: from eggs.gnu.org ([2001:4830:134:3::10]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dim2y-0004Wy-9q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dim2v-0006wO-4M
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dim2u-0006wH-UX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:31:01 -0400
Date: Fri, 18 Aug 2017 21:30:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170818213036-mutt-send-email-mst@kernel.org>
References: <20170817162347.1590-1-anthony.perard@citrix.com>
	<20170817162347.1590-3-anthony.perard@citrix.com>
	<20170818043655-mutt-send-email-mst@kernel.org>
	<20170818113734.181332ad@nial.brq.redhat.com>
	<20170818133107.GG1475@perard.uk.xensource.com>
	<20170818161957.3a63f611@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818161957.3a63f611@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3 2/3] hw/acpi: Move
 acpi_set_pci_info to pcihp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Aug 18, 2017 at 04:19:57PM +0200, Igor Mammedov wrote:
> > > > 
> > > > Clean it up after 2.10.
> > > >   
> > 
> > So is the v2 good enough or do I need to resend it?
> Do you really need it in 2.10?
> it's only 2 days left till release so unless it's blocker
> I'd wait till after release and do clean fix.

Well it's a regression isn't it?

> 
> > Thanks,
> > 
