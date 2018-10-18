Received: from eggs.gnu.org ([2001:4830:134:3::10]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1gDGEw-0005Wy-8H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1gDGEp-0003Ov-HB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:53:57 -0400
References: <20181018202254.6503-1-lyan@suse.com>
	<bfd797e1-3ae0-f82d-b440-19b97181d113@redhat.com>
From: Liang Yan <lyan@suse.com>
Message-ID: <3852f57d-bdea-cf2b-316d-fc5fc7a49c78@suse.com>
Date: Thu, 18 Oct 2018 17:53:24 -0400
MIME-Version: 1.0
In-Reply-To: <bfd797e1-3ae0-f82d-b440-19b97181d113@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: update
 qemu-iotests/082.out after 9cbef9d68ee
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com



On 10/18/18 4:46 PM, Eric Blake wrote:
> On 10/18/18 3:22 PM, Liang Yan wrote:
>> qemu-img help output is changed after commit 9cbef9d68ee, this is a
>> update for iotests.
>>
>> Signed-off-by: Liang Yan <lyan@suse.com>
>> ---
>>   tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
>>   1 file changed, 478 insertions(+), 478 deletions(-)
> 
> Thanks, but we're still discussing possible other changes to the output:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03042.html
> 

Good to know, and thanks for the reminder.

~Liang
