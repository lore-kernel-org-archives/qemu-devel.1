Received: from eggs.gnu.org ([2001:4830:134:3::10]:52765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS1Pi-0005lK-8T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS1Pc-00005k-Lp
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:01:34 -0500
References: <20171221013600.17648-1-eblake@redhat.com>
	<20171221013600.17648-5-eblake@redhat.com>
	<47a78a6e-cc5b-5ac5-1f80-222ecb4ee8c4@virtuozzo.com>
	<8efcad22-de4d-8158-caaa-279bad992648@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76e1ae9f-77f2-b4f5-5233-061ea07ddaf9@redhat.com>
Date: Thu, 21 Dec 2017 08:01:12 -0600
MIME-Version: 1.0
In-Reply-To: <8efcad22-de4d-8158-caaa-279bad992648@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] STOP Re: [PULL 4/4] qmp: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 12/21/2017 03:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> look at "[PATCH v2 0/6] nbd export qmp interface"
> 
> 21.12.2017 12:07, Vladimir Sementsov-Ogievskiy wrote:
>> no, I've updated it, we discussed with Kevin that this approach is bad
>>

I'll respin the pull request with the updated series; thanks for the catch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
