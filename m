Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPwGk-0002FU-6r
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 16:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPw6E-00085T-Qi
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 16:01:28 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gPw6C-00080v-Mu
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 16:01:21 -0500
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<20181121054709.GA10918@xz-x1>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <e1e71a8a-fbe0-4c73-0de9-1e86ff8b502b@nvidia.com>
Date: Fri, 23 Nov 2018 02:31:06 +0530
MIME-Version: 1.0
In-Reply-To: <20181121054709.GA10918@xz-x1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Add migration support for VFIO device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com



On 11/21/2018 11:17 AM, Peter Xu wrote:
> On Wed, Nov 21, 2018 at 02:09:38AM +0530, Kirti Wankhede wrote:
>> Add migration support for VFIO device
> 
> Hi, Kirti,
> 
> I failed to apply the series cleanly onto master.  Could you push the
> tree somewhere so that people might read the work easier?  Or would
> you tell me the base commit, then I can apply it myself.
> 

Sorry of inconvenience.
These patches are on top of v3.0.0 release (tag: v3.0.0)

Thanks,
Kirti
