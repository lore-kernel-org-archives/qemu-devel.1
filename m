Received: from eggs.gnu.org ([2001:4830:134:3::10]:37654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7m3v-0000rF-He
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7m3t-0006YG-NJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:39:55 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-2-jsnow@redhat.com>
	<f803d9c8-90e0-56c7-320d-0c19d8b5b284@virtuozzo.com>
	<435f5820-c7fd-e1b0-b1d5-26e2a5de9c61@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <557bf5e2-3a47-a041-5062-8d3afa132267@redhat.com>
Date: Wed, 3 Oct 2018 13:39:35 -0500
MIME-Version: 1.0
In-Reply-To: <435f5820-c7fd-e1b0-b1d5-26e2a5de9c61@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/6] block/dirty-bitmaps: add
 user_locked status checker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/3/18 1:28 PM, John Snow wrote:

> 
> Thanks, I'll just make these edits and trust that Eric is fine with it
> as well.

Yes, works for me

> 
> --js
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
