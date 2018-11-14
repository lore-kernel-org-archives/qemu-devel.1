Received: from eggs.gnu.org ([2001:4830:134:3::10]:42704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMwT9-0004bN-9J
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMwT2-0000ma-0V
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:48:37 -0500
References: <20181113230319.1008531-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <617cda1f-100b-fa0c-a324-984917967880@redhat.com>
Date: Wed, 14 Nov 2018 08:48:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181113230319.1008531-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 v3 0/3] minor qcow2 compression
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com

On 11/13/18 5:03 PM, Eric Blake wrote:
> As the added iotests shows, we have a (corner case) data corruption
> that is user triggerable, therefore, this is still appropriate for
> inclusion in 3.1.
> 
> v6 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08497.html

Wow, I can't count. That was v7, and this email should be titled v8, not 
v3 ;)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
