Received: from eggs.gnu.org ([2001:4830:134:3::10]:46612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCNU2-00015E-Te
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCNTz-00005k-Pz
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:21:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eCNTz-0008VF-Jn
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:21:19 -0500
Date: Wed, 8 Nov 2017 11:21:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171108102116.dsng42mi4a4wxopk@sirius.home.kraxel.org>
References: <20171103115631.15175-1-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103115631.15175-1-owen.smith@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/4] xenfb: Enablement for Windows PV
 HID frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

On Fri, Nov 03, 2017 at 11:56:27AM +0000, Owen Smith wrote:
> Improve the input device model in xenfb, by updating the
> Qemu input handlers and adding a feature to allow for
> raw (unscaled) absolute coordinates to be represented.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Will this be merged via xen queue?

If not I can queue it up in my input queue, but I'd like to have a
review from the xen folks then.

cheers,
  Gerd
