Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxkFm-0003vM-CG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxkFi-00025n-9K
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:05:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3032
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxkFh-00023J-Rf
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:05:50 -0400
Message-ID: <58EC2BD6.9050309@huawei.com>
Date: Tue, 11 Apr 2017 09:05:26 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1491814757-62684-1-git-send-email-longpeng2@huawei.com>
	<54cc08ec-ecd1-74f6-5a5a-d4df94dd6758@redhat.com>
In-Reply-To: <54cc08ec-ecd1-74f6-5a5a-d4df94dd6758@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 01/19] crypto: cipher: introduce
 context free function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: berrange@redhat.com, xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org



On 2017/4/10 23:01, Eric Blake wrote:

> On 04/10/2017 03:59 AM, Longpeng(Mike) wrote:
>> Refactors the qcrypto_cipher_free(), splits it into two parts. One
>> is gcrypt/nettle__cipher_free_ctx() to free the special context.
> 
> Your mail forgot to include 'In-Reply-To:' and 'References:' headers;
> and therefore you resulted in sending 20 top-level threads instead of 19
> replies to the 0/19 cover letter (the one with Message-ID:
> <1491814997-58268-1-git-send-email-longpeng2@huawei.com>).  Please fix
> your setup for sending patch series, as it gets very hard to follow
> improperly threaded series.


OK, I'll fix it. thx.

> 


-- 
Regards,
Longpeng(Mike)
