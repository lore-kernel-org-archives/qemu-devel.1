Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1duFQX-0007hX-Qc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1duFQT-0004QP-ET
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:06:49 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:24115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1duFQT-0004Pz-5M
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:06:45 -0400
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
Date: Tue, 19 Sep 2017 12:06:26 +0200
MIME-Version: 1.0
In-Reply-To: <23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 9/18/2017 7:10 PM, Eric Blake wrote:
> On 09/14/2017 05:40 AM, Pradeep Jagadeesh wrote:
>> This patch factors out code to use the ThrottleLimits
>> strurcture.
>
> s/strurcture/structure/
>
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Echoing the sentiments made elsewhere - this is a significant rewrite
> from the earlier version, so you WANT reviewers to look at it fresh
> rather than assuming that previous reviews still apply.
>
OK, but shall I send them as V12 or V01 again?

-Pradeep
