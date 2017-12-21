Received: from eggs.gnu.org ([2001:4830:134:3::10]:52881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS5eL-0001dg-BL
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS5eK-0000if-NU
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:32:57 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<87shc4umku.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4c1aa6a-9583-ade6-4ef6-fc060fa5ffcd@redhat.com>
Date: Thu, 21 Dec 2017 12:32:49 -0600
MIME-Version: 1.0
In-Reply-To: <87shc4umku.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, dgilbert@redhat.com

On 12/21/2017 09:28 AM, Markus Armbruster wrote:
> Looks like you forgot to cc: Eric.  Fixing...

Or that he did cc me, and the mailman bug ate the cc line because of my 
list subscription settings.  (Have I mentioned that I hate that mailman 
2 bug, but don't know whether mailman 3 will make it any better?)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
