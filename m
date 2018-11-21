Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gPLME-0007j7-Rf
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gPLMA-0001T3-Th
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:47:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gPLMA-0001Sf-LN
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:47:22 -0500
Date: Wed, 21 Nov 2018 13:47:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181121054709.GA10918@xz-x1>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Add migration support for VFIO device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com

On Wed, Nov 21, 2018 at 02:09:38AM +0530, Kirti Wankhede wrote:
> Add migration support for VFIO device

Hi, Kirti,

I failed to apply the series cleanly onto master.  Could you push the
tree somewhere so that people might read the work easier?  Or would
you tell me the base commit, then I can apply it myself.

Thanks in advance,

-- 
Peter Xu
