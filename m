Received: from eggs.gnu.org ([2001:4830:134:3::10]:35625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1deeas-0002ft-0R
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1deean-00022J-MY
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:45:02 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:20572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1deean-00021z-Cb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:44:57 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<8e709b24-65f4-3ae4-b8c8-18b2d0a8e8ac@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <adc10dae-00a2-6ea0-17d1-6c55b8c1ad07@huawei.com>
Date: Mon, 7 Aug 2017 11:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <8e709b24-65f4-3ae4-b8c8-18b2d0a8e8ac@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/6] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 7/10/2017 4:41 PM, Eric Blake wrote:
> On 07/04/2017 10:30 AM, Pradeep Jagadeesh wrote:
>> This patch factor out the duplicate throttle code that was present in
>
> s/This patch factor/Factor/
>
> It's okay to write commit messages in the imperative tense; the easiest
> way I know to start a good message is to use an implied "Apply this
> patch to ..." in front of the sentence.  But "Apply this patch to This
> patch ..." obviously doesn't flow, compared to "Apply this patch to
> factor ..."
OK
>
>> block and fsdev devices.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
