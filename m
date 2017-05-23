Received: from eggs.gnu.org ([2001:4830:134:3::10]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dD8Za-0006yI-I5
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dD8ZV-0004kj-69
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:05:58 -0400
Received: from [59.151.112.132] (port=56915 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dD8ZU-0004kH-PC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:05:53 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<80a52ceb-6e69-f4ee-04c7-1219bb7947c1@amsat.org>
	<ed2e0bd5-4a69-63d9-497c-b0b6aaac404d@redhat.com>
	<11a77586-ec42-d1cd-f4d1-f7444cf5febb@cn.fujitsu.com>
	<8bc88f06-105e-db58-9a73-a0b76769ca64@redhat.com>
	<1b884ac2-0cd4-bbd6-0b60-6c232f995781@cn.fujitsu.com>
	<9b9cde69-e007-4478-3d20-4e84e1e2582a@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <dacb098a-8a12-4c61-d5f0-1d2fac6c1247@cn.fujitsu.com>
Date: Tue, 23 May 2017 20:06:22 +0800
MIME-Version: 1.0
In-Reply-To: <9b9cde69-e007-4478-3d20-4e84e1e2582a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 01/12] net: Add vnet_hdr_len related
 arguments in NetClientState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 05/16/2017 02:49 PM, Jason Wang wrote:
>
>
> On 2017年05月15日 16:14, Zhang Chen wrote:
>>> Yes and e.g both tap and netmap have its private vnet header field. 
>>> We can remove them too.
>>
>> Maybe I should do this job in this series next version or a 
>> independent series?
>>
>> Thanks
>> Zhang Chen 
>
> Your call.

I will send a independent series after this series have been merged.

Thanks
Zhang Chen

>
> Thanks
>
>
>

-- 
Thanks
Zhang Chen
