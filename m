Received: from eggs.gnu.org ([2001:4830:134:3::10]:53713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdo6-0006Tg-Bd
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdo3-0000Xp-A4
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1djdo3-0000XP-3t
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:55:15 -0400
References: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<e41d36bc-ed32-8d0d-7fff-bf68fb78707c@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f00fdc9a-6f9a-bae2-78a0-9d1124ca9640@redhat.com>
Date: Mon, 21 Aug 2017 11:55:07 +0800
MIME-Version: 1.0
In-Reply-To: <e41d36bc-ed32-8d0d-7fff-bf68fb78707c@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 2017=E5=B9=B408=E6=9C=8821=E6=97=A5 09:45, Zhang Chen wrote:
> Hi~~ All~
>
> No one review this series for a long time.
>
> Ping...
>
>

Looks ok to me. But I don't like patch 1 since it adds more TODO=20
especially for a non-exist function colo_notify_checkpoint().

I tend to have it after colo_notify_checkpoint() is implemented or merged=
.

Thanks
