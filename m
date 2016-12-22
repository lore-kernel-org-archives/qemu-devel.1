Received: from eggs.gnu.org ([2001:4830:134:3::10]:59038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cJrr5-0000mN-Bs
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 20:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cJrr2-0000k9-5R
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 20:07:35 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:15160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cJrr1-0000iG-O2
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 20:07:32 -0500
Message-ID: <585B2737.8010006@huawei.com>
Date: Thu, 22 Dec 2016 09:07:03 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <20161221143541.9260-1-berrange@redhat.com>
	<20161221143541.9260-4-berrange@redhat.com>
In-Reply-To: <20161221143541.9260-4-berrange@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v1 3/7] crypto: add HMAC algorithms framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Hi Daniel,

Can you pick this patch together ?
[PATCH for-2.9 v4 1/6] configure: add CONFIG_GCRYPT_HMAC item

Or it will be picked by somebody else ?
:)

On 2016/12/21 22:35, Daniel P. Berrange wrote:

> From: "Longpeng(Mike)" <longpeng2@huawei.com>
> 
> This patch introduce HMAC algorithms framework.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
......
> +
> +#endif


-- 
Regards,
Longpeng(Mike)
