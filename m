Received: from eggs.gnu.org ([2001:4830:134:3::10]:46786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esmQr-0001x3-8e
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esmQn-0007pY-7Q
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:29:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:64932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1esmQm-0007nz-Ur
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:29:17 -0500
Date: Mon, 5 Mar 2018 17:12:27 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305091227.GI2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-12-git-send-email-yi.l.liu@linux.intel.com>
	<1df3b397-da33-f05e-98ed-088cb710636f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df3b397-da33-f05e-98ed-088cb710636f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/12] intel_iommu: add framework for
 PASID AddressSpace management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On Fri, Mar 02, 2018 at 03:52:44PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 11:33, Liu, Yi L wrote:
> 
> Please merge this patch with the next one, since they are basically the
> .h and .c sides of the same thing.

yes, would do it in next version.

Thanks,
Yi Liu
