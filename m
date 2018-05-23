Received: from eggs.gnu.org ([2001:4830:134:3::10]:51104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLV8A-00015N-4f
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLV86-0004BV-1f
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:52:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLV85-0004BN-Tc
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:52:41 -0400
Date: Wed, 23 May 2018 17:52:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180523175148-mutt-send-email-mst@kernel.org>
References: <CAG7gSg0DJHjZiPZr6+itsmSOGJ372HRipEUsh2x8dj8EWUjkhg@mail.gmail.com>
	<20180523175039-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523175039-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Ping [PATCH RFC v2 0/2] Fix UART serial
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Calvin Lee <cyrus296@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, May 23, 2018 at 05:51:08PM +0300, Michael S. Tsirkin wrote:
> On Mon, May 21, 2018 at 10:40:33AM -0600, Calvin Lee wrote:
> > Hello,
> > 
> > It's been about a week since the last email to my patches, in case anyone would
> > like to review but missed them.
> > 
> > Patches are the following on patchwork:
> > http://patchwork.ozlabs.org/patch/912281/
> > http://patchwork.ozlabs.org/patch/912282/
> > 
> > And the following on patchew:
> > http://patchew.org/QEMU/20180512000545.966-1-cyrus296@gmail.com/
> > 
> > Thank you,
> > Calvin Lee
> 
> If you'd like these merged, pls re-post without an RFC tag.

Not before addressing the build and other vmstate related issues,
just FYI RFC means "pls review but do not merge".

> -- 
> MST
