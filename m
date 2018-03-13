Received: from eggs.gnu.org ([2001:4830:134:3::10]:45235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evZDP-0006bF-Nv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evZDP-0001nS-1V
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:58:59 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<8cdd78fa-90e1-16df-8c23-1010fd96e520@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba5c9ccf-4324-9869-ca64-d6d72c36cf98@redhat.com>
Date: Mon, 12 Mar 2018 20:58:36 -0500
MIME-Version: 1.0
In-Reply-To: <8cdd78fa-90e1-16df-8c23-1010fd96e520@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/12/2018 10:28 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.03.2018 18:21, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Here is minimal realization of base:allocation context of NBD
>> block-status extension, which allows to get block status through
>> NBD.
>>
>> v2 changes are in each patch after "---" line.
> 
> Forget to mention the main thing:
> 
> It is based on:
> 
> [PATCH 0/5] nbd server fixing and refactoring before BLOCK_STATUS

Let's spell that in a manner patchew can recognize:
Based-on: <20180308184636.178534-1-vsementsov@virtuozzo.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
