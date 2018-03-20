Received: from eggs.gnu.org ([2001:4830:134:3::10]:33367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKCH-0001HE-Qg
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKCE-0001LP-NM
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:33:13 -0400
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
	<20180319090223.23336-4-vsementsov@virtuozzo.com>
	<ad6bb9d8-559c-58dc-6bbb-aa8b2feaa85b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <10fc84c0-3f60-bc07-b04e-7789168dc5c1@virtuozzo.com>
Date: Tue, 20 Mar 2018 19:33:00 +0300
MIME-Version: 1.0
In-Reply-To: <ad6bb9d8-559c-58dc-6bbb-aa8b2feaa85b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/3] iotests: enable shared migration
 cases in 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

20.03.2018 17:01, Max Reitz wrote:
> On 2018-03-19 10:02, Vladimir Sementsov-Ogievskiy wrote:
>> Shared migration for dirty bitmaps is fixed by previous patches,
>> so we can enable the test.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/169 | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
> Isn't this missing some changes to 169.out (because the number of tests
> is doubled)?
>
> Max

Oh, yes, forget to add it.

-- 
Best regards,
Vladimir
