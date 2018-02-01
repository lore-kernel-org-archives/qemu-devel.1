Received: from eggs.gnu.org ([2001:4830:134:3::10]:39725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehAAP-0004bd-0B
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehAAL-0002BT-1z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:24:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehAAK-0002BN-Sc
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:24:16 -0500
Date: Thu, 1 Feb 2018 09:24:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180201082411.ap7jk7r7ltmypo3l@sirius.home.kraxel.org>
References: <20180131121217.13557-1-kraxel@redhat.com>
	<20180131132030.4bd5344f@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131132030.4bd5344f@w520.home>
Subject: Re: [Qemu-devel] [RfC PATCH v2 0/5] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

  Hi,

> > plese test and review,
> 
> may never come to fruition.  As for testing, region support was
> included for NVIDIA, dmabuf for Intel... is this testing request mainly
> for the Kirti and others at NVIDIA?  Thanks,

Yes.  v1 was tested by Kirti and I've fixed up two small issues pointed
out, so this should work as-is in theory.  But confirming that it
actually works before merging would be great.

thanks,
  Gerd
