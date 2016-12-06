Received: from eggs.gnu.org ([2001:4830:134:3::10]:54529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEA0k-0000fB-Lg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEA0f-0006uF-Nh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:17:58 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:17866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEA0e-0006sI-9w
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:17:53 -0500
Message-ID: <5846657E.9060001@huawei.com>
Date: Tue, 6 Dec 2016 15:15:10 +0800
From: Gonglei <arei.gonglei@huawei.com>
MIME-Version: 1.0
References: <1480937949-173580-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1480937949-173580-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 0/2] cryptodev: support xts(aes)
 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com



On 2016/12/5 19:39, Longpeng(Mike) wrote:
> This patchset firstly fix a bug in cryptodev_builtin_get_aes_algo, and
> then add xts(aes) algorithm support.
> 
> ---
> Changes since v1:
>   - change macro's defination. [Arei]
> 
> ---
> Longpeng(Mike) (2):
>   cryptodev: fix the check of aes algorithm
>   cryptodev: add xts(aes) support
> 
>  backends/cryptodev-builtin.c | 55 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 14 deletions(-)
> 

Queued, thanks!

Regards,
-Gonglei
