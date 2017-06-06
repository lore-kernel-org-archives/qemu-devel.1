Received: from eggs.gnu.org ([2001:4830:134:3::10]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIAc2-0006KQ-Jt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIAbu-0006ue-Je
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:17:18 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:48613 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dIAbs-0006sX-OW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:17:10 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-20-vsementsov@virtuozzo.com>
	<ca6625b0-1be4-fa44-f6fe-da935621d6b3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8cb8302b-79ae-63c5-f9b1-1dc4c3acfbce@virtuozzo.com>
Date: Tue, 6 Jun 2017 12:17:04 +0300
MIME-Version: 1.0
In-Reply-To: <ca6625b0-1be4-fa44-f6fe-da935621d6b3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 19/19] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>

I'll update this (with removed 11-13) after "nbd refactoring part 1" 
pushed (actually, the first part of these series).

05.06.2017 18:23, Eric Blake wrote:
> [adding Stefan as trace maintainer]
>
> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
[...]


-- 
Best regards,
Vladimir
