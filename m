Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYhV-0007kV-5G
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYhU-0005l2-G7
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:55:37 -0400
References: <20180706183051.197403-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <524eb564-bdd6-56c2-a0d5-c27e74a53f76@redhat.com>
Date: Fri, 6 Jul 2018 16:55:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180706183051.197403-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, ronniesahlberg@gmail.com, jcody@redhat.com, pl@kamp.de, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On 07/06/2018 01:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> This fixes image fleecing scheme for 3.0, details are in 04 patch.
> 01 is a significant fix too.
> 
> v4:
> 01: fix copy_range architecture here too
> 02: rebase on 01
> 03: rebase

Hmm - I commented on v3 before seeing you'd already sent v4; my comments 
on grammar suggestions are still applicable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
