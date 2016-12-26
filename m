Received: from eggs.gnu.org ([2001:4830:134:3::10]:56412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cLPfS-00034q-SN
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 02:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cLPfP-0004b7-Oo
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 02:25:58 -0500
References: <1480575357-25056-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<a1593129-ddb9-8e74-5865-b1e8400c991d@redhat.com>
	<8b90a1da-a129-f2cb-4545-355348387925@cn.fujitsu.com>
	<063dfa33-2015-e566-c623-d59578c20fcd@redhat.com>
	<13aed710-c5d1-b1de-5922-52e3e53029f9@cn.fujitsu.com>
	<956d6c43-0904-e094-1adb-bb7c584967d0@vivier.eu>
	<20161207133049.GA32099@stefanha-x1.localdomain>
	<fc30a10e-10d5-6b53-d098-f00780cdbe16@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <5dd2f20f-07dd-5120-13bf-ea5700880ecf@cn.fujitsu.com>
Date: Mon, 26 Dec 2016 15:26:12 +0800
MIME-Version: 1.0
In-Reply-To: <fc30a10e-10d5-6b53-d098-f00780cdbe16@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.9] docs: Fix
 description of the sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, qemu devel <qemu-devel@nongnu.org>

Hi~~ Jason.

Can you pick up this patch?

Thanks

Zhang Chen


On 12/08/2016 09:32 AM, Zhang Chen wrote:
>
>
> On 12/07/2016 09:30 PM, Stefan Hajnoczi wrote:
>> On Wed, Dec 07, 2016 at 10:01:49AM +0100, Laurent Vivier wrote:
>>> Le 07/12/2016 à 09:58, Zhang Chen a écrit :
>>>>
>>>> On 12/02/2016 03:57 PM, Laurent Vivier wrote:
>>>>> On 02/12/2016 03:59, Zhang Chen wrote:
>>>>>> On 12/01/2016 10:57 PM, Eric Blake wrote:
>>>>>>> On 12/01/2016 12:55 AM, Zhang Chen wrote:
>>>>>>>> Say it in another way to make it easier to understand.
>>>>>>>>
>>>>>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>>>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>>>>> I guess that's because I suggested the replacement text to use, 
>>>>>>> even
>>>>>>> though I didn't write the patch.
>>>>>> Yes, In that case, should I change the signed-off-by to acked-by or
>>>>>> remove it?
>>>>> You can use "Suggested-by:"
>>>>>
>>>>> https://www.kernel.org/doc/Documentation/SubmittingPatches
>>>>>
>>>>> Laurent
>>>>>
>>>> Should I fix it? or can you pick up this directly for 2.8?
>>> I don't think it is needed.
>>> Perhaps Stefan H can take it directly in his staging tree?
>> Too late for that now.  This should be merged through Jason Wang (net
>> maintainer) like any other colo-proxy patch.
>>
>
> OK~ I change the subject to "for-2.9" and cc Jason.
>
> Thanks
> Zhang Chen
>
>

-- 
Thanks
Zhang Chen
