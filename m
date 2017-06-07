Received: from eggs.gnu.org ([2001:4830:134:3::10]:54052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIXHI-0001hL-VM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIXHE-0002pB-0M
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:29:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIXHD-0002on-RF
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:29:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR6006A17OS1H30@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:29:16 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <dc236aea-2015-3384-7a18-a67406df0586@samsung.com>
Date: Wed, 07 Jun 2017 12:29:13 +0300
MIME-version: 1.0
In-reply-to: <20170607092426.GB4314@lemon.lan>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1496820931-27416-10-git-send-email-a.perevalov@samsung.com>
	<149682484945.96.2900136396151676257@7f80c91fe18c>
	<CGME20170607092434epcas3p4d94054fb9aa0c4eb984e7cf4451119cd@epcas3p4.samsung.com>
	<20170607092426.GB4314@lemon.lan>
Subject: Re: [Qemu-devel] [[PATCH V7] 09/11] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

On 06/07/2017 12:24 PM, Fam Zheng wrote:
> On Wed, 06/07 01:40, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details below.
> So what happened is the double '[[' in the subject line confused Patchew, and
> each patch in this series is treated as a standalone patch.
it's not bad to check every patch in sequence separately,
but including previous patches )

>
> Fam
>
>
>

-- 
Best regards,
Alexey Perevalov
