Received: from eggs.gnu.org ([2001:4830:134:3::10]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVh2e-0006qh-6e
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVh2Z-0006zW-BW
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:00:24 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVh2Z-0006zM-6J
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:00:19 -0500
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1485186641-12220-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<c5655a23-8995-fa0a-6bb1-48852a17ccd9@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <d96e1c32-95a1-abef-e00f-56bde8791c15@huawei.com>
Date: Mon, 23 Jan 2017 16:59:54 +0100
MIME-Version: 1.0
In-Reply-To: <c5655a23-8995-fa0a-6bb1-48852a17ccd9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 V13] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

On 1/23/2017 4:55 PM, Eric Blake wrote:
> On 01/23/2017 09:50 AM, Pradeep Jagadeesh wrote:
>> This patch removes the redundant throttle code that was present in
>> block and fsdev device files. Now the common code is moved
>> to a single file.
>>
>> ---
>
> You forgot your S-o-b designation.  Also, this is the second thread
> you've sent with a title of v13; please remember to bump the version
> each time you send a new version.  'git send-email -v14' will put in the
> version string automatically (but with lower-case 'v').
>

Hmm..Sure!

Thanks,
Pradeep
