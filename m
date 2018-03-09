Received: from eggs.gnu.org ([2001:4830:134:3::10]:42571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euLIF-0006FH-J3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euLIC-0006QB-T6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:54:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euLIC-0006Q5-OY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:54:52 -0500
References: <20180309091535.13315-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <808d1efc-2db7-01a2-23ba-3af108d9d1e7@redhat.com>
Date: Fri, 9 Mar 2018 10:54:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180309091535.13315-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/23] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 03:15 AM, Peter Xu wrote:
> Based-on: <20180309090006.10018-1-peterx@redhat.com>
> 
> This series is based on the series:
> 
>    [PATCH v8 00/23] QMP: out-of-band (OOB) execution support

Let's spell that in a way patchew understands:

Based-on: <20180309090006.10018-1-peterx@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
