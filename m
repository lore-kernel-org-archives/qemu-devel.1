Received: from eggs.gnu.org ([2001:4830:134:3::10]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWHx-00040j-Ow
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWHu-0007ej-NT
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAWHu-0007eZ-HM
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:48:54 -0400
References: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48435f6e-a33e-f245-165e-611db0b9105b@redhat.com>
Date: Tue, 16 May 2017 14:48:49 +0800
MIME-Version: 1.0
In-Reply-To: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND V2 0/3] Optimize filter-mirror and
 filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B405=E6=9C=8815=E6=97=A5 14:18, Zhang Chen wrote:
> Fix some duplicate codes and remove unused codes.
>
> v2: Address Eric's comment on patch 3.
>
> Zhang Chen (3):
>    net/filter-mirror.c: Remove duplicate check code.
>    net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
>    net/filter-rewriter: Remove unused option in filter-rewriter
>
>   net/filter-mirror.c | 35 ++++++++++++++++-------------------
>   qemu-options.hx     |  2 +-
>   2 files changed, 17 insertions(+), 20 deletions(-)
>

Hi:

What's the difference compared with V2? I think I should apply this serie=
s?

Thanks
