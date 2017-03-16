Received: from eggs.gnu.org ([2001:4830:134:3::10]:58220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kai.huang@linux.intel.com>) id 1coKPR-0006jz-CO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kai.huang@linux.intel.com>) id 1coKPN-00050D-Su
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:40:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:31400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kai.huang@linux.intel.com>)
	id 1coKPN-0004pK-F0
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:40:53 -0400
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com> <58B04CD3.7010304@windriver.com>
	<7fdf2551-3d55-1bd9-2848-720a880cc93e@redhat.com>
	<58B0E191.6040108@huawei.com>
	<50916996-297e-a794-38e8-5c7ca9389419@linux.intel.com>
	<a865b1b0-558f-900f-06d7-ceace1c46afb@huawei.com>
	<d6172fb7-ab1c-0faf-ed71-18fd74781671@redhat.com>
From: "Huang, Kai" <kai.huang@linux.intel.com>
Message-ID: <84e697fb-0309-faa9-9f10-90235f839db6@linux.intel.com>
Date: Thu, 16 Mar 2017 14:40:20 +1300
MIME-Version: 1.0
In-Reply-To: <d6172fb7-ab1c-0faf-ed71-18fd74781671@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, fangying <fangying1@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Chris Friesen <chris.friesen@windriver.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org

Thanks!

Thanks,
-Kai

On 3/14/2017 5:57 AM, Paolo Bonzini wrote:
>
>
> On 13/03/2017 15:58, fangying wrote:
>> Hi, Huang Kai
>>
>> After weeks of intensive testing, we think the problem is solved and
>> this issue can be closed.
>
> Thanks for the update.  We got to the same conclusion.
>
> Paolo
>
