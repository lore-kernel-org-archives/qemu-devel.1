Received: from eggs.gnu.org ([2001:4830:134:3::10]:56180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fKb4p-0007t4-Sb
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fKb4l-00037W-0m
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fKb4k-00037I-TY
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:01:30 -0400
References: <20180406185125.12536-1-brijesh.singh@amd.com>
	<20180408065347-mutt-send-email-mst@kernel.org>
	<e5a2ff57-a049-42ab-de44-522ec4195406@amd.com>
	<20180517180833-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8e0a275f-18f3-49b9-b50a-207b443f4fd6@redhat.com>
Date: Mon, 21 May 2018 11:01:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180517180833-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] tap: set vhostfd passed from
 qemu cli to non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: Thomas.Lendacky@amd.com, qemu-devel@nongnu.org



On 2018=E5=B9=B405=E6=9C=8817=E6=97=A5 23:08, Michael S. Tsirkin wrote:
> On Thu, May 17, 2018 at 09:54:40AM -0500, Brijesh Singh wrote:
>> Hi Michael and Jason,
>>
>> Looks like this patch was not included in any of your pull request hen=
ce it
>> didn't made into 2.12. Can you please include this patch in your next =
pull
>> request?
>>
>> ~ Brijesh
>
> I reviewed.
> Jason?
> Cc stable I guess ...

Yes. Applied.

Thanks
