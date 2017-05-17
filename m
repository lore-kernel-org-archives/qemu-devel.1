Received: from eggs.gnu.org ([2001:4830:134:3::10]:57983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAsOx-0003Wj-06
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAsOs-000068-3S
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:25:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAsOr-00005a-Tb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:25:34 -0400
References: <1494986980-11277-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e7327e8e-e174-52a5-c2f7-06ddfbb78704@redhat.com>
Date: Wed, 17 May 2017 14:25:27 +0800
MIME-Version: 1.0
In-Reply-To: <1494986980-11277-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 0/3] Optimize filter-mirror and
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>



On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 10:09, Zhang Chen wrote:
> Fix some duplicate codes and remove unused codes.
>
> v3:
>   - Remove the ',' in patch 3/3
>
> v2:
>   - Address Eric's comment fix typo and keep a long lien on patch 3.
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

Applied, thanks.
