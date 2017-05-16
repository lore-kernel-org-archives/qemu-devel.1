Received: from eggs.gnu.org ([2001:4830:134:3::10]:38360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWIr-0004RR-4n
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWIp-0007pq-L6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAWIp-0007ph-Ff
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:49:51 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<80a52ceb-6e69-f4ee-04c7-1219bb7947c1@amsat.org>
	<ed2e0bd5-4a69-63d9-497c-b0b6aaac404d@redhat.com>
	<11a77586-ec42-d1cd-f4d1-f7444cf5febb@cn.fujitsu.com>
	<8bc88f06-105e-db58-9a73-a0b76769ca64@redhat.com>
	<1b884ac2-0cd4-bbd6-0b60-6c232f995781@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b9cde69-e007-4478-3d20-4e84e1e2582a@redhat.com>
Date: Tue, 16 May 2017 14:49:43 +0800
MIME-Version: 1.0
In-Reply-To: <1b884ac2-0cd4-bbd6-0b60-6c232f995781@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B405=E6=9C=8815=E6=97=A5 16:14, Zhang Chen wrote:
>> Yes and e.g both tap and netmap have its private vnet header field.=20
>> We can remove them too.
>
> Maybe I should do this job in this series next version or a=20
> independent series?
>
> Thanks
> Zhang Chen=20

Your call.

Thanks
