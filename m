Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e1UVV-00056y-Ap
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e1UVQ-0002AV-Vm
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:37:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:58344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1e1UVQ-00028n-Nb
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:37:48 -0400
Message-ID: <59DB43DD.30409@intel.com>
Date: Mon, 09 Oct 2017 17:39:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506864327.1916.3.camel@icloud.com>
In-Reply-To: <1506864327.1916.3.camel@icloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 0/5] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damian Tometzki <damian.tometzki@icloud.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 10/01/2017 09:25 PM, Damian Tometzki wrote:
> Hello,
>
> where i can found the patch in git.kernel.org ?
>

We don't have patches there. If you want to try this feature, you can 
get the qemu side draft code here: https://github.com/wei-w-wang/qemu-lm

Best,
Wei
