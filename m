Received: from eggs.gnu.org ([2001:4830:134:3::10]:43927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGjYV-00047w-DP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGjYR-0007n7-Gb
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:39:27 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:13266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGjYR-0007ja-4Y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:39:23 -0500
Message-ID: <584FC12B.4070005@huawei.com>
Date: Tue, 13 Dec 2016 17:36:43 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
	<20161213093521.GE12730@redhat.com>
In-Reply-To: <20161213093521.GE12730@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/6] crypto: add HMAC algorithms
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

Hi Daniel,

On 2016/12/13 17:35, Daniel P. Berrange wrote:

> On Tue, Dec 13, 2016 at 03:01:47PM +0800, Longpeng(Mike) wrote:
>> Since QEMU has been supported cryptodev, so it is necessary to support
>> more crypto algorithms(i.e. hmac,aead) in QEMU backend.
>>
>> This patchset add HMAC algorithms support.
> 
> Apart from the build failure with glib 2.28, this patch series
> looks fine to me.
> 


Thanks, I will fix it in V4. :)

> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
