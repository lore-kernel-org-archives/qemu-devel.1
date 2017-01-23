Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVhgb-00027S-UH
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVhgX-0003YT-Kv
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:41:41 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVhgX-0003YE-7w
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:41:37 -0500
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<148518739693.56.12407051583748682941@b042e9bf0dd0>
	<20170123172254.345fbecb@bahia.lan>
	<3478b86e-7a32-5e92-58cc-1cfe7ccecb41@huawei.com>
	<bc76a7c9-2951-ff8c-4174-46f8fbc65d47@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <70c2a62c-53d3-b9bf-4525-500184a45b0e@huawei.com>
Date: Mon, 23 Jan 2017 17:41:15 +0100
MIME-Version: 1.0
In-Reply-To: <bc76a7c9-2951-ff8c-4174-46f8fbc65d47@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2 V13] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, pradeepkiruvale@gmail.com
Cc: berto@igalia.com, famz@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com

On 1/23/2017 5:34 PM, Eric Blake wrote:
> On 01/23/2017 10:30 AM, Pradeep Jagadeesh wrote:
>> On 1/23/2017 5:22 PM, Greg Kurz wrote:
>>> On Mon, 23 Jan 2017 08:03:18 -0800 (PST)
>>> no-reply@patchew.org wrote:
>>>> Hi,
>>>>
>>>> Your series seems to have some coding style problems. See output
>>>> below for
>>>> more information:
>>>>
>>>
>> Ya, I observed signoff issue. I have created next version files.
>> I will send them tomorrow.
>>
>> But, I do not know how to solve the second warning.
>> i.e multi line macro issue.
>
> I don't think there is anything to fix there; it is a false positive
> from checkpatch.pl (unless you want to dive in to the perl script and
> figure out how to relax it to allow that usage, as you are not the first
> to have it).  Documenting in the commit message that checkpatch has a
> false-positive warning is acceptable.
>
OK

Thanks,
Pradeep
