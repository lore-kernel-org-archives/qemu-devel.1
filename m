Received: from eggs.gnu.org ([2001:4830:134:3::10]:36162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1ei3Wk-0003UC-6w
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 14:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1ei3Wh-0004p2-2i
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 14:31:06 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1ei3Wg-0004oG-SC
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 14:31:03 -0500
References: <20180131121217.13557-1-kraxel@redhat.com>
	<20180131132030.4bd5344f@w520.home>
	<20180201082411.ap7jk7r7ltmypo3l@sirius.home.kraxel.org>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <a67a7dbf-cd65-6670-e604-4c2d08d4601a@nvidia.com>
Date: Sun, 4 Feb 2018 00:40:35 +0530
MIME-Version: 1.0
In-Reply-To: <20180201082411.ap7jk7r7ltmypo3l@sirius.home.kraxel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH v2 0/5] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org



On 2/1/2018 1:54 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> plese test and review,
>>
>> may never come to fruition.  As for testing, region support was
>> included for NVIDIA, dmabuf for Intel... is this testing request mainly
>> for the Kirti and others at NVIDIA?  Thanks,
> 
> Yes.  v1 was tested by Kirti and I've fixed up two small issues pointed
> out, so this should work as-is in theory.  But confirming that it
> actually works before merging would be great.
> 

Thanks Gerd for taking care of the minor fixes.

Tested this series for region support.

This patch-set looks good to me.

Tested-by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti
