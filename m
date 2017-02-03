Received: from eggs.gnu.org ([2001:4830:134:3::10]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZdGq-0004HL-Qn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZdGn-0005TI-Nb
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:47:20 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZdGn-0005Rf-EU
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:47:17 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51inorwjjx.fsf@maestria.local.igalia.com>
	<136bc6e7-10af-479a-6c29-c783a833cc9a@huawei.com>
	<w51fujvwijb.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <114ea531-56b8-07ea-feb9-274593797747@huawei.com>
Date: Fri, 3 Feb 2017 13:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <w51fujvwijb.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v16] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On 2/3/2017 1:44 PM, Alberto Garcia wrote:
> On Fri 03 Feb 2017 01:27:25 PM CET, Pradeep Jagadeesh wrote:
>
>>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04637.html
>>>
>>> This line doesn't belong in the commit message.
>>
>> There is one false positive error in the second patch. So Greg asked
>> me to put this line after SoB. Just to say that I had a positive
>> review comment.
>
> The false positive is not related to what Greg said :-) What you have to
> put is not that URL but the Reviewed-by: line with Stefan's name and
> e-mail.

Haha OK. I will change it and send new patch set again.

-Pradeep
>
> Berto
>
