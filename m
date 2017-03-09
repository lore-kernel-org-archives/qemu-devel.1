Received: from eggs.gnu.org ([2001:4830:134:3::10]:57865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1clsEY-0004JW-Op
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 02:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1clsEV-0006pC-Jv
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 02:11:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1clsEV-0006p8-AX
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 02:11:31 -0500
Message-ID: <58C1006F.6080206@intel.com>
Date: Thu, 09 Mar 2017 15:12:47 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-3-git-send-email-wei.w.wang@intel.com>
	<20170308060131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170308060131-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 kernel 2/5] virtio-balloon:
 VIRTIO_BALLOON_F_CHUNK_TRANSFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang.opensource@gmail.com>

On 03/08/2017 12:01 PM, Michael S. Tsirkin wrote:
> On Fri, Mar 03, 2017 at 01:40:27PM +0800, Wei Wang wrote:
>> From: Liang Li <liang.z.li@intel.com>
>>
>> Add a new feature bit, VIRTIO_BALLOON_F_CHUNK_TRANSFER. Please check
>> the implementation patch commit for details about this feature.
>
> better squash into next patch.

OK, will do.

Best,
Wei
