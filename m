Received: from eggs.gnu.org ([2001:4830:134:3::10]:58790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dn4gE-0004O3-8n
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dn4gA-0001WX-SK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:13:22 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:22459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dn4gA-0001Vz-Ib
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:13:18 -0400
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuc98di8.fsf@maestria.local.igalia.com>
	<9b24c28f-f891-1046-f09f-bffded9e316f@huawei.com>
	<w51bmmx85so.fsf@maestria.local.igalia.com>
	<f6cdc881-39a4-92f6-c218-a57516ca0921@huawei.com>
	<w518ti1851v.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <f44d823d-d7a6-1783-051f-9d754ada0475@huawei.com>
Date: Wed, 30 Aug 2017 17:12:22 +0200
MIME-Version: 1.0
In-Reply-To: <w518ti1851v.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 8/30/2017 5:10 PM, Alberto Garcia wrote:
> On Wed 30 Aug 2017 05:07:29 PM CEST, Pradeep Jagadeesh wrote:
>
>> Thanks for the steps, I did reproduce the issue easily. Looking into
>> the code, may be we also need to try the same with the block devices.
>
> I did some tests and it was working fine, so I'd suspect of the fsdev
> code first.
>
OK, thanks for the clarification. I will look into fsdev code.

-Pradeep
> Berto
>
