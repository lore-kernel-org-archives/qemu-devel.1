Received: from eggs.gnu.org ([2001:4830:134:3::10]:53295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKqJ1-0006R5-5F
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKqIx-00035J-Qm
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eKqIx-00034g-Kg
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A71D9C0587C9
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 18:44:54 +0000 (UTC)
References: <20171201125813.1437-1-quintela@redhat.com>
	<4c899960-36f2-0f0f-bc21-08693f472ba2@redhat.com>
	<34b2798c-9e32-1ae6-943e-afaa621c39c8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1ae6595-4947-bcf5-1b60-81573400a77a@redhat.com>
Date: Fri, 1 Dec 2017 12:44:49 -0600
MIME-Version: 1.0
In-Reply-To: <34b2798c-9e32-1ae6-943e-afaa621c39c8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Add make check tests for Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 12/01/2017 12:38 PM, Laurent Vivier wrote:
> On 01/12/2017 19:30, Eric Blake wrote:
>> On 12/01/2017 06:58 AM, Juan Quintela wrote:
>>> Hi
>>>
>>> This is on top of my info_migrate series.
>>
>> Let patchew know about it:
>>
>> Based-on: <20171201125750.1372-1-quintela@redhat.com>
>> ([PATCH v3 0/2] Improve info migrate output on destination)
> 
> Is this tag documented somewhere?
> 

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01288.html

But yes, it should also be documented in the wiki and/or other places 
where we document patch submission guidelines.

Volunteers?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
