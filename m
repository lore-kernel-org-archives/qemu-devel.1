Received: from eggs.gnu.org ([2001:4830:134:3::10]:51028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cya5e-0000Pq-OV
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cya5Z-0006Zs-Sg
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:26:54 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:11300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cya5Z-0006ZF-NP
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:26:49 -0400
References: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1490875813-35588-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<w514lxtk6vf.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <47bfdcc2-4945-af0b-9b25-8ccc3d89411a@huawei.com>
Date: Thu, 13 Apr 2017 10:25:46 +0200
MIME-Version: 1.0
In-Reply-To: <w514lxtk6vf.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] Throttle: Create IOThrottle
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 4/12/2017 5:01 PM, Alberto Garcia wrote:
> On Thu 30 Mar 2017 02:10:10 PM CEST, Pradeep Jagadeesh wrote:
>> +##
>> +# == QAPI IOThrottle definitions
>> +##
>> +# @IOThrottle:
>> +#
>> +# A set of parameters describing block
>> +#
>
> "describing block ..." ? There's missing text here.
Hmm..I will fix this.

Regards,
Pradeep
>
> Berto
>
