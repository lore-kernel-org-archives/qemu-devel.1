Received: from eggs.gnu.org ([2001:4830:134:3::10]:45508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fay3A-0000KW-5P
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fay37-0000fF-2R
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:47:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fay36-0000dx-U1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:47:28 -0400
Date: Thu, 5 Jul 2018 08:47:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180705064726.zswibgkefkrpybgp@sirius.home.kraxel.org>
References: <20170901105331.11783-1-kraxel@redhat.com>
	<20180704204407.GA22336@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704204407.GA22336@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] docs: add firmware.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Wed, Jul 04, 2018 at 05:44:07PM -0300, Eduardo Habkost wrote:
> On Fri, Sep 01, 2017 at 12:53:31PM +0200, Gerd Hoffmann wrote:
> > Document how guest firmware is handled in qemu today.
> > 
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Is this document still valid?  Should we apply this for QEMU 3.0?

I think so.

The effort to move the firmware to a separate repo is stalled due to
ENOTIME, and surely will not happen for 3.0.  So it makes sense to just
merge the text as-is.

cheers,
  Gerd
