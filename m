Received: from eggs.gnu.org ([2001:4830:134:3::10]:42954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU9Ae-0006dl-7C
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU9Ab-0006mz-5u
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:38:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cU9Aa-0006mO-WB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:38:13 -0500
Date: Thu, 19 Jan 2017 17:38:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170119093808.GF4914@pxdev.xzpeter.org>
References: <20170116091801.GL30108@pxdev.xzpeter.org>
	<0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
	<20170117144514.GO30108@pxdev.xzpeter.org>
	<99e185dc-e3c9-678f-7a69-fc006658d07f@redhat.com>
	<20170118081137.GS30108@pxdev.xzpeter.org>
	<f89c8ad4-a95d-bf66-33c6-f151531c2174@redhat.com>
	<20170118084627.GT30108@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C0951D@SHSMSX101.ccr.corp.intel.com>
	<20170119031646.GA4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C0A9B2@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C0A9B2@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "Raj, Ashok" <ashok.raj@intel.com>

On Thu, Jan 19, 2017 at 06:22:48AM +0000, Tian, Kevin wrote:

[...]

> still copy response from spec owner here:-)
> 
> 	Explicit invalidation is anytime software is explicitly invalidating something (
> 	through any descriptor) as opposed to something hardware does implicitly.  
> 	The only time hardware does implicit invalidation is during the handling of a page 
> 	request (recoverable page-fault) from an endpoint device.

Thanks for the confirmation!

-- peterx
